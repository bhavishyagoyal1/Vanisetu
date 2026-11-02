import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import 'package:onnxruntime/onnxruntime.dart';
import 'package:path_provider/path_provider.dart';

import 'bpe_tokenizer.dart';
import '../model_assets.dart';
import 'indic_preprocessor.dart';

/// Offline Hindi <-> Santali (Ol Chiki) neural machine translation, using the
/// ONNX export of AI4Bharat's IndicTrans2 (indic-indic-dist-320M, INT8) that
/// ships in `models/indic_translate/`. See that folder's README.md for
/// provenance, and [IndicPreprocessor] / [BpeTokenizer] for the two pieces
/// this pipeline was reconstructed from (both verified against the actual
/// reference implementation — see their doc comments).
///
/// This is a from-scratch reimplementation of `translate.py`'s
/// `IndicTransONNX.translate()`: encoder -> greedy decoder loop with a
/// KV-cache, using the `onnxruntime` Flutter plugin directly against the
/// three ONNX graphs (encoder, decoder, decoder-with-past). Verified against
/// the actual `.onnx` graphs (not just the Python source) for exact
/// input/output tensor names: 18 transformer layers, decoder step 0 uses
/// `decoder_model.onnx` (needs `encoder_hidden_states`), every step after
/// uses `decoder_with_past_model.onnx` (needs `past_key_values.*` — fed by
/// renaming the previous step's `present.*` outputs).
///
/// Bidirectional: `models/SantaliHindiTranslation/` turned out to be a
/// byte-for-byte identical copy of this same model bundle (verified by
/// SHA-256 — every .onnx/.onnx.data/tokenizer file matches exactly). This
/// is AI4Bharat's "indic-indic" IndicTrans2, a single multilingual model
/// covering many Indic language pairs in both directions, not a
/// Hindi->Santali-only model — so Santali->Hindi needs no extra bundled
/// assets, just different language tags on the same sessions. Verified by
/// running the reference Python pipeline on known-good Santali strings and
/// confirming sensible Hindi came back out (two exact round-trips, one
/// close paraphrase) before writing this.
class HindiSantaliMtService {
  HindiSantaliMtService._();
  static final HindiSantaliMtService instance = HindiSantaliMtService._();

  static const _maxNewTokens = 128;
  static const _assetDir = 'assets/models/mt';
  static const _assetFiles = [
    'encoder_model.onnx',
    'encoder_model.onnx.data',
    'decoder_model.onnx',
    'decoder_with_past_model.onnx',
    'decoder_shared.onnx.data',
    'tokenizer_src.json',
    'tokenizer_tgt.json',
    'tokenizer_meta.json',
    'generation_config.json',
  ];

  static const _hindiTag = 'hin_Deva';
  static const _santaliTag = 'sat_Olck';

  OrtSession? _encoder;
  OrtSession? _decoder;
  OrtSession? _decoderWithPast;
  BpeTokenizer? _srcTokenizer;
  BpeTokenizer? _tgtTokenizer;

  int _srcDictSize = 0;
  int _tgtDictSize = 0;
  int _unkId = 3;
  int _decoderStartId = 2;
  int _eosId = 2;
  int _padId = 1;

  bool _initializing = false;
  bool get isReady => _encoder != null;

  final _preprocessor = IndicPreprocessor();

  /// Copies the bundled model files to disk.
  ///
  /// **Root isolate only** — it reads the asset bundle, which needs a
  /// ServicesBinding. [InferenceIsolate] calls this before it dispatches any
  /// translation, so the worker isolate only ever opens files.
  Future<void> prepareAssets() async {
    final supportDir = await getApplicationSupportDirectory();
    await extractModelAssets(
      bundle: rootBundle,
      targetDir: Directory('${supportDir.path}/mt_model'),
      assetKeys: [for (final name in _assetFiles) '$_assetDir/$name'],
    );
  }

