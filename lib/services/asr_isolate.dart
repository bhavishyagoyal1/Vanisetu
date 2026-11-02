import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa_onnx;

import 'asr/audio_conditioner.dart';

class _PrewarmMsg {
  const _PrewarmMsg();
}

class _StartSessionMsg {
  const _StartSessionMsg();
}

class _AudioChunkMsg {
  const _AudioChunkMsg(this.bytes);
  final Uint8List bytes;
}

class _StopSessionMsg {
  const _StopSessionMsg();
}

class _ReadyMsg {
  const _ReadyMsg();
}

class _InitFailedMsg {
  const _InitFailedMsg(this.error);
  final String error;
}

class _PartialMsg {
  const _PartialMsg(this.text);
  final String text;
}

class _NoAudioMsg {
  const _NoAudioMsg();
}

class _DecodeErrorMsg {
  const _DecodeErrorMsg(this.error);
  final String error;
}

class _FinalResultMsg {
  const _FinalResultMsg(this.raw, this.heardSpeech);
  final String raw;
  final bool heardSpeech;
}

/// Runs the ASR recognizer's per-chunk VAD + streaming CTC decode on a
/// dedicated background isolate — the same rationale [InferenceIsolate] has
/// for MT/TTS: `sherpa_onnx`'s recognizer, like `onnxruntime`, binds
/// straight to its native library via `dart:ffi`, so every `decode()` call
/// (and the VAD's own inference inside [AudioConditioner]) is a
/// synchronous, CPU-bound native call on whatever isolate makes it. Audio
/// chunks arrive continuously while listening (many times a second), so
/// doing that work on the UI isolate — the original implementation — competed
/// with every frame and every touch event for CPU time, making the whole
/// app feel laggy while the mic was open, not just the mic button itself.
///
/// Mic capture stays on the main isolate — `package:record`'s
/// `AudioRecorder` is a platform-channel plugin, not FFI, and forwarding
/// small PCM chunks over a channel is cheap. Only the native decode work
/// moves here; raw PCM bytes go in, partial/final text comes back out.
///
/// Like [InferenceIsolate], this expects [HindiAsrService] to have already
/// extracted the model's assets onto disk from the *main* isolate before
/// [prewarm]/[startSession] run — `rootBundle.load()` hard-codes
/// `ServicesBinding.instance`, which throws "Bad state: Binding has not yet
/// been initialized" from a background isolate.
class AsrIsolate {
  AsrIsolate._();
  static final AsrIsolate instance = AsrIsolate._();

  SendPort? _sendPort;
  Completer<void>? _spawning;
  Completer<void>? _readyCompleter;
  Completer<({String raw, bool heardSpeech})>? _stopCompleter;

  void Function(String text)? _onPartial;
  void Function(String message)? _onError;

  Future<void> _ensureSpawned() async {
    if (_sendPort != null) return;
    final spawning = _spawning;
    if (spawning != null) return spawning.future;

    final completer = Completer<void>();
    _spawning = completer;

    final rootToken = RootIsolateToken.instance;
    if (rootToken == null) {
      throw StateError(
        'AsrIsolate must be started from the root Flutter isolate.',
      );
    }

    final ready = ReceivePort();
    await Isolate.spawn(_entry, [ready.sendPort, rootToken]);
    ready.listen((message) {
      if (message is SendPort) {
        _sendPort = message;
        if (!completer.isCompleted) completer.complete();
        return;
      }
      _handleWorkerMessage(message);
    });

    return completer.future;
  }

  void _handleWorkerMessage(dynamic message) {
    switch (message) {
      case _ReadyMsg():
        final c = _readyCompleter;
        _readyCompleter = null;
        c?.complete();
      case _InitFailedMsg(:final error):
        final c = _readyCompleter;
        _readyCompleter = null;
        c?.completeError(StateError(error));
      case _PartialMsg(:final text):
        _onPartial?.call(text);
      case _NoAudioMsg():
        _onError?.call(
          'No audio is reaching the microphone — check mic permission.',
        );
      case _DecodeErrorMsg(:final error):
        _onError?.call('Speech decoding error: $error');
      case _FinalResultMsg(:final raw, :final heardSpeech):
        final c = _stopCompleter;
        _stopCompleter = null;
        c?.complete((raw: raw, heardSpeech: heardSpeech));
    }
  }

  /// Builds the recognizer ahead of the first mic tap. Safe to call
  /// speculatively and repeatedly — a call while already ready or loading
  /// just waits on that result rather than doing the work twice.
  Future<void> prewarm() async {
    await _ensureSpawned();
    final existing = _readyCompleter;
    if (existing != null) return existing.future;
    final completer = Completer<void>();
    _readyCompleter = completer;
    _sendPort!.send(const _PrewarmMsg());
    return completer.future;
  }

  Future<void> startSession({
    required void Function(String partial) onPartial,
    required void Function(String message) onError,
  }) async {
    _onPartial = onPartial;
    _onError = onError;
    await prewarm();
    _sendPort!.send(const _StartSessionMsg());
  }

  void pushChunk(Uint8List bytes) {
    _sendPort?.send(_AudioChunkMsg(bytes));
  }

  Future<({String raw, bool heardSpeech})> stopSession() {
    final completer = Completer<({String raw, bool heardSpeech})>();
    _stopCompleter = completer;
    _sendPort?.send(const _StopSessionMsg());
    return completer.future;
  }

  static void _entry(List<dynamic> args) {
    final mainSendPort = args[0] as SendPort;
    final rootToken = args[1] as RootIsolateToken;
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);

    final commandPort = ReceivePort();
    mainSendPort.send(commandPort.sendPort);

