"""Tests for the shared capture-conditioning path.

listen.py and the eval harness must both run audio through this, or the
harness measures a pipeline users never get.
"""
import os
import sys
import unittest

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from audio import AudioConditioner

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SAMPLE_RATE = 16000
BLOCK = SAMPLE_RATE // 10


def _speechlike(n=BLOCK, amplitude=0.2):
    """A loud voiced-sounding tone. Not real speech, but not silence either."""
    t = np.arange(n) / SAMPLE_RATE
    wave = np.sin(2 * np.pi * 140 * t) + 0.5 * np.sin(2 * np.pi * 280 * t)
    return (amplitude * wave).astype(np.float32)


class TestStreamClock(unittest.TestCase):
    def test_output_length_always_matches_input(self):
        # listen.py's comment is binding: dropping blocks desyncs the stream
        # clock and endpoint detection stops firing. Conditioning may change
        # sample values but never the count.
        conditioner = AudioConditioner()
        for block in (np.zeros(BLOCK, dtype=np.float32), _speechlike()):
            self.assertEqual(len(conditioner.process(block)), BLOCK)


class TestSilenceHandling(unittest.TestCase):
    def test_bit_exact_zeros_are_never_passed_through(self):
        # Zeros drive the log-mel frontend into the state that produces
        # "का का का". Substitute inaudible dither instead.
        conditioner = AudioConditioner()
        out = conditioner.process(np.zeros(BLOCK, dtype=np.float32))
        self.assertTrue(out.any(), "all-zero block was passed through unchanged")
        self.assertLess(float(np.abs(out).max()), 0.01, "dither must be inaudible")

class TestSessionSpeechGate(unittest.TestCase):
    """A session that never contained speech cannot have a transcript.

    Dither alone is not enough: 4s of conditioned silence still decodes to a
    stray "क". Rather than guess at a minimum length, the conditioner reports
    whether it ever heard speech, and the caller discards the transcript when
    it did not - the same shape as HindiAsrService's _sawRealAudio flag.
    """

    def test_pure_silence_never_reports_speech(self):
        conditioner = AudioConditioner(seed=0)
        for _ in range(40):
            conditioner.process(np.zeros(BLOCK, dtype=np.float32))
        self.assertFalse(conditioner.saw_speech)

    def test_loud_audio_reports_speech(self):
        conditioner = AudioConditioner(seed=0)
        for _ in range(10):
            conditioner.process(_speechlike())
        self.assertTrue(conditioner.saw_speech)


if __name__ == "__main__":
    unittest.main(verbosity=2)
