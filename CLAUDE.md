# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

VaaniSetu is a Flutter app (package `vaanisetu`, Dart SDK `^3.12.2`) for teachers and students in
Jharkhand government primary schools: speak Hindi, get Santali (Ol Chiki), and browse the state's
abridged Class 1–5 curriculum. Everything runs **fully offline on-device** — that constraint drives
every architectural decision here.

The end-to-end voice path is live as of `dc87772`:

```
mic → HindiAsrService (sherpa-onnx, streaming zipformer2 CTC)
    → Hindi text in TranslateScreen's source field
    → HindiSantaliMtService (IndicTrans2 ONNX, hin_Deva → sat_Olck)
    → Ol Chiki output
```

Only Hindi→Santali works. `_translate()` explicitly refuses other targets rather than
mistranslating; Mundari and Ho are in `translateLanguages` but have no model.

## Read this before running anything

**Two blockers exist in a fresh clone.** Both bite silently.

1. **Model assets are Git LFS pointers.** `.gitattributes` LFS-tracks `assets/models/**/*.onnx`
   and `*.onnx.data`. Without `git-lfs` installed these files check out as ~133-byte text stubs and
   the app fails at model load. Verify before debugging anything model-related:
   ```bash
   head -c 40 assets/models/mt/encoder_model.onnx   # "version https://git-lfs..." = pointer, not model
   ```
   Fix: `brew install git-lfs && git lfs install && git lfs pull`.
   The ASR encoder under `models/ASR Model/` is the exception — committed directly, always real.

2. **No Flutter/Dart SDK is installed on this machine** (checked `PATH`, `~`, `/opt`,
   `/Applications`, fvm, asdf). `flutter test`, `flutter analyze`, and `flutter pub get` cannot run
   here. Dart changes made in this environment are **unverified** — say so rather than implying they
   compile.

## Commands

```bash
flutter pub get                      # after any pubspec.yaml change
flutter run -d <device>              # Android is the only tested target
flutter analyze
flutter test
flutter test test/mt_preprocessor_test.dart --plain-name '<name>'   # single test
dart run flutter_launcher_icons      # regenerate icons from assets/images/app_icon*.png
```

ASR bundle (folder name contains a space — quote it):

```bash
cd "models/ASR Model"
python3 -m venv venv && ./venv/bin/pip install -r requirements.txt
./venv/bin/python verify.py               # expect "OK: bundle verified."
./venv/bin/python transcribe.py samples/hi.wav
./venv/bin/python listen.py               # live mic; needs terminal mic permission
```

## Architecture

Navigation is plain `Navigator.push` — no router, no state-management package. Screen state is
local `StatefulWidget` state. Flow: `main.dart` → `SplashScreen` → `RoleSelectionScreen` →
`TeacherScreen` (Translate + Curriculum) or `StudentScreen` (Translate + a "Learn" placeholder).

### Services (`lib/services/`)

Both are lazily-initialized singletons that extract their models from the asset bundle to
`getApplicationSupportDirectory()` on first use, then keep them resident. First call is slow
(tens of MB of extraction plus session build); later calls are not.

- **`hindi_asr_service.dart`** — streaming zipformer2 CTC via the `sherpa_onnx` plugin.
  **Push-to-talk, not dictation:** `enableEndpoint: false`, so one `startListening`/`stopListening`
  pair is exactly one utterance and a mid-sentence pause never auto-commits. `onPartial`
  hypotheses are unstable prefixes — only `stopListening()`'s return is a committed transcript.
  Carries the dead-mic guard (bit-exact-zero blocks → dither + error), which must survive any
  rewrite of the capture path.
- **`mt/hindi_santali_mt_service.dart`** — IndicTrans2 INT8 ONNX, hand-written greedy decode with a
  KV cache across three graphs (`encoder`, `decoder`, `decoder_with_past`) driven through the
  `onnxruntime` plugin.
- **`mt/indic_preprocessor.dart`** and **`mt/bpe_tokenizer.dart`** — a from-scratch port of
  AI4Bharat's `IndicTransToolkit` preprocessing. Their doc comments record what was verified
  against the reference implementation and why; read them before altering tokenization.

### Script contract between ASR and MT

The ASR is a **Hinglish** model: `tokens.txt` is character-level, 104 tokens — 26 Latin `a–z`,
63 Devanagari, 10 ASCII digits, plus `▁`/`<blk>`/`<unk>`/`<sos/eos>`. It therefore emits
code-switched output (`model`, not `मॉडल`) and bare digits, exactly as `HANDOFF.md` describes.

MT input is declared `hin_Deva`. Latin runs and ASCII digits reaching the translator are
out-of-script for that tag. **Transcripts handed to MT must be Devanagari-only, with numbers spelled
as Hindi words** — see `docs/superpowers/specs/2026-09-11-asr-accuracy-design.md`.

### Data is hardcoded const, not fetched

- `lib/data/curriculum_data.dart` — classes 1–5, transcribed from `vani.pdf` (Jharkhand School
  Education Dept. abridged 2021-22 syllabus). Chapters marked "पूर्णतः विलोपित" / "Not Included" in
  the source are deliberately omitted; keep that rule when editing.
- `lib/data/translation_languages.dart` — `TranslateScreen` hardcodes Hindi as source and filters to
  `sat`/`unr` as pickable targets, so adding an entry here does not by itself make it usable.

### Theme

Material 3 seeded from navy `0xFF1B3A6B` in `main.dart`. Brand colors in `lib/theme/app_colors.dart`;
`splash_screen.dart` re-declares the same hexes privately. Older screens (`OptionTile`,
`RoleSelectionScreen`, `StudentScreen`) use `colorScheme`; newer ones (`TeacherScreen`,
`TranslateScreen`, curriculum screens) use `AppColors` + gradients. Match the file you're editing.

## ASR bundle notes

`models/ASR Model/HANDOFF.md` is authoritative. Load-bearing points:

- Encoder-only (CTC needs no decoder/joiner); `asr.py` verifies the encoder's pinned sha256 on load.
- `encoder.int8.onnx` and `tokens.txt` are a matched pair — token line order *is* output-layer index
  order. Replace both together or neither.
- Input must be 16 kHz mono 16-bit PCM.
- Output is unpunctuated and uncased. Partials are unstable prefixes.
- **Bit-exact silence makes the model hallucinate confident text** (verified: 4 s of zeros decodes to
  `का का का का…`). Both `listen.py` and `HindiAsrService` guard against it. Keep that guard.

`models/indic_translate/` holds the MT model's source copy and provenance README; `models/test/`
holds throwaway Python scripts for it, including `classroom_sentences.txt` — 19 real classroom Hindi
sentences useful as in-domain test material.

`betterflow-hindi-streaming-ctc/` at the repo root is unrelated and gitignored.
