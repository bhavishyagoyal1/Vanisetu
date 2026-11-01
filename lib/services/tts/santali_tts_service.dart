import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import 'package:onnxruntime/onnxruntime.dart';
import 'package:path_provider/path_provider.dart';

/// Offline Santali (Ol Chiki) text-to-speech using a Piper (VITS) ONNX voice
/// model — see `models/SantaliVoice/app.py` for provenance.
///
/// Ported from the real `piper-tts` Python package (`piper.phoneme_ids`,
/// `piper.voice.PiperVoice`), read directly from the installed package
/// source rather than guessed. This voice's `phoneme_type` is `"text"`
/// (character-level): no espeak-ng phonemizer is needed — `piper.voice.
/// PiperVoice.phonemize()` for that type is just
/// `list(unicodedata.normalize("NFD", text))`. NFD is skipped here: Ol
/// Chiki (U+1C50-1C7F) has no canonical decompositions in the Unicode
/// Character Database, so normalizing is a no-op for this script.
///
/// Encoding (verified against `piper/phoneme_ids.py`'s `phonemes_to_ids`):
/// every character's id is followed by the pad id, the whole sequence
/// bookended by BOS/EOS — `[BOS, PAD, id(ch1), PAD, id(ch2), PAD, ..., EOS]`.
///
/// ONNX I/O (verified directly against the graph): `input` (int64 phoneme
/// ids `[1,N]`), `input_lengths` (int64 `[1]`), `scales` (float32 `[3]` =
/// `[noise_scale, length_scale, noise_w_scale]`, from the voice config's
/// `inference` block) -> `output` (float32 waveform, single speaker, no
/// `sid` input needed since this voice's `num_speakers` is 1).
class SantaliTtsService {
  SantaliTtsService._();
  static final SantaliTtsService instance = SantaliTtsService._();

  static const _assetDir = 'assets/models/tts';
  static const _modelAsset = '$_assetDir/sat_piper_model.onnx';
  static const _configAsset = '$_assetDir/sat_piper_model.onnx.json';

  static const _pad = '_';
  static const _bos = '^';
  static const _eos = r'$';

  OrtSession? _session;
  Map<String, int>? _phonemeIdMap;
  int _sampleRate = 16000;
  double _noiseScale = 0.667;
  double _lengthScale = 1.0;
  double _noiseWScale = 0.8;

  bool _initializing = false;
  bool get isReady => _session != null;

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
      debugPrint('SantaliTtsService: initializing…');
      final supportDir = await getApplicationSupportDirectory();
      final modelDir = Directory('${supportDir.path}/tts_model');
      if (!await modelDir.exists()) {
        await modelDir.create(recursive: true);
      }

