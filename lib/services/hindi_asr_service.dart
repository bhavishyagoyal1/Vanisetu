import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:sherpa_onnx/sherpa_onnx.dart' as sherpa_onnx;

import 'asr/audio_conditioner.dart';
import 'asr/hindi_text_normalizer.dart';

/// Wraps the offline betterflow Hindi/Hinglish streaming CTC ASR model
/// (see `models/ASR Model/HANDOFF.md`) for use in the app.
///
/// The recognizer loads once (lazily, on first use) and stays resident for
/// the app session — building it takes ~0.5s plus a one-time copy of the
/// ~66MB model out of the asset bundle onto disk, so it isn't cheap enough
/// to redo per recording.
///
/// This is push-to-talk, not continuous dictation: endpointing is disabled,
/// so one [startListening]/[stopListening] pair is always exactly one
/// utterance — the recognizer never auto-resets mid-recording. Only the
/// text returned by [stopListening] is the committed transcript; `onPartial`
/// hypotheses are unstable prefixes that get rewritten mid-speech.
class HindiAsrService {
  HindiAsrService._();
  static final HindiAsrService instance = HindiAsrService._();

  static const _sampleRate = 16000;
  static const _encoderAssetPath = 'assets/models/asr/encoder.int8.onnx';
  static const _tokensAssetPath = 'assets/models/asr/tokens.txt';
  static const _vadAssetPath = 'assets/models/vad/silero_vad.onnx';
  static const _encoderByteSize = 68954634;

  static bool _bindingsInitialized = false;

  sherpa_onnx.OnlineRecognizer? _recognizer;
  sherpa_onnx.OnlineStream? _stream;
  AudioConditioner? _conditioner;
  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _micSubscription;

  bool _initializing = false;
  bool _listening = false;
  bool get isListening => _listening;

  int _zeroBlocksInARow = 0;
  bool _sawRealAudio = false;
  bool _sawFirstChunk = false;
  String _lastPartial = '';

  void Function(String message)? _onError;

  Future<void> _ensureInitialized() async {
    if (_recognizer != null) return;
    if (_initializing) {
      while (_initializing) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
      return;
    }

    _initializing = true;
    try {
      debugPrint('HindiAsrService: initializing…');
      if (!_bindingsInitialized) {
        sherpa_onnx.initBindings();
        _bindingsInitialized = true;
        debugPrint('HindiAsrService: native bindings loaded');
      }

      final supportDir = await getApplicationSupportDirectory();
      final modelDir = Directory('${supportDir.path}/asr_model');
      if (!await modelDir.exists()) {
        await modelDir.create(recursive: true);
      }

      final encoderFile = File('${modelDir.path}/encoder.int8.onnx');
      final tokensFile = File('${modelDir.path}/tokens.txt');

      if (!await encoderFile.exists() ||
          await encoderFile.length() != _encoderByteSize) {
        debugPrint('HindiAsrService: extracting encoder asset…');
        final data = await rootBundle.load(_encoderAssetPath);
        await encoderFile.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        );
      }
      if (!await tokensFile.exists()) {
        final data = await rootBundle.load(_tokensAssetPath);
        await tokensFile.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        );
      }

      final vadFile = File('${modelDir.path}/silero_vad.onnx');
      if (!await vadFile.exists()) {
        final data = await rootBundle.load(_vadAssetPath);
        await vadFile.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
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
        // Endpointing off on purpose: this is push-to-talk (see class doc),
        // so a pause mid-recording must not auto-commit and reset the
        // recognizer — only an explicit stopListening() should.
        enableEndpoint: false,
      );

