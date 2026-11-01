#!/usr/bin/env python3
"""Live mic transcription.

Speak Hindi/Hinglish; partials update on one line as you talk, and each
utterance is committed when you pause. Ctrl-C to stop.

    python listen.py              # default mic
    python listen.py --list       # show input devices
    python listen.py --device 2   # pick one
    python listen.py --meter      # level meter only, to debug silence
"""
import argparse
import os
import sys

import numpy as np
import sounddevice as sd

from asr import SAMPLE_RATE, build_recognizer
from audio import AudioConditioner
from normalize import normalize

BLOCK = SAMPLE_RATE // 10     # 100 ms
DEAD_MIC_BLOCKS = 20          # 2 s of bit-exact zeros => denied mic, not silence

DEAD_MIC_MSG = """
No audio is reaching the recognizer - every sample is bit-exact zero.

A live mic always has a noise floor, so exact zeros mean the OS is denying
microphone access and feeding silence instead of raising an error. Left
unchecked the model hallucinates on all-zero input and prints streams of
plausible-looking Hindi that you never said.

macOS: grant the microphone to {app}, the app this process runs under.

  1. System Settings -> Privacy & Security -> Microphone -> enable {app}
  2. Quit {app} completely (Cmd-Q, not just close the window) and reopen it

If {app} is not listed, force a fresh permission prompt:

  tccutil reset Microphone {bundle}

then fully quit and reopen {app}, and run this script again.

Linux: check the device is not muted (`amixer`/`pavucontrol`) and that your
user is in the `audio` group.
"""

TERMINALS = {
    "vscode": ("Visual Studio Code", "com.microsoft.VSCode"),
    "Apple_Terminal": ("Terminal", "com.apple.Terminal"),
    "iTerm.app": ("iTerm", "com.googlecode.iterm2"),
}


def dead_mic_error():
    app, bundle = TERMINALS.get(os.environ.get("TERM_PROGRAM", ""),
                                ("your terminal app", "<bundle-id>"))
    return DEAD_MIC_MSG.format(app=app, bundle=bundle)


def meter(device):
    """No transcription - just prove the mic delivers non-zero samples."""
    print("Speak. Ctrl-C to stop.\n")
    with sd.InputStream(samplerate=SAMPLE_RATE, channels=1, dtype="float32",
                        blocksize=BLOCK, device=device) as s:
        while True:
            d, _ = s.read(BLOCK)
            rms = float(np.sqrt((d ** 2).mean()))
            print(f"\rRMS {rms:.5f} |{'#' * int(min(rms * 400, 50)):<50}|", end="", flush=True)


def listen(device, use_vad=True):
    rec = build_recognizer(endpointing=True)
    stream = rec.create_stream()
    conditioner = AudioConditioner(enable_vad=use_vad)
    print("Listening. Speak Hindi or Hinglish; pause to commit. Ctrl-C to stop.\n")

    last = ""
    zero_blocks, seen_audio = 0, False
    with sd.InputStream(samplerate=SAMPLE_RATE, channels=1, dtype="float32",
                        blocksize=BLOCK, device=device) as s:
        while True:
            data, overflowed = s.read(BLOCK)
            if overflowed:
                print("\n[warn] input overflow - dropped audio", file=sys.stderr)
            samples = data[:, 0]

            # A sustained run of bit-exact zeros is a mic the OS has silently
            # muted, not silence. Only this check can say so; the conditioner
            # handles the audio itself (VAD gating, gain, dither) and never
            # drops a block, because dropping blocks desyncs the stream clock
            # and endpoint detection stops firing.
            if not samples.any():
                zero_blocks += 1
                if not seen_audio and zero_blocks >= DEAD_MIC_BLOCKS:
                    print(dead_mic_error(), file=sys.stderr)
                    return 1
            elif not seen_audio:
                seen_audio = True
                zero_blocks = 0

            stream.accept_waveform(SAMPLE_RATE, conditioner.process(samples))
            while rec.is_ready(stream):
                rec.decode_stream(stream)

            text = rec.get_result(stream).strip()
            if text and text != last:
                print(f"\r  ... {text}", end="", flush=True)
                last = text

            if rec.is_endpoint(stream):
                # Only committed utterances are normalized - partials above are
                # unstable prefixes, and normalizing them would just churn.
                committed = normalize(text) if conditioner.saw_speech else ""
                if committed:
                    print(f"\r  >>> {committed}{' ' * 20}")
                rec.reset(stream)
                last = ""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--device", type=int, default=None)
    ap.add_argument("--list", action="store_true")
    ap.add_argument("--meter", action="store_true")
    ap.add_argument("--no-vad", action="store_true",
                    help="disable VAD gating, to A/B its contribution")
    a = ap.parse_args()

    if a.list:
        for i, d in enumerate(sd.query_devices()):
            if d["max_input_channels"] > 0:
                print(f"{i:3d}  {d['name']}  ({d['max_input_channels']}ch @ {d['default_samplerate']:.0f}Hz)")
        return 0
    try:
        if a.meter:
            return meter(a.device)
        return listen(a.device, use_vad=not a.no_vad)
    except KeyboardInterrupt:
        print("\nstopped.")
        return 0


if __name__ == "__main__":
    sys.exit(main() or 0)