  Future<void> _ensureInitialized() async {
    if (isReady) return;
    if (_initializing) {
      while (_initializing) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
      return;
    }

    _initializing = true;
    try {
      debugPrint('HindiSantaliMtService: initializing…');
      final supportDir = await getApplicationSupportDirectory();
      final modelDir = Directory('${supportDir.path}/mt_model');
      if (!await modelDir.exists()) {
        await modelDir.create(recursive: true);
      }

      // Read-only from here: the files are put in place by [prepareAssets],
      // which runs on the root isolate. Touching rootBundle here would throw
      // "Binding has not yet been initialized", because this runs on the
      // inference isolate where no ServicesBinding exists.
      final paths = <String, String>{};
      for (final name in _assetFiles) {
        final file = File('${modelDir.path}/$name');
        if (!await file.exists()) {
          throw StateError(
            'MT asset $name was not extracted before use. '
            'InferenceIsolate must call prepareAssets() on the root isolate '
            'first — see model_assets.dart.',
          );
        }
        paths[name] = file.path;
      }

      _srcTokenizer = BpeTokenizer.fromJson(
        jsonDecode(await File(paths['tokenizer_src.json']!).readAsString())
            as Map<String, dynamic>,
      );
      _tgtTokenizer = BpeTokenizer.fromJson(
        jsonDecode(await File(paths['tokenizer_tgt.json']!).readAsString())
            as Map<String, dynamic>,
      );
      final meta =
          jsonDecode(await File(paths['tokenizer_meta.json']!).readAsString())
              as Map<String, dynamic>;
      _srcDictSize = meta['src_dict_size'] as int;
      _tgtDictSize = meta['tgt_dict_size'] as int;
      _unkId = meta['unk_id'] as int;

      final genConfig =
          jsonDecode(
                await File(paths['generation_config.json']!).readAsString(),
              )
              as Map<String, dynamic>;
      _decoderStartId = genConfig['decoder_start_token_id'] as int;
      _eosId = genConfig['eos_token_id'] as int;
      _padId = genConfig['pad_token_id'] as int;

      final options = OrtSessionOptions()..setIntraOpNumThreads(2);
      debugPrint('HindiSantaliMtService: loading ONNX sessions…');
      _encoder = OrtSession.fromFile(
        File(paths['encoder_model.onnx']!),
        options,
      );
      _decoder = OrtSession.fromFile(
        File(paths['decoder_model.onnx']!),
        options,
      );
      _decoderWithPast = OrtSession.fromFile(
        File(paths['decoder_with_past_model.onnx']!),
        options,
      );
      debugPrint('HindiSantaliMtService: ready');
    } catch (e, st) {
      debugPrint('HindiSantaliMtService: init failed: $e\n$st');
      rethrow;
    } finally {
      _initializing = false;
    }
  }

  /// Translates Hindi [text] to Santali (Ol Chiki script). Loads the model
  /// on first call (a few hundred MB to extract from assets once, then a
  /// couple of seconds to build the ONNX sessions) and keeps it resident.
  Future<String> translate(String text) =>
      _translate(text, srcLang: _hindiTag, tgtLang: _santaliTag);

  /// Translates Santali (Ol Chiki) [text] to Hindi — the reverse direction,
  /// on the same loaded sessions (see class doc comment for why no extra
  /// model needs to be bundled for this).
  Future<String> translateToHindi(String text) =>
      _translate(text, srcLang: _santaliTag, tgtLang: _hindiTag);