      debugPrint('HindiAsrService: creating recognizer…');
      _recognizer = sherpa_onnx.OnlineRecognizer(config);
      debugPrint('HindiAsrService: recognizer ready');
    } catch (e, st) {
      debugPrint('HindiAsrService: init failed: $e\n$st');
      rethrow;
    } finally {
      _initializing = false;
    }
  }

  Future<bool> hasMicPermission() => _recorder.hasPermission();

  /// Starts a listening session: captures 16kHz mono mic audio and streams it
  /// through the recognizer. [onPartial] fires on every updated hypothesis
  /// for the whole recording so far. Call [stopListening] to end the session
  /// and get the committed transcript.
  Future<void> startListening({
    required void Function(String partial) onPartial,
    required void Function(String message) onError,
  }) async {
    if (_listening) return;
    _onError = onError;

    debugPrint('HindiAsrService: checking mic permission…');
    final granted = await hasMicPermission();
    debugPrint('HindiAsrService: mic permission granted=$granted');
    if (!granted) {
      onError('Microphone permission was denied.');
      return;
    }

    try {
      await _ensureInitialized();
    } catch (e) {
      onError('Speech model failed to load: $e');
      return;
    }

    final recognizer = _recognizer;
    if (recognizer == null) {
      onError('Speech model failed to load.');
      return;
    }

    sherpa_onnx.OnlineStream stream;
    try {
      stream = recognizer.createStream();
    } catch (e) {
      onError('Could not start the speech engine: $e');
      return;
    }
    _stream = stream;
    _zeroBlocksInARow = 0;
    _sawRealAudio = false;
    _sawFirstChunk = false;
    _lastPartial = '';
    _conditioner?.reset();

    final Stream<Uint8List> pcmStream;
    try {
      debugPrint('HindiAsrService: starting mic stream…');
      pcmStream = await _recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: _sampleRate,
          numChannels: 1,
        ),
      );
      debugPrint('HindiAsrService: mic stream started');
    } catch (e) {
      debugPrint('HindiAsrService: startStream failed: $e');
      stream.free();
      _stream = null;
      onError('Could not start recording: $e');
      return;
    }

    _listening = true;

    _micSubscription = pcmStream.listen((chunk) {
      try {
        final currentStream = _stream;
        if (currentStream == null || chunk.length < 2) return;

        if (!_sawFirstChunk) {
          _sawFirstChunk = true;
          debugPrint(
            'HindiAsrService: first audio chunk received (${chunk.length} bytes)',
          );
        }

        final sampleCount = chunk.length ~/ 2;
        final samples = Float32List(sampleCount);
        final byteData = ByteData.sublistView(chunk);
        var allZero = true;
        for (var i = 0; i < sampleCount; i++) {
          final s = byteData.getInt16(i * 2, Endian.little);
          if (s != 0) allZero = false;
          samples[i] = s / 32768.0;
        }

        // Bit-exact-zero blocks mean the OS is silently denying mic access
        // (see HANDOFF.md): a live mic always has a noise floor, so exact
        // zeros are a permission failure presenting as audio. The
        // conditioner substitutes dither for them, but only this check can
        // tell the user *why* nothing is happening.
        if (allZero) {
          _zeroBlocksInARow++;
          if (!_sawRealAudio && _zeroBlocksInARow == 20) {
            _onError?.call(
              'No audio is reaching the microphone — check mic permission.',
            );
          }
        } else {
          _sawRealAudio = true;
          _zeroBlocksInARow = 0;
        }

        // VAD gating, gain normalisation and dithering all happen here, so
        // that what the recognizer sees is identical to what the Python
        // eval harness measures.
        final conditioned = _conditioner?.process(samples) ?? samples;
        currentStream.acceptWaveform(
          samples: conditioned,
          sampleRate: _sampleRate,
        );
        while (recognizer.isReady(currentStream)) {
          recognizer.decode(currentStream);
        }

        final text = recognizer.getResult(currentStream).text.trim();
        if (text != _lastPartial) {
          _lastPartial = text;
          debugPrint('HindiAsrService: partial = "$text"');
          onPartial(text);
        }
      } catch (e) {
        onError('Speech decoding error: $e');
      }
    }, onError: (Object e) => onError('Recording error: $e'));
  }

  /// Stops capture and flushes trailing context so the last word isn't
  /// dropped (Zipformer has right-context lookahead — see HANDOFF.md).
  ///
  /// Returns the committed transcript, normalized to Devanagari-only text —
  /// the form [HindiSantaliMtService] needs, since it tags its input
  /// `hin_Deva` and the recognizer is a Hinglish model that emits Latin
  /// loanwords and ASCII digits. Returns null when the session contained no
  /// real audio, or when the transcript has the degenerate shape of a
  /// silence hallucination: text nobody said is worse than no text at all.
  ///
  /// Partials are deliberately *not* normalized — they are unstable prefixes
  /// shown live, never sent downstream, so the extra work would buy nothing
  /// and the committed transcript is the only contract that matters.
  Future<String?> stopListening() async {
    if (!_listening) return null;
    _listening = false;

    await _micSubscription?.cancel();
    _micSubscription = null;
    await _recorder.stop();

    final stream = _stream;
    final recognizer = _recognizer;
    String? finalText;
    if (stream != null && recognizer != null) {
      stream.acceptWaveform(
        samples: Float32List(_sampleRate ~/ 2),
        sampleRate: _sampleRate,
      );
      stream.inputFinished();
      while (recognizer.isReady(stream)) {
        recognizer.decode(stream);
      }
      final raw = recognizer.getResult(stream).text.trim();
      // A session that never carried real audio cannot have a transcript.
      // Conditioned silence still decodes to a stray token, so this gate is
      // what stops it reaching the translator.
      final heardSpeech = _conditioner?.sawSpeech ?? _sawRealAudio;
      if (heardSpeech) {
        final normalized = normalizeTranscript(raw);
        if (normalized.isNotEmpty) finalText = normalized;
      } else if (raw.isNotEmpty) {
        debugPrint('HindiAsrService: discarding "$raw" — no speech detected');
      }
      stream.free();
    }
    _stream = null;
    _onError = null;
    return finalText;
  }

  void dispose() {
    _micSubscription?.cancel();
    _recorder.dispose();
    _stream?.free();
    _recognizer?.free();
    _recognizer = null;
    _conditioner?.free();
    _conditioner = null;
  }
}
