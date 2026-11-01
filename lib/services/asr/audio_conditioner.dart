import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa_onnx;

/// Conditions microphone blocks before they reach the recognizer.
///
/// Port of `models/ASR Model/audio.py`. Two rules govern everything here:
///
/// 1. **Never change the sample count.** Dropping blocks desyncs the
///    recognizer's stream clock. Conditioning rewrites sample *values*, never
///    how many there are.
/// 2. **Never hand the model digital silence.** Fed bit-exact zeros the
///    recognizer emits confident runs of a single token (`का का का ...`) —
///    verified by running it. Inaudible dither keeps the log-mel frontend out
///    of that degenerate state.
///
/// The VAD is optional by design: if `silero_vad.onnx` fails to load, the
/// conditioner falls back to energy-only gating rather than taking the mic
/// down with it. Speech capture failing closed would be a worse bug than
/// slightly weaker noise rejection.
class AudioConditioner {
  AudioConditioner._(this._vad);

  /// Builds a conditioner, attaching a VAD when [vadModelPath] loads.
  factory AudioConditioner({String? vadModelPath}) {
    if (vadModelPath == null) return AudioConditioner._(null);
    try {
      final config = sherpa_onnx.VadModelConfig(
        sileroVad: sherpa_onnx.SileroVadModelConfig(
          model: vadModelPath,
          threshold: 0.5,
          minSilenceDuration: 0.25,
          // Lower than the 0.25 default: Silero must latch onto speech
          // quickly or the energy floor ends up doing all the work.
          minSpeechDuration: 0.1,
        ),
        sampleRate: _sampleRate,
        debug: false,
      );
      return AudioConditioner._(
        sherpa_onnx.VoiceActivityDetector(
          config: config,
          bufferSizeInSeconds: 30.0,
        ),
      );
    } catch (e) {
      debugPrint('AudioConditioner: VAD unavailable ($e) — energy gating only');
      return AudioConditioner._(null);
    }
  }

  static const int _sampleRate = 16000;

  /// Silero consumes exactly this many samples per inference at 16 kHz.
  static const int _vadWindow = 512;

  /// Below this RMS a block carries no usable speech energy.
  static const double _energyFloor = 0.005;

  /// Keep passing audio for this long after the VAD last saw speech, so
  /// trailing consonants and short intra-word pauses are not clipped.
  static const int _hangoverBlocks = 5;

  static const double _ditherAmplitude = 1e-4;

  final sherpa_onnx.VoiceActivityDetector? _vad;
  final Random _random = Random(0);
  final List<double> _pending = <double>[];

  int _blocksSinceSpeech = _hangoverBlocks + 1;
  bool _sawSpeech = false;

  /// True if any block in this session carried speech.
  ///
  /// Conditioning alone is not enough: four seconds of conditioned silence
  /// still decodes to a stray `क`. A transcript from a session that never
  /// contained speech must therefore be discarded outright, rather than
  /// trimmed by a length heuristic that would eat real one-word answers.
  bool get sawSpeech => _sawSpeech;

  /// Resets per-session state. The VAD itself is reused across sessions.
  void reset() {
    _pending.clear();
    _blocksSinceSpeech = _hangoverBlocks + 1;
    _sawSpeech = false;
    _vad?.reset();
  }

  bool _vadSaysSpeech(Float32List samples) {
    final vad = _vad;
    if (vad == null) return false;
    _pending.addAll(samples);
    var speech = false;
    while (_pending.length >= _vadWindow) {
      final window = Float32List.fromList(_pending.sublist(0, _vadWindow));
      _pending.removeRange(0, _vadWindow);
      vad.acceptWaveform(window);
      if (vad.isDetected()) speech = true;
    }
    return speech;
  }

  bool _isSpeech(Float32List samples) {
    // Energy is checked independently of the VAD: Silero needs a moment to
    // latch onto speech onset, and a false negative there would clip the
    // first phoneme of every utterance. Loud audio is always speech.
    final loud = _rms(samples) >= _energyFloor;
    if (_vad == null) {
      _sawSpeech = _sawSpeech || loud;
      return loud;
    }
    if (_vadSaysSpeech(samples) || loud) {
      _blocksSinceSpeech = 0;
      _sawSpeech = true;
      return true;
    }
    _blocksSinceSpeech++;
    return _blocksSinceSpeech <= _hangoverBlocks;
  }

  static double _rms(Float32List samples) {
    if (samples.isEmpty) return 0;
    var total = 0.0;
    for (final sample in samples) {
      total += sample * sample;
    }
    return sqrt(total / samples.length);
  }

  Float32List _dither(int count) {
    final out = Float32List(count);
    for (var i = 0; i < count; i++) {
      out[i] = (_random.nextDouble() - 0.5) * 2 * _ditherAmplitude;
    }
    return out;
  }

  /// Scales toward a target RMS.
  ///
  /// Gated behind the speech decision on purpose: normalising during silence
  /// amplifies the noise floor, which is exactly what drives the
  /// hallucination this class exists to prevent.
  Float32List _applyGain(Float32List samples) {
    const targetRms = 0.05;
    const maxGain = 8.0;
    final rms = _rms(samples);
    if (rms <= 0) return samples;
    final gain = min(targetRms / rms, maxGain);
    final out = Float32List(samples.length);
    for (var i = 0; i < samples.length; i++) {
      out[i] = (samples[i] * gain).clamp(-1.0, 1.0).toDouble();
    }
    return out;
  }

  /// Conditions one block. Always returns exactly `samples.length` samples.
  Float32List process(Float32List samples) {
    if (!_isSpeech(samples)) return _dither(samples.length);
    final gained = _applyGain(samples);
    // Even inside speech a bit-exact-zero block is a denied mic, not audio.
    if (!gained.any((s) => s != 0)) return _dither(gained.length);
    return gained;
  }

  void free() {
    _vad?.free();
  }
}
