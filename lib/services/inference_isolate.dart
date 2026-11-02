import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:piper_phonemize/piper_phonemize.dart' as piper;

import 'mt/hindi_santali_mt_service.dart';
import 'tts/hindi_tts_service.dart';
import 'tts/santali_tts_service.dart';

enum _Op { translateToSantali, translateToHindi, speakSantali, speakHindi }

class _Request {
  _Request(this.op, this.text, this.replyTo);
  final _Op op;
  final String text;
  final SendPort replyTo;
}

class _Response {
  _Response.ok({this.text, this.wav}) : error = null;
  _Response.error(this.error) : text = null, wav = null;
  final String? text;
  final Uint8List? wav;
  final String? error;
}

/// Runs every on-device ONNX/Piper inference call (MT's greedy decode loop,
/// both TTS voices' synthesis) on one dedicated background isolate, instead
/// of the UI isolate that was calling into `onnxruntime`/`piper_phonemize`
/// directly before.
///
/// Why this exists: `onnxruntime` binds straight to the native library via
/// `dart:ffi` (verified in its source — `OrtSession` wraps an `ffi.Opaque`,
/// no platform channel involved), so every `session.run()` call is a
/// synchronous, CPU-bound native call on whatever isolate makes it. A
/// translate() is up to 128 greedy-decode steps, each running two ONNX
/// graphs; on the real 2GB-RAM target tablet this froze the UI thread for
/// the full duration (confirmed via `adb logcat`'s "Skipped N frames! The
/// application may be doing too much work on its main thread" during
/// translate/speak) — the app wasn't crashing, it was just unresponsive
/// while the only isolate it had was busy decoding.
///
/// One isolate (not one per service) is kept alive for the app's lifetime:
/// MT and TTS are never used concurrently in the UI (translate, then
/// optionally speak the result), so a single worker avoids paying isolate
/// spawn/heap overhead three times over on a memory-constrained device.
/// `HindiSantaliMtService`/`HindiTtsService`/`SantaliTtsService` themselves
/// are untouched — they now simply live entirely inside this isolate rather
/// than the main one, so their (large) ONNX sessions never sit on the UI
/// isolate's heap at all.
class InferenceIsolate {
  InferenceIsolate._();
  static final InferenceIsolate instance = InferenceIsolate._();

  SendPort? _sendPort;
  Completer<void>? _starting;
  bool _hindiAssetsPrewarmed = false;

  Future<void>? _mtAssets;
  Future<void>? _santaliAssets;
  Future<void>? _hindiTtsAssets;

  // Asset extraction happens here, on whichever isolate calls in — normally
  // the root one — and never inside the worker. The worker has no
  // ServicesBinding, so rootBundle there throws "Binding has not yet been
  // initialized"; BackgroundIsolateBinaryMessenger.ensureInitialized wires
  // up plugin channels but creates no binding. Memoized per service so the
  // cost is one stat per file after the first call.
  Future<void> _prepareMtAssets() =>
      _mtAssets ??= HindiSantaliMtService.instance.prepareAssets();

  Future<void> _prepareSantaliAssets() =>
      _santaliAssets ??= SantaliTtsService.instance.prepareAssets();

  Future<void> _prepareHindiAssets() =>
      _hindiTtsAssets ??= HindiTtsService.instance.prepareAssets();

  Future<void> _ensureStarted() async {
    if (_sendPort != null) return;
    final starting = _starting;
    if (starting != null) return starting.future;

    final completer = Completer<void>();
    _starting = completer;

    final rootToken = RootIsolateToken.instance;
    if (rootToken == null) {
      throw StateError(
        'InferenceIsolate must be started from the root Flutter isolate.',
      );
    }

    final ready = ReceivePort();
    await Isolate.spawn(_entry, [ready.sendPort, rootToken]);
    ready.listen((message) {
      if (message is SendPort) {
        _sendPort = message;
        if (!completer.isCompleted) completer.complete();
      }
    });

    return completer.future;
  }

  Future<String> translateToSantali(String text) async {
    await _prepareMtAssets();
    return _requestText(_Op.translateToSantali, text);
  }

  Future<String> translateToHindi(String text) async {
    await _prepareMtAssets();
    return _requestText(_Op.translateToHindi, text);
  }

  Future<Uint8List> speakSantali(String text) async {
    await _prepareSantaliAssets();
    return _requestWav(_Op.speakSantali, text);
  }

  Future<Uint8List> speakHindi(String text) async {
    await _prepareHindiAssets();
    if (!_hindiAssetsPrewarmed) {
      // extractEspeakNgData() does ~190 rapid, sequential rootBundle.load()
      // calls to unpack espeak-ng's data files. Doing that for the first
      // time from the background isolate crashed the app on-device — a
      // native SIGABRT ("FORTIFY: pthread_mutex_lock called on a destroyed
      // mutex" inside libflutter.so, confirmed via the device's tombstone)
      // that looks like a BackgroundIsolateBinaryMessenger race under many
      // fast sequential channel calls. Extracting once here, on whichever
      // isolate calls speakHindi first (normally the main/UI isolate),
      // sidesteps it entirely — the worker isolate's own call then just
      // finds the directory already there and returns immediately.
      piper.initBindings();
      await piper.extractEspeakNgData();
      _hindiAssetsPrewarmed = true;
    }
    return _requestWav(_Op.speakHindi, text);
  }

  Future<String> _requestText(_Op op, String text) async {
    final res = await _send(op, text);
    if (res.error != null) throw StateError(res.error!);
    return res.text!;
  }

  Future<Uint8List> _requestWav(_Op op, String text) async {
    final res = await _send(op, text);
    if (res.error != null) throw StateError(res.error!);
    return res.wav!;
  }

  Future<_Response> _send(_Op op, String text) async {
    await _ensureStarted();
    final replyPort = ReceivePort();
    _sendPort!.send(_Request(op, text, replyPort.sendPort));
    final result = await replyPort.first as _Response;
    replyPort.close();
    return result;
  }

  static void _entry(List<dynamic> args) {
    final mainSendPort = args[0] as SendPort;
    final rootToken = args[1] as RootIsolateToken;
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);

    final commandPort = ReceivePort();
    mainSendPort.send(commandPort.sendPort);

    commandPort.listen((message) async {
      final req = message as _Request;
      try {
        switch (req.op) {
          case _Op.translateToSantali:
            final r = await HindiSantaliMtService.instance.translate(req.text);
            req.replyTo.send(_Response.ok(text: r));
          case _Op.translateToHindi:
            final r = await HindiSantaliMtService.instance.translateToHindi(
              req.text,
            );
            req.replyTo.send(_Response.ok(text: r));
          case _Op.speakSantali:
            final wav = await SantaliTtsService.instance.synthesizeWav(
              req.text,
            );
            req.replyTo.send(_Response.ok(wav: wav));
          case _Op.speakHindi:
            final wav = await HindiTtsService.instance.synthesizeWav(req.text);
            req.replyTo.send(_Response.ok(wav: wav));
        }
      } catch (e) {
        req.replyTo.send(_Response.error('$e'));
      }
    });
  }
}
