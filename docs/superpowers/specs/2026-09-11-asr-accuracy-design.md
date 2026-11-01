# ASR accuracy improvement — design

Date: 2026-09-11
Component: `models/ASR Model/` (dev + measurement) and `lib/services/` (what ships)
Status: approved design, revised against `dc87772`

## Revision — what `dc87772` changed

This design was first written against a repo where the Flutter UI and the ASR bundle were
unconnected. That premise is dead. `dc87772` ("ASR and Indic Model Integrate") landed a
working end-to-end path: `HindiAsrService` → `TranslateScreen` → `HindiSantaliMtService`
(IndicTrans2 ONNX, `hin_Deva` → `sat_Olck`). Three consequences:

1. **The endpointing sweep is dropped.** `HindiAsrService` sets `enableEndpoint: false`
   because the app is push-to-talk — one `startListening`/`stopListening` pair is exactly one
   utterance. `rule2_min_trailing_silence` never executes in the app. Tuning it would have
   optimised a code path users never reach. It stays relevant only to `listen.py`.
2. **Devanagari-only is promoted from a requirement to the critical path.** MT input is tagged
   `hin_Deva`. Latin runs and ASCII digits from the Hinglish ASR are out-of-script for that tag
   and degrade translation. This is a live end-to-end defect, not a future concern.
3. **The work must land in Dart, not only Python.** Python is the measurement environment;
   `lib/services/` is what ships. Both need the same normalisation, which creates a divergence
   risk — addressed by shared test vectors (Phase 4).

## Environment limits (verified, not assumed)

- **No Flutter or Dart SDK on this machine.** Searched `PATH`, `~`, `/opt`, `/Applications`,
  fvm, asdf. `flutter test` and `flutter analyze` cannot run here, so **Dart written in this
  environment is unverified** and must be reported that way.
- **Model assets are Git LFS pointers.** All six `.onnx`/`.onnx.data` files under
  `assets/models/` and `models/indic_translate/` are 131–134 byte stubs; `git-lfs` is not
  installed. The app cannot run until `brew install git-lfs && git lfs install && git lfs pull`.
  `models/ASR Model/encoder.int8.onnx` is real (committed directly, not LFS), so **Python-side
  ASR work is unblocked**; MT work is blocked.

## Goal

Improve the usable accuracy of the Hindi/Hinglish streaming ASR bundle, and make its
output Devanagari-only so it can feed a Hindi→Santhali translation step.

## Constraints

These were decided with the project owner and bound every choice below.

| Constraint | Value |
|---|---|
| Deployment | Fully offline, on-device. No cloud ASR, no cloud LLM cleanup. |
| Model weights | Frozen. No fine-tuning, no model swap. |
| New files allowed | `silero_vad.onnx` (629 KB, already fetched) and generated FST/text data. No new neural weights beyond VAD. |
| Eval data | 20–60 recordings the owner will make. |
| Output script | Devanagari only. Loanwords transliterated, not dropped. |
| Numbers | Spelled as Hindi words (`5` → `पाँच`). |

## Verified facts

Established by running against the actual bundle, not assumed. These are load-bearing —
several earlier design ideas died on them.

- `sherpa-onnx` 1.13.8; `from_zipformer2_ctc` accepts `ctc_graph`, `ctc_max_active`,
  `rule_fsts`, `rule_fars`, `hr_dict_dir`, `hr_rule_fsts`, `hr_lexicon`,
  `decoding_method`, `num_threads`, `provider`.
- **Per-token timestamps are populated** (`tokens` + `timestamps` aligned). Pause-based
  punctuation is therefore implementable.
- **`ys_probs` comes back empty** on this online CTC path. There is no per-token
  confidence, so hallucination detection must be heuristic.
- The hallucination mode reproduces exactly: 4 s of bit-exact silence decodes to
  `'का  का का का का का का का का का का का का का का'`.
- **VAD works and solves it.** `silero_vad.onnx` flags 116/149 blocks as speech on
  `samples/hi.wav` and **0/124** on bit-exact silence.
- `VoiceActivityDetector.is_speech_detected()` gives a per-block boolean *without*
  consuming segments — required, because `listen.py` documents that dropping blocks
  desyncs the stream clock and stops endpoint detection firing.
- `asr.py` sets `rule2_min_trailing_silence=0.8`; the sherpa-onnx default is `1.2`.
  The bundle is 33% more trigger-happy than stock.
- `transcribe.py` does **not** enable endpointing; `listen.py` does. Batch and streaming
  therefore differ by more than buffering.
- `tokens.txt` is character-level, 104 tokens: 26 Latin `a–z`, 63 Devanagari, 10 digits,
  plus `▁`, `<blk>`, `<unk>`, `<sos/eos>`. Latin output is not a separate mode — it is
  26 tokens in the same output layer.
- **`k2` has no macOS arm64 wheel and no sdist** — the icefall HLG recipe is unavailable
  on this machine. `kaldifst` (cp39 arm64) is installable.

