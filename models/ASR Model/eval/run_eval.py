#!/usr/bin/env python3
"""Score the ASR against recorded fixtures.

    ./venv/bin/python eval/run_eval.py                 # score everything
    ./venv/bin/python eval/run_eval.py --raw           # no conditioning, no normalizing
    ./venv/bin/python eval/run_eval.py --no-vad        # isolate the VAD's contribution
    ./venv/bin/python eval/run_eval.py --save-baseline # write eval/baseline.json

Every stage is a flag so its contribution can be isolated. A change that
cannot be isolated cannot be defended.

Read the caveat before trusting a number: at 20-60 utterances the 95%
confidence interval on WER is roughly +/-3-5 points. That is enough to catch
"this clearly helped" or "this broke something", and useless for "this gained
1.2%". Small deltas are noise.
"""
import argparse
import json
import os
import sys
import wave
from collections import defaultdict

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from asr import SAMPLE_RATE, build_recognizer  # noqa: E402
from audio import AudioConditioner  # noqa: E402
from normalize import normalize  # noqa: E402
from eval.wer import score  # noqa: E402

HERE = os.path.dirname(os.path.abspath(__file__))
MANIFEST = os.path.join(HERE, "manifest.jsonl")
BASELINE = os.path.join(HERE, "baseline.json")
BLOCK = SAMPLE_RATE // 10


def load_manifest(path=MANIFEST):
    if not os.path.exists(path):
        raise SystemExit(
            "No fixtures yet: {} does not exist.\n"
            "Record some with:  ./venv/bin/python eval/record.py".format(path)
        )
    records = []
    with open(path, encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if line:
                records.append(json.loads(line))
    if not records:
        raise SystemExit("{} is empty - record some fixtures first.".format(path))
    return records


def load_wav(path):
    with wave.open(path) as w:
        if w.getnchannels() != 1 or w.getsampwidth() != 2 or w.getframerate() != SAMPLE_RATE:
            raise SystemExit(
                "{}: need 16 kHz mono 16-bit PCM, got {} Hz {}ch {}-bit".format(
                    path, w.getframerate(), w.getnchannels(), w.getsampwidth() * 8
                )
            )
        pcm = np.frombuffer(w.readframes(w.getnframes()), dtype=np.int16)
    return pcm.astype(np.float32) / 32768.0


def transcribe(recognizer, samples, conditioner):
    """Decode one clip the way the app does: 100 ms blocks, then a flush."""
    stream = recognizer.create_stream()
    for start in range(0, len(samples), BLOCK):
        block = samples[start:start + BLOCK]
        if conditioner is not None:
            block = conditioner.process(block)
        stream.accept_waveform(SAMPLE_RATE, block)
        while recognizer.is_ready(stream):
            recognizer.decode_stream(stream)

    # Zipformer looks ahead, so without trailing silence the last word never
    # flushes (see HANDOFF.md).
    stream.accept_waveform(SAMPLE_RATE, np.zeros(SAMPLE_RATE // 2, dtype=np.float32))
    stream.input_finished()
    while recognizer.is_ready(stream):
        recognizer.decode_stream(stream)
    return recognizer.get_result(stream).strip()


def run(records, raw=False, use_vad=True, use_gain=True):
    recognizer = build_recognizer()
    results = []
    for record in records:
        path = record["audio"]
        if not os.path.isabs(path):
            path = os.path.join(HERE, path)
        samples = load_wav(path)

        conditioner = None
        if not raw:
            conditioner = AudioConditioner(
                enable_vad=use_vad, enable_gain=use_gain, seed=0
            )

        text = transcribe(recognizer, samples, conditioner)
        if not raw:
            # The same gate the app applies: no speech in the session means no
            # transcript, whatever the decoder emitted.
            heard = conditioner.saw_speech if conditioner else True
            text = normalize(text) if heard else ""

        results.append({
            "audio": record["audio"],
            "tags": record.get("tags", []),
            "ref": record["ref"],
            "hyp": text,
        })
    return results


def report(results):
    overall = score([r["ref"] for r in results], [r["hyp"] for r in results])

    by_tag = defaultdict(list)
    for result in results:
        for tag in result["tags"] or ["untagged"]:
            by_tag[tag].append(result)

    print("\n{:<12} {:>6} {:>8} {:>8} {:>6}".format("tag", "n", "WER", "CER", "ins"))
    print("-" * 44)
    for tag in sorted(by_tag):
        rows = by_tag[tag]
        tag_score = score([r["ref"] for r in rows], [r["hyp"] for r in rows])
        print("{:<12} {:>6} {:>7.1%} {:>7.1%} {:>6}".format(
            tag, len(rows), tag_score.wer, tag_score.cer, tag_score.insertions))
    print("-" * 44)
    print("{:<12} {:>6} {:>7.1%} {:>7.1%} {:>6}".format(
        "ALL", overall.utterances, overall.wer, overall.cer, overall.insertions))

    worst = sorted(
        results,
        key=lambda r: score([r["ref"]], [r["hyp"]]).wer,
        reverse=True,
    )[:5]
    print("\nworst utterances:")
    for result in worst:
        if not result["ref"] and not result["hyp"]:
            continue
        print("  ref: {}".format(result["ref"] or "(silence)"))
        print("  hyp: {}\n".format(result["hyp"] or "(empty)"))

    print("Caveat: at this sample size the 95% CI on WER is roughly +/-3-5 "
          "points.\nTreat small differences as noise.")
    return overall


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--raw", action="store_true",
                        help="skip conditioning and normalizing (the baseline)")
    parser.add_argument("--no-vad", action="store_true", help="disable VAD gating")
    parser.add_argument("--no-gain", action="store_true", help="disable gain normalisation")
    parser.add_argument("--save-baseline", action="store_true")
    args = parser.parse_args()

    records = load_manifest()
    results = run(records, raw=args.raw, use_vad=not args.no_vad,
                  use_gain=not args.no_gain)
    overall = report(results)

    if args.save_baseline:
        with open(BASELINE, "w", encoding="utf-8") as handle:
            json.dump({"overall": overall._asdict(), "results": results},
                      handle, ensure_ascii=False, indent=2)
        print("\nwrote {}".format(BASELINE))
    return 0


if __name__ == "__main__":
    sys.exit(main())
