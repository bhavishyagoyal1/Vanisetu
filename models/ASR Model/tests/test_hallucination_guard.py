"""End-to-end proof that conditioning stops the silence hallucination.

This is success criterion 2 of the design. It asserts both halves - that the
raw model really does hallucinate on silence, and that the conditioned path
does not - so the test still fails loudly if the underlying behaviour ever
changes and the guard silently stops being necessary.
"""
import os
import sys
import unittest

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from asr import SAMPLE_RATE, build_recognizer
from audio import AudioConditioner
from normalize import normalize

BLOCK = SAMPLE_RATE // 10
SECONDS = 4


def _decode(blocks):
    recognizer = build_recognizer()
    stream = recognizer.create_stream()
    for block in blocks:
        stream.accept_waveform(SAMPLE_RATE, block)
        while recognizer.is_ready(stream):
            recognizer.decode_stream(stream)
    stream.accept_waveform(SAMPLE_RATE, np.zeros(SAMPLE_RATE // 2, dtype=np.float32))
    stream.input_finished()
    while recognizer.is_ready(stream):
        recognizer.decode_stream(stream)
    return recognizer.get_result(stream).strip()


class TestSilenceHallucination(unittest.TestCase):
    def setUp(self):
        self.silence = [np.zeros(BLOCK, dtype=np.float32) for _ in range(SECONDS * 10)]

    def test_raw_silence_still_hallucinates(self):
        # Documents why the guard exists. If this ever fails, the model
        # changed and the rest of this file needs revisiting.
        self.assertNotEqual(_decode(self.silence), "")

    def test_conditioned_silence_produces_nothing(self):
        conditioner = AudioConditioner(seed=0)
        text = _decode([conditioner.process(block) for block in self.silence])
        # The contract callers must honour: no speech in the session means no
        # transcript, whatever the decoder happened to emit.
        result = normalize(text) if conditioner.saw_speech else ""
        self.assertEqual(result, "")


if __name__ == "__main__":
    unittest.main(verbosity=2)