## Non-goals

- Reducing headline WER dramatically. The model is frozen; 25.7% WER is close to its
  ceiling. The wins here are in input conditioning, output shape, and failure modes.
- Flutter integration. Separate project.
- Resampling and DC-offset filtering. CoreAudio already delivers clean 16 kHz in Python.
  Both become mandatory at Flutter integration time (Android will not resample for you,
  and naive decimation folds 8–24 kHz energy into the log-mel bands). Documented, not built.

## Architecture

Four units, each independently testable:

```
capture → audio.py → recognizer → postprocess.py → text
                ↑                        ↑
          silero_vad.onnx          lexicon + number tables
                          eval/ measures the whole chain
```

- **`eval/`** — measurement. Depends on nothing; everything else is judged by it.
- **`audio.py`** — capture conditioning. Shared by `listen.py` and the harness so both
  measure the same pipeline.
- **`postprocess.py`** — text repair. Pure functions, string in / string out.
- **`asr.py`** — unchanged role, gains config plumbing and a VAD checksum pin.

Every behaviour change is a config flag, so the harness can A/B each one in isolation.

## Phase 1 — eval harness (prerequisite)

Nothing else is verifiable without this.

**Fixtures.** `eval/fixtures/*.wav` plus `eval/manifest.jsonl`, one record per line:
`{"audio": ..., "ref": ..., "tags": [...]}`. Tags are `general`, `hinglish`,
`curriculum`, `numbers` — so the four separate concerns produce four separate numbers
instead of one average that hides which is broken.

A fifth tag, `noise`, holds **negative fixtures with empty references**: bit-exact
silence, room tone, and classroom babble with no target speaker. These are scored by
insertion count, not WER (WER against an empty reference is undefined). Success
criterion 2 is unmeasurable without them, and they are the only direct regression test
for the hallucination mode.

**`eval/record.py`.** Records at 16 kHz mono 16-bit directly (the only format
`transcribe.py` accepts), shows a prompt, appends the manifest row. Prompt list is
generated from `lib/data/curriculum_data.dart` — real chapter titles like `मेरा गाँव` —
so the eval set is in-domain by construction.

**`eval/wer.py`.** Reports WER *and* CER. CER matters because Devanagari matra/nukta
errors are partial failures that WER scores as total misses, and because this model's
word segmentation is unreliable. Both computed over a normalizer applying NFC, punctuation
stripping, whitespace collapse, Latin lowercasing, and ZWJ/ZWNJ folding — otherwise we
measure Unicode trivia. Levenshtein alignment implemented in-repo (~30 lines, unit-tested)
rather than adding `jiwer`, consistent with the bundle's self-contained philosophy.

**Two modes.** *Batch* (whole file, like `transcribe.py`) measures the model. *Streaming*
(endpointed, like `listen.py`) measures what a user actually gets, including utterances
chopped by `rule2`. The Phase 2 endpointing work is only visible in streaming mode.

**Output.** Per-utterance table sorted worst-first, aggregate WER/CER per tag, and
`eval/baseline.json` for before/after diffing.

**Statistical caveat, to be respected in every later decision:** at 20–60 utterances the
95% CI on WER is roughly ±3–5 points. Sufficient for "this clearly helped" or "this broke
something"; useless for "this gained 1.2%". Small deltas are noise.

## Phase 2 — input path

**`audio.py`**, shared by `listen.py` and the harness.

**VAD gating.** Every block still reaches the recognizer; VAD decides *what* is in it —
real samples during speech, inaudible dither during non-speech. Never drop blocks. This
generalises the existing zero-block guard: today's check only catches *digital* silence,
so a noisy room with nobody speaking still feeds the model garbage and still produces
`का का का`. VAD catches that case; measured 0/124 false positives on silence.

**Gain normalisation, VAD-gated.** Normalise toward a target RMS on speech blocks only.
Ungated normalisation amplifies the noise floor during silence, which is precisely what
drives hallucination. The ordering is the substance of this item.

**Endpointing sweep — dropped.** See the revision note: the app runs
`enableEndpoint: false` (push-to-talk), so this tunes a code path users never reach. The
`0.8` vs stock `1.2` discrepancy in `asr.py` still affects `listen.py`, and is recorded in
that file as a comment rather than fixed by measurement.

**Dead-mic guard unchanged.** VAD makes it redundant for hallucination prevention, but it
serves a distinct purpose — telling the user macOS denied the microphone — and `CLAUDE.md`
requires keeping it in any new capture path.

**Pin the VAD model.** `silero_vad.onnx`, 643,854 bytes, sha256
`9e2449e1087496d8d4caba907f23e0bd3f78d91fa552479bb9c23ac09cbb1fd6`, verified on load the
same way `asr.py` pins the encoder.

## Phase 3 — output repair

