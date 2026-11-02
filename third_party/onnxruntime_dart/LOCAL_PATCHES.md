# Local patches to the `onnxruntime` package

This is a vendored copy of the `onnxruntime` Flutter plugin, pinned at
**1.4.1** — the latest version on pub.dev as of 2026-09; there is no newer
release. It's checked into this repo (via a `dependency_overrides: path:`
entry in the app's `pubspec.yaml`) rather than used straight from pub.dev
because its Windows support ships with two bugs serious enough to make
every ONNX model fail to load. Both were found and fixed while getting
this app's first Windows build working; the `macos/` and `linux/` platform
folders and the `example/` app were dropped from this copy since this
project never builds for those targets.

## 1. Stale bundled `windows/onnxruntime.dll`

The plugin's own Dart/C++ bindings request ONNX Runtime C API version 28,
but the `onnxruntime.dll` it bundles for Windows is ONNX Runtime 1.15.1,
which only serves API versions up to 15. Every session failed to
initialize on launch:

```
The requested API version [28] is not available, only API versions [1, 15]
are supported in this build. Current ORT Version is: 1.15.1
```

**Fix:** replaced `windows/onnxruntime.dll` with the official Microsoft
build from ONNX Runtime **1.28.0**
(`onnxruntime-win-x64-1.28.0.zip`,
https://github.com/microsoft/onnxruntime/releases/tag/v1.28.0), whose
`ORT_API_VERSION` is exactly 28 — verified against
`include/onnxruntime/core/session/onnxruntime_c_api.h` in that tag.

## 2. `OrtSession.fromFile()` uses the wrong string encoding on Windows

ONNX Runtime's C API declares `CreateSession`'s `model_path` parameter as
`const ORTCHAR_T*`. `ORTCHAR_T` is `wchar_t` (UTF-16) on Windows and `char`
(UTF-8) everywhere else — this is a real, intentional platform difference
in the C API, not an oversight. `OrtSession.fromFile()` in
`lib/src/ort_session.dart` always encoded the path with `toNativeUtf8()`,
so on Windows every path was fed to the native call two bytes at a time as
if it were UTF-16, producing a garbled, nonsense path and a load failure:

```
Bad state: code=3, message=Load model from <mojibake> failed:
Load model <mojibake> failed. File doesn't exist
```

(Switching that one call site to `OrtSession.fromBuffer()` — loading the
model as an in-memory byte buffer instead of a path — avoids the encoding
bug but breaks a *different* thing: ONNX Runtime resolves an external-data
file (`*.onnx.data`, used by larger models exported with `external_data`)
relative to the model's own file path, and a buffer has no such path to
resolve against — verified on-device with an "External data path...
escapes working directory" failure once `fromFile` was replaced with
`fromBuffer`. So loading from a real file path, correctly encoded, is the
only fix that works for external-data models.)

**Fix:** `OrtSession.fromFile()` now checks `Platform.isWindows` and uses
`toNativeUtf16()` there, `toNativeUtf8()` everywhere else (see the doc
comment on that constructor for the exact diff and reasoning). No other
call site needed this — every other native call in this package passes
tensor/provider/input/output *names*, which the C API always declares as
plain `char*` regardless of platform; only file-path parameters use
`ORTCHAR_T`.

## If this plugin ever gets fixed upstream

If a future `onnxruntime` release ships a current Windows DLL and a
platform-aware `fromFile()`, delete this `third_party/onnxruntime_dart`
directory, drop the `dependency_overrides` entry from the app's
`pubspec.yaml`, and bump the version in the app's regular `dependencies`
section instead.
