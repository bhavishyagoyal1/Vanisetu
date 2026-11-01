#!/usr/bin/env python3
"""Record evaluation fixtures at the one format the recognizer accepts.

    ./venv/bin/python eval/record.py              # work through the prompts
    ./venv/bin/python eval/record.py --list       # show input devices
    ./venv/bin/python eval/record.py --noise      # record noise-only fixtures

Records 16 kHz mono 16-bit directly, so nothing needs converting afterwards
and transcribe.py will never reject a fixture.

Prompts come from the repo itself - the classroom sentences the MT work
already collected, plus real chapter titles from the curriculum the app ships
- so the eval set is in-domain by construction rather than by luck.
"""
import argparse
import json
import os
import re
import sys
import wave

import numpy as np

try:
    import sounddevice as sd
except ImportError:  # pragma: no cover - only hit without the optional dep
    sd = None

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, os.pardir, os.pardir, os.pardir))
FIXTURES = os.path.join(HERE, "fixtures")
MANIFEST = os.path.join(HERE, "manifest.jsonl")
SAMPLE_RATE = 16000

CLASSROOM = os.path.join(REPO, "models", "test", "classroom_sentences.txt")
CURRICULUM = os.path.join(REPO, "lib", "data", "curriculum_data.dart")

_DEVANAGARI_QUOTED = re.compile(r"'([^']*[ऀ-ॿ][^']*)'")


def _classroom_prompts():
    if not os.path.exists(CLASSROOM):
        return []
    with open(CLASSROOM, encoding="utf-8") as handle:
        return [("general", line.strip()) for line in handle if line.strip()]


def _curriculum_prompts(limit=20):
    """Chapter titles straight out of the app's curriculum data."""
    if not os.path.exists(CURRICULUM):
        return []
    with open(CURRICULUM, encoding="utf-8") as handle:
        titles = _DEVANAGARI_QUOTED.findall(handle.read())
    seen, prompts = set(), []
    for title in titles:
        if title not in seen and len(title) > 3:
            seen.add(title)
            prompts.append(("curriculum", title))
        if len(prompts) >= limit:
            break
    return prompts


EXTRA_PROMPTS = [
    ("hinglish", "आज हम computer की class लेंगे"),
    ("hinglish", "अपनी copy और pencil निकालो"),
    ("hinglish", "यह question बहुत easy है"),
    ("numbers", "कक्षा में 32 बच्चे हैं"),
    ("numbers", "पाठ 15 खोलो"),
    ("numbers", "100 तक गिनती लिखो"),
]


def build_prompts():
    return _classroom_prompts() + _curriculum_prompts() + EXTRA_PROMPTS


def append_manifest(entry):
    with open(MANIFEST, "a", encoding="utf-8") as handle:
        handle.write(json.dumps(entry, ensure_ascii=False) + "\n")


def existing_count():
    if not os.path.exists(MANIFEST):
        return 0
    with open(MANIFEST, encoding="utf-8") as handle:
        return sum(1 for line in handle if line.strip())


def write_wav(path, samples):
    pcm = np.clip(samples, -1.0, 1.0)
    with wave.open(path, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SAMPLE_RATE)
        w.writeframes((pcm * 32767).astype(np.int16).tobytes())


def record_until_enter(device):
    """Record from Enter to Enter, so the speaker controls the length."""
    chunks = []

    def callback(indata, frames, time_info, status):  # noqa: ARG001
        chunks.append(indata[:, 0].copy())

    with sd.InputStream(samplerate=SAMPLE_RATE, channels=1, dtype="float32",
                        blocksize=SAMPLE_RATE // 10, device=device,
                        callback=callback):
        input("    recording... press Enter to stop ")
    if not chunks:
        return np.zeros(0, dtype=np.float32)
    return np.concatenate(chunks)


def capture(prompts, device, tag_override=None):
    os.makedirs(FIXTURES, exist_ok=True)
    index = existing_count()
    for tag, text in prompts:
        print("\n[{}] {}".format(tag_override or tag, text or "(stay silent)"))
        answer = input("    Enter to record, 's' to skip, 'q' to quit: ").strip().lower()
        if answer == "q":
            break
        if answer == "s":
            continue

        samples = record_until_enter(device)
        if len(samples) < SAMPLE_RATE // 2:
            print("    too short, skipped")
            continue

        index += 1
        name = "{:03d}.wav".format(index)
        write_wav(os.path.join(FIXTURES, name), samples)
        append_manifest({
            "audio": os.path.join("fixtures", name),
            "ref": text,
            "tags": [tag_override or tag],
        })
        peak = float(np.abs(samples).max())
        print("    saved {} ({:.1f}s, peak {:.3f})".format(
            name, len(samples) / SAMPLE_RATE, peak))
        if peak < 0.02:
            print("    WARNING: very quiet - check the mic before continuing")


NOISE_PROMPTS = [
    ("noise", ""),  # room tone, nobody speaking
    ("noise", ""),  # background chatter, no target speaker
    ("noise", ""),  # whatever the classroom actually sounds like
]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--device", type=int, default=None)
    parser.add_argument("--list", action="store_true")
    parser.add_argument("--noise", action="store_true",
                        help="record noise-only fixtures with empty references")
    args = parser.parse_args()

    if sd is None:
        raise SystemExit("sounddevice is not installed: pip install -r requirements.txt")

    if args.list:
        for i, d in enumerate(sd.query_devices()):
            if d["max_input_channels"] > 0:
                print("{:3d}  {}".format(i, d["name"]))
        return 0

    if args.noise:
        print("Recording noise fixtures: stay silent, let the room be the room.")
        print("These have empty references and are scored by insertion count -")
        print("they are the regression test for the silence hallucination.")
        capture(NOISE_PROMPTS, args.device)
        return 0

    prompts = build_prompts()
    print("{} prompts available, {} fixtures already recorded.".format(
        len(prompts), existing_count()))
    print("Speak naturally, the way you would in class.")
    capture(prompts, args.device)
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("\nstopped.")
