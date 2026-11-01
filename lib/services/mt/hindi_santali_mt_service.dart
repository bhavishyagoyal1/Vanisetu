import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import 'package:onnxruntime/onnxruntime.dart';
import 'package:path_provider/path_provider.dart';

import 'bpe_tokenizer.dart';
import 'indic_preprocessor.dart';

/// Offline Hindi -> Santali (Ol Chiki) neural machine translation, using the
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

      final paths = <String, String>{};
      for (final name in _assetFiles) {
        final file = File('${modelDir.path}/$name');
        paths[name] = file.path;
        if (!await file.exists()) {
          debugPrint('HindiSantaliMtService: extracting $name…');
          final data = await rootBundle.load('$_assetDir/$name');
          await file.writeAsBytes(
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          );
        }
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
  Future<String> translate(String text) async {
    await _ensureInitialized();
    final encoder = _encoder!;
    final decoder = _decoder!;
    final decoderWithPast = _decoderWithPast!;
    final srcTokenizer = _srcTokenizer!;
    final tgtTokenizer = _tgtTokenizer!;

    final pre = _preprocessor.preprocess(text);
    final srcVocab = srcTokenizer.vocab;
    final srcLangId = srcVocab['hin_Deva'];
    final tgtLangId = srcVocab['sat_Olck'];
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
        final lastStepLogits = (logits[0] as List).last as List;
        var bestId = 0;
        var bestScore = double.negativeInfinity;
        for (var i = 0; i < lastStepLogits.length; i++) {
          final score = (lastStepLogits[i] as num).toDouble();
          if (score > bestScore) {
            bestScore = score;
            bestId = i;
          }
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
