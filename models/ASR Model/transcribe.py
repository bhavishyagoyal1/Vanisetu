#!/usr/bin/env python3
"""Transcribe a 16 kHz mono wav file.

    python transcribe.py samples/hi.wav
"""
import sys
import time
import wave

import numpy as np

from asr import SAMPLE_RATE, build_recognizer


def load_wav(path):
    with wave.open(path) as w:
        if w.getnchannels() != 1 or w.getsampwidth() != 2 or w.getframerate() != SAMPLE_RATE:
            raise SystemExit(
                f"need 16 kHz mono 16-bit PCM, got {w.getframerate()} Hz "
                f"{w.getnchannels()}ch {w.getsampwidth() * 8}-bit.\n"
                f"Convert with: ffmpeg -i {path} -ar 16000 -ac 1 -c:a pcm_s16le out.wav"
            )
        pcm = np.frombuffer(w.readframes(w.getnframes()), dtype=np.int16)
    return pcm.astype(np.float32) / 32768.0


def transcribe(path, verbose=True):
    rec = build_recognizer()
    samples = load_wav(path)
    stream = rec.create_stream()

    step = SAMPLE_RATE // 10  # 100 ms, like a live mic would deliver
    last = ""
    t0 = time.perf_counter()
    for i in range(0, len(samples), step):
        stream.accept_waveform(SAMPLE_RATE, samples[i:i + step])
        while rec.is_ready(stream):
            rec.decode_stream(stream)
        if verbose:
            text = rec.get_result(stream).strip()
            if text != last:
                print(f"  [{(i + step) / SAMPLE_RATE:5.2f}s] {text}")
                last = text

    # Zipformer looks ahead by a few frames, so without a tail of silence the
    # final word never flushes. 0.3 s is enough; 0.5 s is a safe default.
    stream.accept_waveform(SAMPLE_RATE, np.zeros(SAMPLE_RATE // 2, dtype=np.float32))
    stream.input_finished()
    while rec.is_ready(stream):
        rec.decode_stream(stream)

    elapsed = time.perf_counter() - t0
    text = rec.get_result(stream).strip()
    if verbose:
        audio_s = len(samples) / SAMPLE_RATE
        print(f"\nfinal : {text}")
        print(f"audio : {audio_s:.2f}s  compute: {elapsed:.2f}s  RTF: {elapsed / audio_s:.3f}")
    return text


if __name__ == "__main__":
    transcribe(sys.argv[1] if len(sys.argv) > 1 else "samples/hi.wav")
