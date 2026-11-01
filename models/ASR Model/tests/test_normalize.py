"""Tests for the ASR transcript normalizer.

The normalizer's contract: whatever the Hinglish ASR emits, the output is
valid hin_Deva input for IndicTrans2 - Devanagari only, no Latin, no ASCII
digits.
"""
import json
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from normalize import normalize, transliterate_latin


class TestLoanwords(unittest.TestCase):
    def test_known_loanword_becomes_devanagari(self):
        self.assertEqual(normalize("यह एक model है"), "यह एक मॉडल है।")

    def test_unknown_latin_word_still_becomes_devanagari(self):
        # The lexicon can never cover every English word a teacher says, so
        # anything it misses must still leave the output free of Latin -
        # that is the contract with IndicTrans2's hin_Deva tag.
        out = normalize("यह एक blorp है")
        self.assertNotRegex(out, r"[A-Za-z]")

    def test_classroom_loanwords_use_conventional_spellings(self):
        # Phonetic transliteration gets these wrong (school -> शूल), and they
        # are the words a primary teacher actually says, so they are pinned.
        expected = {
            "school": "स्कूल",
            "computer": "कंप्यूटर",
            "class": "क्लास",
            "teacher": "टीचर",
            "copy": "कॉपी",
            "pencil": "पेंसिल",
            "book": "बुक",
            "board": "बोर्ड",
        }
        for word, want in expected.items():
            with self.subTest(word=word):
                self.assertEqual(transliterate_latin(word), want)


class TestTransliterationRules(unittest.TestCase):
    def test_silent_final_e_is_dropped(self):
        # English "name" is नेम, not नमे - a trailing e colours the preceding
        # vowel instead of being pronounced.
        self.assertEqual(transliterate_latin("name"), "नेम")

    def test_c_before_front_vowel_is_sibilant(self):
        # "city" is सिटी, not किटी.
        self.assertEqual(transliterate_latin("city"), "सिटी")

class TestNumbers(unittest.TestCase):
    def test_single_digit_becomes_hindi_word(self):
        self.assertEqual(normalize("5 तक गिनो"), "पाँच तक गिनो।")

    def test_irregular_two_digit_number_is_spelled_out(self):
        # Hindi numbers below 100 are irregular and cannot be composed from
        # tens and units - 25 is पच्चीस, not "दो दस पाँच".
        self.assertEqual(normalize("25"), "पच्चीस।")

    def test_hundreds_are_composed(self):
        self.assertEqual(normalize("150"), "एक सौ पचास।")

    def test_no_ascii_digits_survive(self):
        self.assertNotRegex(normalize("कक्षा 3 में 40 बच्चे हैं"), r"[0-9]")

class TestRepetitionGuard(unittest.TestCase):
    # The exact string the recognizer produced from 4s of bit-exact silence,
    # captured by running the model. ys_probs is empty on this CTC path, so
    # there is no confidence score to threshold - the shape of the text is
    # the only available signal.
    HALLUCINATION = "का  का का का का का का का का का का का का का का"

    def test_hallucinated_repetition_is_suppressed(self):
        self.assertEqual(normalize(self.HALLUCINATION), "")

    def test_legitimate_repetition_survives(self):
        # Real Hindi doubles words for emphasis; suppressing that would be a
        # false positive on ordinary speech.
        self.assertEqual(normalize("बहुत बहुत अच्छा"), "बहुत बहुत अच्छा।")

    def test_classroom_sentences_are_untouched(self):
        # These are real, already-clean Devanagari classroom sentences. Any
        # edit to them is by definition a false positive.
        path = os.path.join(
            os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
            os.pardir, "test", "classroom_sentences.txt",
        )
        with open(path, encoding="utf-8") as handle:
            sentences = [line.strip() for line in handle if line.strip()]
        self.assertGreater(len(sentences), 0)
        for sentence in sentences:
            with self.subTest(sentence=sentence):
                self.assertEqual(normalize(sentence), sentence)

class TestSentenceShape(unittest.TestCase):
    def test_terminal_danda_is_added_when_missing(self):
        # The ASR never emits punctuation, but IndicTrans2's tokenizer treats
        # the danda as a token, and every reference classroom sentence has a
        # terminator. Push-to-talk means one session is exactly one utterance.
        self.assertEqual(normalize("बच्चों किताब खोलो"), "बच्चों किताब खोलो।")

    def test_existing_terminator_is_not_doubled(self):
        self.assertEqual(normalize("यह कौन सा रंग है?"), "यह कौन सा रंग है?")

    def test_runs_of_whitespace_collapse(self):
        self.assertEqual(normalize("मेरा   गाँव"), "मेरा गाँव।")


class TestScriptInvariant(unittest.TestCase):
    def test_output_is_devanagari_only(self):
        # The contract with IndicTrans2's hin_Deva tag, asserted on the
        # codepoint set rather than by eyeballing samples.
        messy = "मैं 5 baje school गया aur 25 rupee ka pen khareeda"
        out = normalize(messy)
        self.assertNotRegex(out, r"[A-Za-z0-9]")
        self.assertTrue(out)

class TestSharedContract(unittest.TestCase):
    """Drives the same cases the Dart port must satisfy.

    If this class and test/asr_normalizer_test.dart both pass, the two
    implementations agree - which is the only thing keeping them from
    drifting apart.
    """

    def test_every_shared_case(self):
        path = os.path.join(
            os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
            "eval", "normalizer_cases.json",
        )
        with open(path, encoding="utf-8") as handle:
            cases = json.load(handle)["cases"]
        self.assertGreater(len(cases), 0)
        for case in cases:
            with self.subTest(case=case["name"]):
                self.assertEqual(normalize(case["input"]), case["expected"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
