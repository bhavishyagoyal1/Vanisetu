import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vaanisetu/services/model_assets.dart';

Uint8List _bytes(String s) => Uint8List.fromList(utf8.encode(s));

const _lfsPointer =
    'version https://git-lfs.github.com/spec/v1\n'
    'oid sha256:e5758a1b2c3d4e5f60718293a4b5c6d7e8f901234567890abcdef1234567890\n'
    'size 68954634\n';

void main() {
  _extractionContract();

  group('isLfsPointer', () {
    test('recognises a Git LFS pointer file', () {
      expect(isLfsPointer(_bytes(_lfsPointer)), isTrue);
    });

    test('does not flag a real ONNX file', () {
      // ONNX files are protobuf; they start with a field tag, not ASCII text.
      final onnx = Uint8List.fromList([0x08, 0x07, 0x12, 0x0C, 0x70, 0x79]);
      expect(isLfsPointer(onnx), isFalse);
    });

    test('does not flag an empty file', () {
      expect(isLfsPointer(Uint8List(0)), isFalse);
    });

    test('does not read past the end of a very short file', () {
      expect(isLfsPointer(_bytes('ver')), isFalse);
    });
  });

  group('verifyModelAsset', () {
    test('rejects an LFS pointer with an actionable message', () {
      expect(
        () => verifyModelAsset(
          name: 'encoder.int8.onnx',
          bytes: _bytes(_lfsPointer),
        ),
        throwsA(
          isA<ModelAssetException>().having(
            (e) => e.message,
            'message',
            allOf(contains('encoder.int8.onnx'), contains('git lfs')),
          ),
        ),
      );
    });

    test('rejects a file that is not the expected size', () {
      expect(
        () => verifyModelAsset(
          name: 'encoder.int8.onnx',
          bytes: Uint8List.fromList([0x08, 0x07, 0x12]),
          expectedBytes: 68954634,
        ),
        throwsA(isA<ModelAssetException>()),
      );
    });

    test('accepts a plausible model of the expected size', () {
      final model = Uint8List(64)..setAll(0, [0x08, 0x07, 0x12, 0x0C]);
      expect(
        () => verifyModelAsset(
          name: 'encoder.int8.onnx',
          bytes: model,
          expectedBytes: 64,
        ),
        returnsNormally,
      );
    });

    test('accepts a real model when no size is pinned', () {
      final model = Uint8List.fromList([0x08, 0x07, 0x12, 0x0C, 0x70]);
      expect(
        () => verifyModelAsset(name: 'decoder.onnx', bytes: model),
        returnsNormally,
      );
    });

    test('rejects an empty asset', () {
      expect(
        () => verifyModelAsset(name: 'decoder.onnx', bytes: Uint8List(0)),
        throwsA(isA<ModelAssetException>()),
      );
    });
  });
}

/// A stand-in for rootBundle, so extraction can be tested without the
/// ServicesBinding that only the root isolate has.
class _FakeBundle extends CachingAssetBundle {
  _FakeBundle(this.files);

  final Map<String, List<int>> files;
  final loaded = <String>[];

  @override
  Future<ByteData> load(String key) async {
    loaded.add(key);
    final bytes = files[key];
    if (bytes == null) throw StateError('asset not found: \$key');
    return ByteData.sublistView(Uint8List.fromList(bytes));
  }
}

void _extractionContract() {
  group('extractModelAssets', () {
    late Directory dir;

    setUp(() => dir = Directory.systemTemp.createTempSync('vaanisetu_assets'));
    tearDown(() => dir.deleteSync(recursive: true));

    test(
      'writes each asset to the target directory under its basename',
      () async {
        final bundle = _FakeBundle({
          'assets/models/mt/encoder_model.onnx': [0x08, 0x07, 0x12],
          'assets/models/mt/tokenizer_meta.json': [0x7B, 0x7D],
        });

        final paths = await extractModelAssets(
          bundle: bundle,
          targetDir: dir,
          assetKeys: bundle.files.keys.toList(),
        );

        expect(
          File(paths['assets/models/mt/encoder_model.onnx']!).readAsBytesSync(),
          [0x08, 0x07, 0x12],
        );
        expect(File('${dir.path}/tokenizer_meta.json').existsSync(), isTrue);
      },
    );

    test('creates the target directory when missing', () async {
      final nested = Directory('${dir.path}/deep/nested');
      final bundle = _FakeBundle({
        'a/model.onnx': [0x08, 0x07],
      });

      await extractModelAssets(
        bundle: bundle,
        targetDir: nested,
        assetKeys: ['a/model.onnx'],
      );

      expect(File('${nested.path}/model.onnx').existsSync(), isTrue);
    });

    test('does not re-read an asset already extracted', () async {
      final bundle = _FakeBundle({
        'a/model.onnx': [0x08, 0x07],
      });

      await extractModelAssets(
        bundle: bundle,
        targetDir: dir,
        assetKeys: ['a/model.onnx'],
      );
      await extractModelAssets(
        bundle: bundle,
        targetDir: dir,
        assetKeys: ['a/model.onnx'],
      );

      expect(bundle.loaded, ['a/model.onnx'], reason: 'second call re-read it');
    });

    test('re-extracts a file whose size does not match the pin', () async {
      File('${dir.path}/model.onnx').writeAsBytesSync([0x00]);
      final bundle = _FakeBundle({
        'a/model.onnx': [0x08, 0x07, 0x12, 0x0C],
      });

      await extractModelAssets(
        bundle: bundle,
        targetDir: dir,
        assetKeys: ['a/model.onnx'],
        expectedBytes: {'a/model.onnx': 4},
      );

      expect(File('${dir.path}/model.onnx').lengthSync(), 4);
    });

    test('refuses to write a Git LFS pointer', () async {
      final bundle = _FakeBundle({'a/model.onnx': utf8.encode(_lfsPointer)});

      await expectLater(
        extractModelAssets(
          bundle: bundle,
          targetDir: dir,
          assetKeys: ['a/model.onnx'],
        ),
        throwsA(isA<ModelAssetException>()),
      );
      expect(File('${dir.path}/model.onnx').existsSync(), isFalse);
    });
  });
}