  Future<String> _translate(
    String text, {
    required String srcLang,
    required String tgtLang,
  }) async {
    await _ensureInitialized();
    final encoder = _encoder!;
    final decoder = _decoder!;
    final decoderWithPast = _decoderWithPast!;
    final srcTokenizer = _srcTokenizer!;
    final tgtTokenizer = _tgtTokenizer!;

    final pre = _preprocessor.preprocess(text);
    final srcVocab = srcTokenizer.vocab;
    final srcLangId = srcVocab[srcLang];
    final tgtLangId = srcVocab[tgtLang];
    if (srcLangId == null || tgtLangId == null) {
      throw StateError('Language tags missing from source tokenizer vocab.');
    }

    final ids = <int>[
      srcLangId,
      tgtLangId,
      ...srcTokenizer
          .encode(pre.text)
          .map((id) => id < _srcDictSize ? id : _unkId),
      _eosId,
    ];
    final attentionMask = List<int>.filled(ids.length, 1);

    final runOptions = OrtRunOptions();
    final inputIdsTensor = OrtValueTensor.createTensorWithDataList(ids, [
      1,
      ids.length,
    ]);
    final attentionMaskTensor = OrtValueTensor.createTensorWithDataList(
      attentionMask,
      [1, attentionMask.length],
    );

    final toRelease = <OrtValue>[inputIdsTensor, attentionMaskTensor];
    OrtValueTensor? decoderInputIds;
    Map<String, OrtValue> pastFeed = {};

    try {
      final encoderOutputs = encoder.run(runOptions, {
        'input_ids': inputIdsTensor,
        'attention_mask': attentionMaskTensor,
      });
      final encoderHiddenStates = encoderOutputs[0]!;
      toRelease.add(encoderHiddenStates);

      final outputIds = <int>[_decoderStartId];
      // Anti-repetition guard (HF's standard no_repeat_ngram_size, n=3):
      // greedy decoding on short/isolated input can loop forever on a
      // single token or a short cycle of a few tokens (verified during
      // dictionary content generation — e.g. a bare "namaste" decoded to a
      // repeating 2-token cycle ~25 times over). Block any candidate that
      // would recreate a trigram already seen earlier in this sequence,
      // falling back to the next-best candidate (bounded retries, so this
      // can't loop forever itself).
      final seenTrigrams = <List<int>>{};
      bool trigramSeen(int a, int b, int c) =>
          seenTrigrams.any((t) => t[0] == a && t[1] == b && t[2] == c);

      decoderInputIds = OrtValueTensor.createTensorWithDataList(
        [_decoderStartId],
        [1, 1],
      );

      var usePast = false;
      for (var step = 0; step < _maxNewTokens; step++) {
        final List<OrtValue?> outputs;
        final List<String> outputNames;
        if (!usePast) {
          outputs = decoder.run(runOptions, {
            'input_ids': decoderInputIds!,
            'encoder_attention_mask': attentionMaskTensor,
            'encoder_hidden_states': encoderHiddenStates,
          });
          outputNames = decoder.outputNames;
        } else {
          outputs = decoderWithPast.run(runOptions, {
            'input_ids': decoderInputIds!,
            'encoder_attention_mask': attentionMaskTensor,
            ...pastFeed,
          });
          outputNames = decoderWithPast.outputNames;
        }

        final logits = outputs[0]!.value as List;
        final lastStepLogits = List<double>.from(
          ((logits[0] as List).last as List).map((v) => (v as num).toDouble()),
        );

        var bestId = 0;
        for (var attempt = 0; attempt < 8; attempt++) {
          bestId = 0;
          var bestScore = double.negativeInfinity;
          for (var i = 0; i < lastStepLogits.length; i++) {
            final score = lastStepLogits[i];
            if (score > bestScore) {
              bestScore = score;
              bestId = i;
            }
          }
          if (outputIds.length < 2) break;
          final a = outputIds[outputIds.length - 2];
          final b = outputIds[outputIds.length - 1];
          if (!trigramSeen(a, b, bestId)) break;
          lastStepLogits[bestId] = double.negativeInfinity;
        }
        if (outputIds.length >= 2) {
          seenTrigrams.add([
            outputIds[outputIds.length - 2],
            outputIds[outputIds.length - 1],
            bestId,
          ]);
        }
        outputs[0]!.release();

        final newPastFeed = <String, OrtValue>{};
        for (var i = 1; i < outputNames.length; i++) {
          final value = outputs[i];
          if (value == null) continue;
          newPastFeed[outputNames[i].replaceFirst(
                'present.',
                'past_key_values.',
              )] =
              value;
        }
        for (final value in pastFeed.values) {
          value.release();
        }
        pastFeed = newPastFeed;

        outputIds.add(bestId);
        decoderInputIds.release();
        decoderInputIds = OrtValueTensor.createTensorWithDataList(
          [bestId],
          [1, 1],
        );

        usePast = true;
        if (bestId == _eosId) break;
      }

      final safeIds = outputIds
          .where((id) => id != _decoderStartId && id != _eosId && id != _padId)
          .map((id) => id < _tgtDictSize ? id : _unkId)
          .toList();
      final rawDecoded = tgtTokenizer.decode(safeIds);
      return _preprocessor.postprocess(rawDecoded, pre.placeholders);
    } finally {
      for (final value in toRelease) {
        value.release();
      }
      decoderInputIds?.release();
      for (final value in pastFeed.values) {
        value.release();
      }
      runOptions.release();
    }
  }

  void dispose() {
    _encoder?.release();
    _decoder?.release();
    _decoderWithPast?.release();
    _encoder = null;
    _decoder = null;
    _decoderWithPast = null;
  }
}
