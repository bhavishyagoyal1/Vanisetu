"""Shared capture conditioning for the ASR bundle.

listen.py and the eval harness both run audio through this, so that what is
measured is what users get.

Two rules govern everything here:

1. **Never change the sample count.** listen.py documents why: dropping blocks
   desyncs the recognizer's stream clock and endpoint detection stops firing.
   Conditioning rewrites sample *values*, never the number of them.
2. **Never hand the model digital silence.** Fed bit-exact zeros the recognizer
   emits confident runs of a single token ("का का का ..."). Substituting
   inaudible dither keeps the frontend out of that degenerate state.
"""
import os

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
VAD_MODEL = os.path.join(HERE, "silero_vad.onnx")
SAMPLE_RATE = 16000

# Pinned the same way asr.py pins the encoder.
VAD_SHA256 = "9e2449e1087496d8d4caba907f23e0bd3f78d91fa552479bb9c23ac09cbb1fd6"
VAD_BYTES = 643854

# Silero consumes exactly this many samples per inference at 16 kHz.
_VAD_WINDOW = 512

# Below this RMS a block carries no usable speech energy. Used as a floor so a
# VAD false negative cannot silence real speech - see _is_speech.
_ENERGY_FLOOR = 0.005

# Keep passing audio for this long after VAD last saw speech, so trailing
# consonants and short intra-word pauses are not clipped.
_HANGOVER_BLOCKS = 5

_DITHER_AMPLITUDE = 1e-4


def verify_vad():
    """Return (ok, actual_sha256, actual_size), mirroring asr.verify_encoder."""
    import hashlib

    size = os.path.getsize(VAD_MODEL)
    digest = hashlib.sha256()
    with open(VAD_MODEL, "rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    actual = digest.hexdigest()
    return (actual == VAD_SHA256 and size == VAD_BYTES), actual, size


class AudioConditioner:
    """Conditions mic blocks before they reach the recognizer.

    Set `enable_vad=False` or `enable_gain=False` to A/B either stage from the
    eval harness; a change that cannot be isolated cannot be defended.
    """

    def __init__(self, enable_vad=True, enable_gain=True, target_rms=0.05,
                 max_gain=8.0, seed=None):
        self.enable_vad = enable_vad
        self.enable_gain = enable_gain
        self.target_rms = target_rms
        self.max_gain = max_gain
        self._random = np.random.default_rng(seed)
        self._pending = np.zeros(0, dtype=np.float32)
        self._blocks_since_speech = _HANGOVER_BLOCKS + 1
        self._saw_speech = False
        self._vad = None
        if enable_vad:
            self._vad = self._build_vad()

    @property
    def saw_speech(self):
        """True if any block in this session carried speech.

        Conditioned silence still decodes to a stray token, so a transcript
        from a session that never contained speech must be discarded outright
        rather than trimmed by a length heuristic.
        """
        return self._saw_speech

    @staticmethod
    def _build_vad():
        import sherpa_onnx

        config = sherpa_onnx.VadModelConfig()
        config.silero_vad.model = VAD_MODEL
        config.silero_vad.threshold = 0.5
        config.silero_vad.min_silence_duration = 0.25
        config.silero_vad.min_speech_duration = 0.1
        config.sample_rate = SAMPLE_RATE
        return sherpa_onnx.VoiceActivityDetector(config, buffer_size_in_seconds=30)

    def _vad_says_speech(self, samples):
        """Feed Silero in its required window size and report its verdict."""
        self._pending = np.concatenate([self._pending, samples])
        speech = False
        while len(self._pending) >= _VAD_WINDOW:
            window = self._pending[:_VAD_WINDOW]
            self._pending = self._pending[_VAD_WINDOW:]
            self._vad.accept_waveform(window)
            if self._vad.is_speech_detected():
                speech = True
        return speech

    def _is_speech(self, samples):
        """Decide whether this block carries speech.

        Energy is checked first and independently: Silero needs a moment to
        latch onto speech onset, and a false negative there would clip the
        first phoneme of every utterance. Loud audio is therefore always
        treated as speech regardless of what the VAD thinks.
        """
        loud = float(np.sqrt(np.mean(np.square(samples)))) >= _ENERGY_FLOOR
        if not self.enable_vad:
            self._saw_speech = self._saw_speech or loud
            return loud
        if self._vad_says_speech(samples) or loud:
            self._blocks_since_speech = 0
            self._saw_speech = True
            return True
        self._blocks_since_speech += 1
        return self._blocks_since_speech <= _HANGOVER_BLOCKS

    def _dither(self, count):
        return (self._random.standard_normal(count) * _DITHER_AMPLITUDE).astype(np.float32)

    def process(self, samples):
        """Condition one block. Always returns exactly len(samples) samples."""
        samples = np.asarray(samples, dtype=np.float32)
        if self._is_speech(samples):
            if self.enable_gain:
                samples = self._apply_gain(samples)
            # Even inside speech, a bit-exact-zero block is a denied mic
            # rather than audio - never let raw zeros reach the model.
            if not samples.any():
                return self._dither(len(samples))
            return samples
        return self._dither(len(samples))

    def _apply_gain(self, samples):
        """Scale toward the target RMS.

        Gated behind the speech decision on purpose: normalising during
        silence amplifies the noise floor, which is precisely what drives the
        hallucination this module exists to prevent.
        """
        rms = float(np.sqrt(np.mean(np.square(samples))))
        if rms <= 0:
            return samples
        gain = min(self.target_rms / rms, self.max_gain)
        return np.clip(samples * gain, -1.0, 1.0).astype(np.float32)
