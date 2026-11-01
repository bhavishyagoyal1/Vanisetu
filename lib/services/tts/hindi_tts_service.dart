import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import 'package:onnxruntime/onnxruntime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piper_phonemize/piper_phonemize.dart' as piper;

/// Offline Hindi text-to-speech using a Piper (VITS) ONNX voice model — see
/// `models/HindiTTS/app.py` for provenance.
///
/// Unlike [SantaliTtsService]'s voice, this one's `phoneme_type` is
/// `"espeak"` (confirmed in `hi_IN-pratham-medium.onnx.json`): Devanagari
/// needs real grapheme-to-phoneme conversion (schwa deletion, conjuncts),
/// which a simple character map can't do, so this voice needs actual
/// espeak-ng phonemization rather than the Santali voice's raw-codepoint
/// scheme. `piper_phonemize` (a published Flutter FFI plugin by the same
/// author as `sherpa_onnx`, which this app already depends on) wraps
/// espeak-ng and bundles its language data as Flutter assets, extracted to
/// a real filesystem directory via its own `extractEspeakNgData()` helper —
/// verified against its actual Flutter example, not guessed.
///
/// Everything past phonemization (id interleaving, ONNX I/O, WAV encoding)
/// is the same Piper contract as [SantaliTtsService] — see that class's
/// doc comment for the verified BOS/PAD/EOS scheme and tensor shapes.
class HindiTtsService {
  HindiTtsService._();
  static final HindiTtsService instance = HindiTtsService._();

  static const _assetDir = 'assets/models/tts';
  static const _modelAsset = '$_assetDir/hi_IN-pratham-medium.onnx';
  static const _configAsset = '$_assetDir/hi_IN-pratham-medium.onnx.json';

  static const _pad = '_';
  static const _bos = '^';
  static const _eos = r'$';
  static const _espeakVoice = 'hi';

  OrtSession? _session;
  Map<String, int>? _phonemeIdMap;
  int _sampleRate = 22050;
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
      debugPrint('HindiTtsService: initializing…');

      debugPrint('HindiTtsService: loading espeak-ng…');
      piper.initBindings();
      final dataDir = await piper.extractEspeakNgData();
      final initResult = piper.PiperPhonemize.initialize(dataDir);
      if (initResult < 0) {
        throw StateError('espeak-ng initialization failed (code $initResult)');
      }

      final supportDir = await getApplicationSupportDirectory();
      final modelDir = Directory('${supportDir.path}/hindi_tts_model');
      if (!await modelDir.exists()) {
        await modelDir.create(recursive: true);
      }

      final modelFile = File('${modelDir.path}/hi_IN-pratham-medium.onnx');
      if (!await modelFile.exists()) {
        debugPrint('HindiTtsService: extracting model asset…');
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
      debugPrint('HindiTtsService: loading ONNX session…');
      _session = OrtSession.fromFile(modelFile, options);
      debugPrint('HindiTtsService: ready');
    } catch (e, st) {
      debugPrint('HindiTtsService: init failed: $e\n$st');
      rethrow;
    } finally {
      _initializing = false;
    }
  }

  List<int> _phonemesToIds(List<int> phonemeCodepoints) {
    final map = _phonemeIdMap!;
    final padId = map[_pad]!;
    final ids = <int>[map[_bos]!, padId];
    for (final codepoint in phonemeCodepoints) {
      final id = map[String.fromCharCode(codepoint)];
      if (id == null)
        continue; // unmapped phoneme: drop, matching piper's warn-and-skip
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

  /// Runs one phoneme-id sequence through the ONNX VITS graph, returning
  /// raw float samples in [-1, 1].
  List<double> _runModel(List<int> ids) {
    final session = _session!;
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
      return samples;
    } finally {
      inputTensor.release();
      lengthsTensor.release();
      scalesTensor.release();
      runOptions.release();
    }
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

  /// Synthesizes [text] (Hindi) into 16-bit PCM mono WAV bytes at the voice
  /// model's native sample rate. Piper/espeak-ng splits input into
  /// sentences and synthesizes each independently (verified against the
  /// real `piper.voice.PiperVoice.synthesize()`, which does the same and
  /// concatenates the resulting audio chunks) — matched here rather than
  /// treating the whole input as one unit, since that's what the Santali
  /// voice's simpler character-level scheme did.
  Future<Uint8List> synthesizeWav(String text) async {
    await _ensureInitialized();
    final sentences = piper.PiperPhonemize.phonemize(text, voice: _espeakVoice);

    final allSamples = <double>[];
    for (final phonemeCodepoints in sentences) {
      if (phonemeCodepoints.isEmpty) continue;
      final ids = _phonemesToIds(phonemeCodepoints);
      allSamples.addAll(_runModel(ids));
    }
    return _pcm16Wav(allSamples, _sampleRate);
  }

  void dispose() {
    _session?.release();
    _session = null;
  }
}
