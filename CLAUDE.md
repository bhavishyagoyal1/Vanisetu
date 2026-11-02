````# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

VaaniSetu is a Flutter app (package `vaanisetu`, Dart SDK `^3.12.2`) for teachers and students in
Jharkhand government primary schools: speak or type Hindi, get Santali (Ol Chiki) back — spoken
aloud if you want — plus the state's abridged Class 1–5 curriculum and a Hindi↔Santali dictionary.
Everything runs **fully offline on-device**, and the target hardware is a **2GB-RAM Android
tablet**. Those two constraints drive nearly every architectural decision here.

The voice path:

```
mic → HindiAsrService (sherpa-onnx streaming zipformer2 CTC, push-to-talk)
    → AudioConditioner (VAD + dither) → normalizeTranscript() → Devanagari-only Hindi
    → TranslateScreen → InferenceIsolate → HindiSantaliMtService (IndicTrans2 ONNX)
    → Ol Chiki → SantaliTtsService (Piper VITS ONNX) → WAV → audioplayers
```

Hindi↔Santali works **in both directions** (one multilingual IndicTrans2 model, different language
tags — see `HindiSantaliMtService`'s class doc). Mundari (`unr`) and Ho (`hoc`) appear in
`translation_languages.dart` but have no model; `_translate()` refuses them rather than
mistranslating. There is no Santali ASR, so the reverse direction is type-only (no mic).

## Read this before running anything

**Model assets are Git LFS pointers, and `git-lfs` is not installed on this machine.** Right now
every file under `assets/models/{mt,tts}/*.onnx` and `*.onnx.data` is a ~133-byte text stub, so the
app will fail at model load while tests and analysis pass fine. Verify before debugging anything
model-related:

```bash
head -c 40 assets/models/mt/encoder_model.onnx   # "version https://git-lfs..." = pointer, not model
```

Fix: `brew install git-lfs && git lfs install && git lfs pull`.

Every model extraction path now runs `verifyModelAsset` (`lib/services/model_assets.dart`) before
handing a path to native code, so a stub surfaces as a Dart exception naming the fix. Without that
guard the pointer reaches sherpa-onnx/onnxruntime, is parsed in C++, and aborts the process — the
app vanishes with nothing catchable in Dart and no message. Keep the guard on any new model you
bundle.

Deliberate exceptions that are always real bytes: `assets/models/vad/silero_vad.onnx` (explicitly
un-LFS'd in `.gitattributes` so a clone without LFS still gets a working VAD), the MT tokenizer
JSONs, and the ASR encoder under `models/ASR Model/`.

Flutter **is** installed (`/opt/homebrew/bin/flutter`, 3.47.3 stable / Dart 3.13.3). As of the last
check `flutter test` passes 11/11 and `flutter analyze` reports 4 pre-existing info-level lints
(deprecated `Radio.groupValue`/`onChanged` in `settings_screen.dart`, two `curly_braces_in_flow_control_structures`
in the TTS services). Treat anything beyond those four as introduced by your change.

## Commands

```bash
flutter pub get                      # after any pubspec.yaml change
flutter run -d <device>              # Android is the only tested target
flutter analyze
flutter test
flutter test test/mt_preprocessor_test.dart --plain-name '<name>'   # single test
dart run flutter_launcher_icons      # regenerate icons from assets/images/app_icon*.png
```

ASR bundle (folder name contains a space — quote it). Its venv exists but has no `pytest`, so
install that before running the Python-side tests:

```bash
cd "models/ASR Model"
python3 -m venv venv && ./venv/bin/pip install -r requirements.txt
./venv/bin/python verify.py               # expect "OK: bundle verified."
./venv/bin/python transcribe.py samples/hi.wav
./venv/bin/python listen.py               # live mic; needs terminal mic permission
./venv/bin/pip install pytest && ./venv/bin/python -m pytest tests
```

## Architecture

No router and no state-management package. Screen state is local `StatefulWidget` state; services
are lazily-initialized singletons. There are exactly two pieces of global state — the app language
and the chosen role — each a `ValueNotifier` persisted to `shared_preferences` and exposed through
an `InheritedNotifier` scope wrapped around the app in `main.dart`.

### Navigation shell

`main.dart` → `SplashScreen` → `RoleSelectionScreen` → `MainShell`. The role screen follows the
logo on **every** launch — these tablets are shared, so the answer can change between sessions. `MainShell` is a 3-tab `PageView` (Curriculum ·
**Translate** (landing tab, index 1, visually featured) · Dictionary) where **each tab owns a nested
`Navigator`**, so drilling into Curriculum → Class → Subject → Chapter → content pushes inside that
tab and the bottom bar stays visible. Swiping between tabs is gated on the active tab being at its
root, and the system back button pops the active tab's stack before exiting. Its doc comment records
two on-device bugs already fixed here (fractional `PageView` page after backgrounding mid-swipe) —
read it before touching the shell. `lib/widgets/option_tile.dart` is left-over dead code; nothing
references it.

### Everything heavy runs on one background isolate

`lib/services/inference_isolate.dart` is the **only** thing UI code should call for MT and TTS.
`onnxruntime` binds through `dart:ffi`, so every `session.run()` is a synchronous CPU-bound native
call on the calling isolate; a translate is up to 128 greedy-decode steps × 2 graphs, which froze
the UI thread outright on the 2GB tablet. One long-lived worker isolate serves MT and both TTS
voices (they are never used concurrently), which also keeps the large ONNX sessions off the UI
isolate's heap entirely. Do not add a direct `HindiSantaliMtService`/`*TtsService` call from a
widget. ASR is the exception — sherpa-onnx streams through its own plugin and stays on the main
isolate.

**No `rootBundle` on the worker isolate.** `PlatformAssetBundle.load` goes through
`ServicesBinding.instance`, and `ServicesBinding` exists only on the root isolate — a spawned one
throws *"Binding has not yet been initialized"*. `BackgroundIsolateBinaryMessenger.ensureInitialized`
does not help: it wires up plugin channels but creates no binding. So each service splits asset
handling in two: `prepareAssets()` reads the bundle and is called by `InferenceIsolate` on the root
isolate before it dispatches anything, and `_ensureInitialized()` on the worker opens files only,
throwing if they are absent. Keep that split for any model you add. It bites only on a fresh
install, because extraction is guarded by `if (!await file.exists())` — which is why it went
unnoticed until real models first landed on a clean device.

### Services (`lib/services/`)

Each singleton extracts its models from the asset bundle to `getApplicationSupportDirectory()` on
first use and keeps them resident; first call is slow, later calls are not.

- **`hindi_asr_service.dart`** — streaming zipformer2 CTC. **Push-to-talk, not dictation:**
  `enableEndpoint: false`, so one `startListening`/`stopListening` pair is exactly one utterance and
  a mid-sentence pause never auto-commits. `onPartial` hypotheses are unstable prefixes; only
  `stopListening()`'s return is committed (and normalized + hallucination-gated).
- **`asr/audio_conditioner.dart`** — port of `models/ASR Model/audio.py`. Two invariants it exists
  to hold: never change the sample count (that desyncs the recognizer's stream clock), and never
  hand the model bit-exact silence (verified: zeros decode to confident `का का का…`). The Silero VAD
  is optional by design — if it fails to load, gating degrades to energy-only rather than taking the
  mic down.
- **`asr/hindi_text_normalizer.dart`** — Hinglish→`hin_Deva` cleanup plus `isHallucinated()`.
- **`mt/hindi_santali_mt_service.dart`** — IndicTrans2 INT8 ONNX, hand-written greedy decode with a
  KV cache across three graphs (`encoder`, `decoder`, `decoder_with_past`).
- **`mt/indic_preprocessor.dart`**, **`mt/bpe_tokenizer.dart`** — from-scratch port of AI4Bharat's
  `IndicTransToolkit` preprocessing. Their doc comments record what was verified against the
  reference implementation; read them before altering tokenization.
- **`tts/santali_tts_service.dart`** — Piper VITS ONNX, `phoneme_type: "text"`, so phonemization is
  just per-character ids — no espeak needed.
- **`tts/hindi_tts_service.dart`** — a bundled Hindi Piper voice needing espeak-ng via
  `piper_phonemize`. **It is not wired up.** On-device it reliably SIGABRTs the whole process the
  first time it runs (native abort inside `libflutter.so`, confirmed via two tombstones; bypasses
  Dart try/catch, so a Dart-level fallback can never run). `TranslateScreen._speakHindi` uses
  Android's system TTS via `flutter_tts` instead. Root cause is still open — see that method's doc
  comment before re-enabling.

### Script contract between ASR and MT

The ASR is a **Hinglish** model: `tokens.txt` is character-level, 104 tokens — 26 Latin `a–z`, 63
Devanagari, 10 ASCII digits, plus `▁`/`<blk>`/`<unk>`/`<sos/eos>`. It emits code-switched output
(`model`, not `मॉडल`) and bare digits. MT input is declared `hin_Deva`, for which Latin runs and
ASCII digits are out of script, so **transcripts handed to MT must be Devanagari-only with numbers
spelled as Hindi words**.

`hindi_text_normalizer.dart` and `models/ASR Model/normalize.py` are two implementations of one
contract, pinned by shared vectors in `models/ASR Model/eval/normalizer_cases.json` and read by both
`test/asr_normalizer_test.dart` and `models/ASR Model/tests/test_normalize.py`. **Change one side
without the other and the tests fail — that is the point.** Design rationale lives in
`docs/superpowers/specs/2026-09-11-asr-accuracy-design.md`.

Hallucination gating happens twice on purpose: on `stopListening()`'s committed transcript, and
again in `TranslateScreen._translate()`, because live mid-recording partials bypass the first check.

### Translate screen

`translate_screen.dart` is the landing tab and the densest screen in the app. Two things constrain
edits to it:

- **Sizing goes through `_Metrics`**, a three-step scale (`< 360` compact · `< 600` regular · else
  large) picked from `LayoutBuilder`. Content is capped at 560px and centred, so a tablet gets a
  phone-shaped column rather than stretched cards. Add new sizes there, not as inline width
  conditionals. `test/translate_screen_test.dart` asserts no overflow at four widths.
- **The mic is tap-to-toggle**: one tap starts, the next commits. The button is disabled while
  `_starting`, so a second tap cannot race the (slow, first-run) model load and leave capture
  running with nothing able to stop it.

The header carries an EN/हिंदी toggle for the app's own display language (not the translation
languages). Its Hindi label is the full endonym on purpose — `हिं` is already the Hindi badge in the
language bar, and two identical chips would read as one control.

The `Cleaned ASR` badge is a claim about what actually ran, not decoration: it is driven by
`transcriptWasCleaned`, which is deliberately false when normalization only appended a danda, so it
can only mean the script was rewritten. Anything similar you add should stay falsifiable — there is
no English gloss on this screen because the bundled IndicTrans2 is indic-indic and cannot produce
one.

`lib/data/classroom_prompts.dart` holds the one-tap sentence chips, copied verbatim from
`models/test/classroom_sentences.txt` and pinned to it by a test. Chip labels must be a subset of the
sentence they insert.

### Roles

`lib/role/app_role.dart` — `AppRole { teacher, student }`, `AppRoleController`, `AppRoleScope`,
built to mirror the `AppLanguage` trio exactly. Three things to know:

- **`null` is a real state**, meaning "not chosen yet". The splash no longer branches on it — it
  always shows `RoleSelectionScreen` — but the stored value is still loaded there (in parallel with
  the splash delay) so the screen can mark the role carried over from last session. Never silently
  default it to a role.
- **`AppRoleScope.of` vs `.read`** — `of` subscribes to changes and is illegal before `initState`
  completes; `SplashScreen` needs the role from `initState`, so it uses `read`, which does not
  subscribe. `load()` is memoized so the splash awaiting it cannot clobber a role set since.
- **The role is not a permission boundary.** It only picks which study material
  `ChapterDetailScreen` offers: teachers get Worksheet + Flashcards + Assessment-as-answer-key
  (`AssessmentScreen(showAnswers: true)` — correct options marked on open, no scoring or submit),
  students get Flashcards + the quiz. The worksheet is teacher-only because `ChapterContent.worksheet`
  is a plain `List<String>` with **no answer data for any of the 221 chapters** — adding a
  student-facing worksheet means authoring answers first. Settings switches role at any time.

### Localization

`lib/l10n/` — `AppLanguage` (en/hi, persisted via `shared_preferences`), `AppLanguageScope`
(`InheritedNotifier`), and `AppStrings` with `tr(context, 'key', {params})`. This covers **UI chrome
only**. Content data — curriculum chapter titles, dictionary entries, chapter worksheets — stays in
its source language regardless of display language. New user-facing chrome string ⇒ add both the
English and Hindi entries in `app_strings.dart`.

### Data is hardcoded const, not fetched

- `lib/data/curriculum_data.dart` — classes 1–5 transcribed from `vani.pdf` (Jharkhand School
  Education Dept. abridged 2021-22 syllabus). Chapters marked "पूर्णतः विलोपित" / "Not Included" in
  the source are deliberately omitted; keep that rule when editing.
- `lib/data/chapter_content_map.dart` — ~10.8k lines of Worksheet/Flashcards/Assessment content
  keyed `"Class {n}|{subject}|{chapter}"` (build the key with `chapterContentKey()`). Generated from
  `lib/data/chapter_content/class_*.json`; **edit the JSON and regenerate rather than hand-editing
  the Dart map.** Only chapter *titles* have an upstream source — the content itself was authored,
  so its header doc records what may and may not be invented.
- `lib/data/dictionary_data.dart` — MT-generated, human-filtered, **not** native-speaker verified.
  Its header documents the two failure modes that made entries get dropped (wrong-script output,
  distinct words collapsing to one translation — which is why numbers above ten were excluded
  wholesale). Respect that when adding entries.
- `lib/data/translation_languages.dart` — `TranslateScreen` hardcodes Hindi as one side and filters
  to `sat`/`unr` as pickable targets, so adding an entry here does not by itself make it usable.

### Diagnostics

`lib/diagnostics/` — an opt-in (Settings toggle) always-on-top RSS overlay reading `dart:io`'s
`ProcessInfo`, budgeted against the 2GB device target. RSS, not Dart heap, because the native ONNX
allocations are the dominant cost.

### Theme

Material 3 seeded from navy `0xFF1B3A6B` in `main.dart`. Brand colors in `lib/theme/app_colors.dart`
(`navy`/`teal`/`orange`); `splash_screen.dart` re-declares the same three hexes privately. Screens
use `AppColors` + gradients directly; only `main.dart` and the unused `OptionTile` touch
`colorScheme`.

## ASR bundle notes

`models/ASR Model/HANDOFF.md` is authoritative. Load-bearing points:

- Encoder-only (CTC needs no decoder/joiner); `asr.py` verifies the encoder's pinned sha256 on load.
- `encoder.int8.onnx` and `tokens.txt` are a matched pair — token line order *is* output-layer index
  order. Replace both together or neither.
- Input must be 16 kHz mono 16-bit PCM. Output is unpunctuated and uncased.
- **Bit-exact silence makes the model hallucinate confident text.** Both `listen.py` and the Dart
  path guard against it. Keep that guard.

`models/indic_translate/`, `models/SantaliVoice/`, and `models/HindiTTS/` hold each bundled model's
source copy and provenance README/`app.py`. `models/test/` holds throwaway Python scripts for MT,
including `classroom_sentences.txt` — 19 real classroom Hindi sentences useful as in-domain test
material. `betterflow-hindi-streaming-ctc/` at the repo root is unrelated and gitignored.
````