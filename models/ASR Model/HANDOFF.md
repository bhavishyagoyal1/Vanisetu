# betterflow Hindi/Hinglish streaming ASR — handoff bundle

Self-contained. Weights are in this folder, no download needed, no network at runtime.

Upstream: `mobilebytesensei/betterflow-hindi-streaming-ctc`, revision `2c8ad90`
(a pinned mirror of `Vengadanathan/hindi-hinglish-zipformer-ctc-streaming`, Phase 3, ~337h).
License **Apache-2.0** for both weights and upstream source.

## Setup

```bash
python3 -m venv venv && ./venv/bin/pip install -r requirements.txt
./venv/bin/python verify.py
```

`verify.py` checks the sha256 against the pinned revision and decodes the sample clip.
Expected output: `OK: bundle verified.`

## Use

```bash
./venv/bin/python transcribe.py samples/hi.wav   # file -> text
./venv/bin/python listen.py                      # live mic
```

As a library:

```python
from transcribe import transcribe
text = transcribe("clip.wav", verbose=False)
```

## What the output looks like (read this before wiring it to MT)

Sample clip decodes to:

```
नमस्ते मेरा नाम समर्थ है मैं आज एक नया model taste कर रहा हूं
```

Four properties that matter for a downstream translation model:

1. **Code-switched script.** Hindi comes out in Devanagari, English loanwords come out in
   **Latin** (`model`, not `मॉडल`). This is a Hinglish model and that behaviour is intended.
   Your MT input is mixed-script by design — don't "fix" it by transliterating.
2. **No punctuation, no sentence casing.** Nothing emits `,` `.` `?`. If your MT model expects
   punctuated input, you need a punctuation-restoration step between ASR and MT.
3. **Partials are unstable prefixes.** During speech the hypothesis rewrites itself
   (`नमस` → `नमस्ते`). Only feed MT the **committed** utterance — the `>>>` lines in `listen.py`,
   or the return of `transcribe()` — never the `...` partials.
4. **Accuracy.** Upstream reports 25.7% WER on IndicVoices-hi, 39.9% on Hinglish call audio.
   At ~40% WER on conversational Hinglish, MT will be translating noisy input; budget for that.

## Audio requirements

**16 kHz, mono, 16-bit PCM wav.** `transcribe.py` refuses anything else rather than decoding
garbage. Convert with:

```bash
ffmpeg -i input.m4a -ar 16000 -ac 1 -c:a pcm_s16le out.wav
```

## Two gotchas that cost real debugging time

**Tail words vanish without trailing silence.** Zipformer has right-context lookahead, so calling
`input_finished()` immediately after the last speech sample drops the final word. `transcribe.py`
appends 0.5 s of silence to flush it. Measured: 0.0 s loses the word, 0.3 s recovers it.

**All-zero audio makes the model hallucinate.** Fed bit-exact silence it emits confident runs of
`का का का का ...` — text nobody said. This is how a muted/permission-denied mic presents, since
the OS hands out digital silence rather than an error. `listen.py` detects it and prints
instructions instead. Real room noise is fine (decodes to empty). If you build your own capture
path, keep that guard — silent failure that produces plausible text is the worst kind.

## Files

| File | What |
|---|---|
| `encoder.int8.onnx` | Streaming zipformer2 CTC encoder, int8. 68,954,634 bytes, sha256 `e5758a0c…6d039` |
| `tokens.txt` | CTC vocabulary, 104 entries, `<token> <id>` |
| `asr.py` | Model loading + checksum verification |
| `transcribe.py` | File → text |
| `listen.py` | Live mic |
| `verify.py` | Integrity + smoke test |
| `samples/hi.wav` | 4.8 s Hindi clip (macOS `say -v Lekha`, synthetic) |
| `MODEL_CARD.md` | Original HF model card |

`encoder.int8.onnx` and `tokens.txt` are a **matched pair** — `tokens.txt` line order *is* the
encoder's output-layer index order (id 0 = `<blk>`, the CTC blank; `▁` U+2581 is the word
boundary). Re-sorting or editing either one alone silently corrupts decoding. Replace both together
or neither.

Because this is CTC rather than a transducer, sherpa-onnx needs **only** the encoder plus tokens.
There is no decoder or joiner file missing from this bundle.

## Performance

Measured on an M-series MacBook Air, CPU only, single stream: **RTF ~0.04** (about 25x faster than
real time), model load ~0.5 s, first partial emitted ~0.5 s into speech. Partials arrive *during*
speech, so first-partial latency is roughly constant instead of scaling with utterance length —
that streaming property is why this model was chosen over batch Whisper.

## If they'd rather not take the 66 MB

The repo is public, so the alternative to copying this folder is:

```python
from huggingface_hub import hf_hub_download
enc = hf_hub_download("mobilebytesensei/betterflow-hindi-streaming-ctc",
                      "encoder.int8.onnx", revision="2c8ad90")
```

Pin `revision` either way — downstream consumers verify the checksum above.
