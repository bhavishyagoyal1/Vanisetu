/// Guards the hand-off of a bundled model file to native code.
///
/// Every `.onnx` under `assets/models/` is tracked by Git LFS. Cloned or
/// built without `git-lfs` installed, each one checks out as a ~133-byte
/// text pointer instead of the model. Handing such a file to `sherpa_onnx`
/// or `onnxruntime` does not throw — the parse happens in C++ and aborts the
/// process, which kills the app outright and bypasses Dart's try/catch, so
/// the app simply vanishes with nothing in the UI to explain why.
///
/// Checking the bytes before native code ever sees them turns that into an
/// ordinary Dart exception carrying the fix.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show AssetBundle;

class ModelAssetException implements Exception {
  ModelAssetException(this.message);

  final String message;

  @override
  String toString() => 'ModelAssetException: $message';
}

/// The first line of every Git LFS pointer file.
const _lfsMagic = 'version https://git-lfs.github.com/spec/v1';

/// Whether [bytes] is a Git LFS pointer rather than the file it stands for.
bool isLfsPointer(Uint8List bytes) {
  if (bytes.length < _lfsMagic.length) return false;
  for (var i = 0; i < _lfsMagic.length; i++) {
    if (bytes[i] != _lfsMagic.codeUnitAt(i)) return false;
  }
  return true;
}

/// Throws [ModelAssetException] unless [bytes] plausibly is the real model.
///
/// [expectedBytes], where a caller pins it, is the strongest check available
/// — a truncated or substituted model is as fatal to native code as a
/// pointer file is.
void verifyModelAsset({
  required String name,
  required Uint8List bytes,
  int? expectedBytes,
}) {
  if (isLfsPointer(bytes)) {
    throw ModelAssetException(
      '$name is a Git LFS pointer, not the model itself. '
      'Install git-lfs and fetch the real files: '
      '`git lfs install && git lfs pull`, then rebuild the app.',
    );
  }
  if (bytes.isEmpty) {
    throw ModelAssetException('$name is empty.');
  }
  if (expectedBytes != null && bytes.length != expectedBytes) {
    throw ModelAssetException(
      '$name is ${bytes.length} bytes, expected $expectedBytes. '
      'The bundled model looks truncated or replaced; re-fetch it with '
      '`git lfs pull` and rebuild.',
    );
  }
}

/// Copies bundled model files out of the asset bundle into [targetDir],
/// verifying each one, and returns asset key -> on-disk path.
///
/// **Must run on the root isolate.** `rootBundle.load` goes through
/// `ServicesBinding.instance.defaultBinaryMessenger`, and `ServicesBinding`
/// exists only on the root isolate — calling it from a spawned isolate fails
/// with "Binding has not yet been initialized", regardless of
/// `BackgroundIsolateBinaryMessenger.ensureInitialized`, which wires up
/// plugin channels but creates no binding. The inference isolate therefore
/// calls this on the main isolate first and only ever reads files from disk.
///
/// Idempotent: an asset already on disk (and matching its pinned size, where
/// one is given) is left alone, so repeat calls cost a stat per file rather
/// than re-reading hundreds of megabytes.
Future<Map<String, String>> extractModelAssets({
  required AssetBundle bundle,
  required Directory targetDir,
  required List<String> assetKeys,
  Map<String, int> expectedBytes = const {},
}) async {
  if (!await targetDir.exists()) {
    await targetDir.create(recursive: true);
  }

  final paths = <String, String>{};
  for (final key in assetKeys) {
    final name = key.split('/').last;
    final file = File('${targetDir.path}/$name');
    paths[key] = file.path;

    final expected = expectedBytes[key];
    if (await file.exists()) {
      if (expected == null || await file.length() == expected) continue;
    }

    final data = await bundle.load(key);
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    // Verify before writing: a stub must never reach disk, or the next run
    // finds a plausible-looking file and hands it straight to native code.
    verifyModelAsset(name: key, bytes: bytes, expectedBytes: expected);
    await file.writeAsBytes(bytes);
  }
  return paths;
}
