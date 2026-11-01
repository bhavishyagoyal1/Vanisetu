#!/usr/bin/env python3
"""Check the bundle is intact and the model actually decodes.

    python verify.py
"""
import sys

from asr import ENCODER_SHA256, verify_encoder
from transcribe import transcribe

EXPECTED = "नमस्ते मेरा नाम समर्थ है मैं आज एक नया model taste कर रहा हूं"


def main():
    ok, digest, size = verify_encoder()
    print(f"encoder size   : {size}")
    print(f"encoder sha256 : {digest}")
    print(f"matches pin    : {ok}   (expected {ENCODER_SHA256})")
    if not ok:
        print("\nFAIL: weights do not match the pinned revision - re-copy the bundle.")
        return 1

    print("\ndecoding samples/hi.wav ...")
    text = transcribe("samples/hi.wav", verbose=False)
    print(f"got      : {text}")
    print(f"expected : {EXPECTED}")
    if text != EXPECTED:
        print("\nWARN: output differs. Not necessarily broken (sherpa-onnx version "
              "differences shift output slightly), but check before trusting it.")
        return 2
    print("\nOK: bundle verified.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
