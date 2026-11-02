import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import 'asr/hindi_text_normalizer.dart';
import 'asr_isolate.dart';
import 'model_assets.dart';

/// Wraps the offline betterflow Hindi/Hinglish streaming CTC ASR model
/// (see `models/ASR Model/HANDOFF.md`) for use in the app.
///
/// This is push-to-talk, not continuous dictation: endpointing is disabled,
/// so one [startListening]/[stopListening] pair is always exactly one
/// utterance — the recognizer never auto-resets mid-recording. Only the
/// text returned by [stopListening] is the committed transcript; `onPartial`
/// hypotheses are unstable prefixes that get rewritten mid-speech.
///
/// This class is a thin adapter over [AsrIsolate]: mic capture
/// (`package:record`) stays here on the main/UI isolate since it's a cheap
/// platform-channel plugin, while the recognizer itself — and every
/// per-chunk VAD + decode call, both native `dart:ffi` work — runs on
/// [AsrIsolate]'s dedicated background isolate. That split exists because
/// that decode work used to run right here on the UI isolate, competing
/// with every frame and touch event for CPU time on weaker devices and
/// making the whole app feel laggy while the mic was open, not just slow to
/// start it.
class HindiAsrService {
  HindiAsrService._();
  static final HindiAsrService instance = HindiAsrService._();

  static const _sampleRate = 16000;
  static const _encoderAssetPath = 'assets/models/asr/encoder.int8.onnx';
  static const _tokensAssetPath = 'assets/models/asr/tokens.txt';
  static const _vadAssetPath = 'assets/models/vad/silero_vad.onnx';
  static const _encoderByteSize = 68954634;

  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _micSubscription;

  bool _listening = false;
  bool get isListening => _listening;

  String? _lastRawTranscript;

  /// The recognizer's own output for the last committed transcript, before
  /// [normalizeTranscript] rewrote it — exposed so the UI can tell the user
  /// when cleaning actually happened. Null until a session commits text, and
  /// cleared when a new one starts.
  String? get lastRawTranscript => _lastRawTranscript;

  /// Extracts the recognizer's bundled assets to the app support directory,
  /// if they aren't there already.
  ///
  /// **Must be called from the main/root isolate** before [AsrIsolate] ever
  /// builds the recognizer on its background isolate — `rootBundle.load()`
  /// hard-codes `ServicesBinding.instance` (Flutter's
  /// `PlatformAssetBundle.load`), which throws "Bad state: Binding has not
  /// yet been initialized" from a background isolate. [extractModelAssets]
  /// also guards against a Git-LFS-pointer stub reaching native code (see
  /// model_assets.dart) — handing sherpa-onnx a stub aborts the process
  /// with nothing Dart can catch.
  Future<void> prepareAssets() async {
    final supportDir = await getApplicationSupportDirectory();
    await extractModelAssets(
      bundle: rootBundle,
      targetDir: Directory('${supportDir.path}/asr_model'),
      assetKeys: [_encoderAssetPath, _tokensAssetPath, _vadAssetPath],
      expectedBytes: {_encoderAssetPath: _encoderByteSize},
    );
  }

  /// Loads the recognizer ahead of the first mic tap, so the multi-second
  /// first-use cost (asset extraction, then building the recognizer on
  /// [AsrIsolate]'s background isolate) happens while the splash screen is
  /// already showing rather than after the user taps the mic button. Safe
  /// to call speculatively: errors are swallowed here and simply surface
  /// again, normally, the next time [startListening] runs this itself.
  Future<void> prewarm() async {
    try {
      await prepareAssets();
      await AsrIsolate.instance.prewarm();
    } catch (e) {
      debugPrint('HindiAsrService: prewarm failed (will retry on demand): $e');
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

    debugPrint('HindiAsrService: checking mic permission…');
    final granted = await hasMicPermission();
    debugPrint('HindiAsrService: mic permission granted=$granted');
    if (!granted) {
      onError('Microphone permission was denied.');
      return;
    }

    try {
      await prepareAssets();
      await AsrIsolate.instance.startSession(
        onPartial: onPartial,
        onError: onError,
      );
    } catch (e) {
      onError('Speech model failed to load: $e');
      return;
    }

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
      onError('Could not start recording: $e');
      return;
    }

    _listening = true;
    _micSubscription = pcmStream.listen(
      AsrIsolate.instance.pushChunk,
      onError: (Object e) => onError('Recording error: $e'),
    );
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
    _lastRawTranscript = null;

    await _micSubscription?.cancel();
    _micSubscription = null;
    await _recorder.stop();

    final result = await AsrIsolate.instance.stopSession();
    String? finalText;
    // A session that never carried real audio cannot have a transcript.
    // Conditioned silence still decodes to a stray token, so this gate is
    // what stops it reaching the translator.
    if (result.heardSpeech) {
      final normalized = normalizeTranscript(result.raw);
      if (normalized.isNotEmpty) {
        finalText = normalized;
        _lastRawTranscript = result.raw;
      }
    } else if (result.raw.isNotEmpty) {
      debugPrint(
        'HindiAsrService: discarding "${result.raw}" — no speech detected',
      );
    }
    return finalText;
  }

  void dispose() {
    _micSubscription?.cancel();
    _recorder.dispose();
  }
}