**`postprocess.py`**, pure functions, applied to committed utterances only — never to
partials, which are unstable prefixes.

**Repetition guard** (do first, cheapest). Flag an utterance when a short n-gram repeats
beyond a threshold or unique-token ratio collapses. `ys_probs` being empty rules out a
confidence-based approach. With VAD upstream this should rarely fire; it is defence in
depth for noise VAD misjudges as speech.

**Devanagari-only conversion.** The headline requirement.

1. Curated loanword lexicon: classroom English → conventional Devanagari
   (`school→स्कूल`, `computer→कंप्यूटर`, `test→टेस्ट`, `class→क्लास`).
2. Rule-based G2P fallback for Latin runs not in the lexicon.
3. Never delete Latin runs — that drops content words.

**Known limitation, accepted:** post-hoc conversion inherits ASR errors. `samples/hi.wav`
decodes to `model taste` where the speaker said *test*; we would faithfully render wrong
Devanagari that *looks* confident. Only decoder-level constraint fixes this, and that is
now a spike rather than a plan.

**Numbers to Hindi words.** `5` → `पाँच`. Lookup table for 0–99 (Hindi number words are
irregular and must be enumerated, not composed) plus `सौ`/`हज़ार`/`लाख`/`करोड़` composition.

**Pause-timed punctuation.** Danda `।` at endpoints, comma at intra-utterance gaps above a
calibrated threshold, using the confirmed timestamps. This is **prosodic, not syntactic** —
it will get sentence units roughly right and commas linguistically wrong. Worth it because
the value is giving the translation step sentence boundaries, not publication-quality text.
Measurement subtlety: the Phase 1 normalizer strips punctuation, so this is invisible to
WER by construction and needs its own boundary-count metric or it is unfalsifiable.

**Curriculum lexicon correction.** Spike route (a) before building route (b):
(a) native `hr_lexicon`/`hr_dict_dir`/`hr_rule_fsts` — config plus text files, no new code,
but may be Chinese-homophone-oriented and fit Devanagari badly; (b) Python fuzzy matching
against vocabulary from `curriculum_data.dart` and `vani.pdf`.
**Ship gate:** `curriculum`-tagged WER must improve *and* `general`-tagged WER must not
regress. Aggressive correction helps in-domain speech and corrupts everything else.

## Phase 4 — ship it in Dart

Python measures; Dart ships. The same normalisation must exist in both, which is a
divergence risk, so it is controlled rather than trusted.

**Shared test vectors.** `models/ASR Model/eval/normalizer_cases.json` — input/expected
pairs covering every rule (loanwords, digits, repetition, danda). The Python test suite and
the Dart test suite both consume this one file. It is the single source of truth for
behaviour; neither implementation is allowed to "win" by disagreeing with it.

**`lib/services/asr/hindi_text_normalizer.dart`** — pure functions, no I/O, no plugin
dependencies, so it is testable without a device. Port of the Python normaliser.

**Wiring.** `HindiAsrService.stopListening()` normalises before returning. Partials are
normalised for display only — cheaply, since they are rewritten constantly and are never
sent to MT. The committed transcript is the contract with `HindiSantaliMtService`.

**VAD in Dart.** `silero_vad.onnx` ships as a Flutter asset and gates the capture path the
same way `audio.py` does. The existing bit-exact-zero dead-mic guard stays — it detects a
denied microphone, which VAD does not.

**Honest status:** everything in this phase is unverified in this environment. No Dart SDK
exists here, so the Dart code cannot be compiled, analysed, or tested until someone runs
`flutter test` on a machine that has the SDK and the LFS objects.

## Deferred

- **HLG decoder constraint (spike).** Would make Latin output structurally impossible and
  subsume the loanword lexicon. `k2` is unavailable on this machine; `kaldifst` is
  installable but hand-building H∘L∘G is unproven. Contained question: *can kaldifst
  produce a graph `ctc_graph` loads, fully offline?* Also note an HLG constrains output to
  its lexicon, so out-of-vocabulary words become misrecognitions — it would need a broad
  committed Hindi wordlist, not just curriculum vocabulary.
- Resampling and DC-offset filtering — Flutter integration.
- ITN (words → digits) — the opposite of what is wanted here.

## Success criteria

1. Harness runs, reports WER/CER per tag in both modes, baseline committed.
2. Bit-exact silence and steady room noise produce **empty output**, never `का का का`.
3. Committed transcripts contain **no Latin characters and no ASCII digits** — enforced by a
   test asserting the output codepoint set, not by inspection.
4. `curriculum` WER improves; `general` WER does not regress beyond noise.
5. `verify.py` still passes — checksum pin and sample decode unchanged.
6. Python and Dart normalisers agree on every case in `normalizer_cases.json`.
7. The 19 sentences in `models/test/classroom_sentences.txt` survive a round trip through the
   normaliser unchanged — they are already clean Devanagari, so any edit to them is a
   false positive.
