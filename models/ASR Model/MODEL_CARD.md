---
license: apache-2.0
language: [hi, en]
tags: [automatic-speech-recognition, zipformer, ctc, streaming, hindi, hinglish, sherpa-onnx]
---
# betterflow — Hindi/Hinglish streaming CTC (sherpa-onnx)

Streaming zipformer2 CTC exported to ONNX for on-device dictation. Emits partials DURING speech, so
first-partial latency is constant (~155 ms class) rather than proportional to utterance length —
the property batch whisper structurally lacks.

- **encoder.int8.onnx** (69 MB) + **tokens.txt** (104 Devanagari codepoint tokens)
- Load with sherpa-onnx 
- Source weights: [Vengadanathan/hindi-hinglish-zipformer-ctc-streaming](https://huggingface.co/Vengadanathan/hindi-hinglish-zipformer-ctc-streaming) Phase 3 (~337h), Apache-2.0. 25.7% WER IndicVoices-hi / 39.9% Hinglish calls.
- Exported + int8-quantized + verified decoding real MUCS Hinglish via sherpa-onnx 1.13.4. Casing is a non-issue: Devanagari has no case.

Mirrored so betterflow can pin an immutable revision and checksum. Weights unmodified but for int8 quantization.