    final worker = _AsrWorker(mainSendPort);
    commandPort.listen((message) => worker.handle(message));
  }
}

/// Owns the recognizer, stream and conditioner for the lifetime of the
/// worker isolate — the same responsibilities `HindiAsrService` used to
/// carry directly, just running here instead of on the UI isolate.
class _AsrWorker {
  _AsrWorker(this._mainSendPort);

  static const _sampleRate = 16000;
  static const _encoderByteSize = 68954634;

  final SendPort _mainSendPort;

  sherpa_onnx.OnlineRecognizer? _recognizer;
  sherpa_onnx.OnlineStream? _stream;
  AudioConditioner? _conditioner;

  int _zeroBlocksInARow = 0;
  bool _sawRealAudio = false;
  String _lastPartial = '';

  Future<void> handle(dynamic message) async {
    switch (message) {
      case _PrewarmMsg():
        await _ensureInitialized();
      case _StartSessionMsg():
        _startSession();
      case _AudioChunkMsg(:final bytes):
        _handleChunk(bytes);
      case _StopSessionMsg():
        _stopSession();
    }
  }

  Future<void> _ensureInitialized() async {
    if (_recognizer != null) {
      _mainSendPort.send(const _ReadyMsg());
      return;
    }
    try {
      sherpa_onnx.initBindings();

      final supportDir = await getApplicationSupportDirectory();
      final modelDir = Directory('${supportDir.path}/asr_model');

      final encoderFile = File('${modelDir.path}/encoder.int8.onnx');
      final tokensFile = File('${modelDir.path}/tokens.txt');
      final vadFile = File('${modelDir.path}/silero_vad.onnx');

      // These must already be on disk — see this class's doc comment.
      // HindiAsrService.prewarmAssets() puts them there from the main
      // isolate before ever calling into this isolate.
      if (!await encoderFile.exists() ||
          await encoderFile.length() != _encoderByteSize ||
          !await tokensFile.exists() ||
          !await vadFile.exists()) {
        throw StateError(
          'ASR model assets missing on disk — HindiAsrService.prewarmAssets() '
          'must run on the main isolate first.',
        );
      }

      _conditioner = AudioConditioner(vadModelPath: vadFile.path);

      final config = sherpa_onnx.OnlineRecognizerConfig(
        model: sherpa_onnx.OnlineModelConfig(
          zipformer2Ctc: sherpa_onnx.OnlineZipformer2CtcModelConfig(
            model: encoderFile.path,
          ),
          tokens: tokensFile.path,
          modelType: 'zipformer2',
          numThreads: 2,
          debug: false,
        ),
        // Endpointing off on purpose: this is push-to-talk, so a pause
        // mid-recording must not auto-commit and reset the recognizer —
        // only an explicit stop should.
        enableEndpoint: false,
      );

      _recognizer = sherpa_onnx.OnlineRecognizer(config);
      _mainSendPort.send(const _ReadyMsg());
    } catch (e) {
      _mainSendPort.send(_InitFailedMsg('$e'));
    }
  }

  void _startSession() {
    final recognizer = _recognizer;
    if (recognizer == null) {
      return; // _ensureInitialized already reported failure
    }
    _stream?.free();
    _stream = recognizer.createStream();
    _zeroBlocksInARow = 0;
    _sawRealAudio = false;
    _lastPartial = '';
    _conditioner?.reset();
  }

  void _handleChunk(Uint8List chunk) {
    try {
      final recognizer = _recognizer;
      final stream = _stream;
      if (recognizer == null || stream == null || chunk.length < 2) return;

      final sampleCount = chunk.length ~/ 2;
      final samples = Float32List(sampleCount);
      final byteData = ByteData.sublistView(chunk);
      var allZero = true;
      for (var i = 0; i < sampleCount; i++) {
        final s = byteData.getInt16(i * 2, Endian.little);
        if (s != 0) allZero = false;
        samples[i] = s / 32768.0;
      }

      // Bit-exact-zero blocks mean the OS is silently denying mic access: a
      // live mic always has a noise floor, so exact zeros are a permission
      // failure presenting as audio.
      if (allZero) {
        _zeroBlocksInARow++;
        if (!_sawRealAudio && _zeroBlocksInARow == 20) {
          _mainSendPort.send(const _NoAudioMsg());
        }
      } else {
        _sawRealAudio = true;
        _zeroBlocksInARow = 0;
      }

      final conditioned = _conditioner?.process(samples) ?? samples;
      stream.acceptWaveform(samples: conditioned, sampleRate: _sampleRate);
      while (recognizer.isReady(stream)) {
        recognizer.decode(stream);
      }

      final text = recognizer.getResult(stream).text.trim();
      if (text != _lastPartial) {
        _lastPartial = text;
        _mainSendPort.send(_PartialMsg(text));
      }
    } catch (e) {
      _mainSendPort.send(_DecodeErrorMsg('$e'));
    }
  }

  void _stopSession() {
    final stream = _stream;
    final recognizer = _recognizer;
    var raw = '';
    var heardSpeech = false;
    if (stream != null && recognizer != null) {
      // Flush trailing context so the last word isn't dropped (Zipformer
      // has right-context lookahead — see HANDOFF.md).
      stream.acceptWaveform(
        samples: Float32List(_sampleRate ~/ 2),
        sampleRate: _sampleRate,
      );
      stream.inputFinished();
      while (recognizer.isReady(stream)) {
        recognizer.decode(stream);
      }
      raw = recognizer.getResult(stream).text.trim();
      heardSpeech = _conditioner?.sawSpeech ?? _sawRealAudio;
      stream.free();
    }
    _stream = null;
    _mainSendPort.send(_FinalResultMsg(raw, heardSpeech));
  }
}