      final modelFile = File('${modelDir.path}/sat_piper_model.onnx');
      if (!await modelFile.exists()) {
        debugPrint('SantaliTtsService: extracting model asset…');
        final data = await rootBundle.load(_modelAsset);
        await modelFile.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        );
      }

      final config =
          jsonDecode(await rootBundle.loadString(_configAsset))
              as Map<String, dynamic>;
      final rawIdMap = config['phoneme_id_map'] as Map<String, dynamic>;
      _phonemeIdMap = {
        for (final entry in rawIdMap.entries)
          entry.key: (entry.value as List)[0] as int,
      };
      _sampleRate =
          (config['audio'] as Map<String, dynamic>)['sample_rate'] as int;
      final inference = config['inference'] as Map<String, dynamic>;
      _noiseScale = (inference['noise_scale'] as num).toDouble();
      _lengthScale = (inference['length_scale'] as num).toDouble();
      _noiseWScale = (inference['noise_w'] as num).toDouble();

      final options = OrtSessionOptions()..setIntraOpNumThreads(2);
      debugPrint('SantaliTtsService: loading ONNX session…');
      _session = OrtSession.fromFile(modelFile, options);
      debugPrint('SantaliTtsService: ready');
    } catch (e, st) {
      debugPrint('SantaliTtsService: init failed: $e\n$st');
      rethrow;
    } finally {
      _initializing = false;
    }
  }

  List<int> _textToIds(String text) {
    final map = _phonemeIdMap!;
    final padId = map[_pad]!;
    final ids = <int>[map[_bos]!, padId];
    // Iterate Unicode codepoints (runes), not UTF-16 code units, so no
    // character is split — matters for Ol Chiki, which sits outside the
    // BMP-adjacent range some of these characters could otherwise be
    // mistaken for; here they're all single UTF-16 units, but this stays
    // correct if that ever changes upstream.
    for (final rune in text.runes) {
      final id = map[String.fromCharCode(rune)];
      if (id == null)
        continue; // unmapped char: drop, matching piper's warn-and-skip
      ids.add(id);
      ids.add(padId);
    }
    ids.add(map[_eos]!);
    return ids;
  }

  List<double> _flattenToDoubles(dynamic nested) {
    final out = <double>[];
    void walk(dynamic node) {
      if (node is List) {
        for (final child in node) {
          walk(child);
        }
      } else {
        out.add((node as num).toDouble());
      }
    }

    walk(nested);
    return out;
  }

  Uint8List _pcm16Wav(List<double> samples, int sampleRate) {
    final dataBytes = Uint8List(samples.length * 2);
    final dataView = ByteData.sublistView(dataBytes);
    for (var i = 0; i < samples.length; i++) {
      final sample = (samples[i].clamp(-1.0, 1.0) * 32767.0).round().clamp(
        -32768,
        32767,
      );
      dataView.setInt16(i * 2, sample, Endian.little);
    }

    const headerSize = 44;
    final wav = Uint8List(headerSize + dataBytes.length);
    final view = ByteData.sublistView(wav);
    void writeAscii(int offset, String s) {
      wav.setRange(offset, offset + s.length, ascii.encode(s));
    }

    const byteRate = 2; // bytes per sample (16-bit mono)
    writeAscii(0, 'RIFF');
    view.setUint32(4, 36 + dataBytes.length, Endian.little);
    writeAscii(8, 'WAVE');
    writeAscii(12, 'fmt ');
    view.setUint32(16, 16, Endian.little); // fmt chunk size
    view.setUint16(20, 1, Endian.little); // PCM
    view.setUint16(22, 1, Endian.little); // mono
    view.setUint32(24, sampleRate, Endian.little);
    view.setUint32(28, sampleRate * byteRate, Endian.little); // byte rate
    view.setUint16(32, byteRate, Endian.little); // block align
    view.setUint16(34, 16, Endian.little); // bits per sample
    writeAscii(36, 'data');
    view.setUint32(40, dataBytes.length, Endian.little);
    wav.setRange(headerSize, wav.length, dataBytes);
    return wav;
  }

  /// Synthesizes [text] (Santali, Ol Chiki script) into 16-bit PCM mono WAV
  /// bytes at the voice model's native sample rate.
  Future<Uint8List> synthesizeWav(String text) async {
    await _ensureInitialized();
    final session = _session!;
    final ids = _textToIds(text);

    final inputTensor = OrtValueTensor.createTensorWithDataList(ids, [
      1,
      ids.length,
    ]);
    final lengthsTensor = OrtValueTensor.createTensorWithDataList(
      [ids.length],
      [1],
    );
    final scalesTensor = OrtValueTensor.createTensorWithDataList(
      Float32List.fromList([_noiseScale, _lengthScale, _noiseWScale]),
      [3],
    );
    final runOptions = OrtRunOptions();

    try {
      final outputs = session.run(runOptions, {
        'input': inputTensor,
        'input_lengths': lengthsTensor,
        'scales': scalesTensor,
      });
      final samples = _flattenToDoubles(outputs[0]!.value);
      outputs[0]!.release();
      return _pcm16Wav(samples, _sampleRate);
    } finally {
      inputTensor.release();
      lengthsTensor.release();
      scalesTensor.release();
      runOptions.release();
    }
  }

  void dispose() {
    _session?.release();
    _session = null;
  }
}
