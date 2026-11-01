"""Tests for the scoring used to judge every other change in this bundle.

If these are wrong, every measurement built on them is wrong, so the metric
gets the same test-first treatment as the code it measures.
"""
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from eval.wer import Score, normalize_for_scoring, score


class TestScoringNormalizer(unittest.TestCase):
    def test_punctuation_and_case_are_ignored(self):
        # The ASR emits neither, so scoring against punctuated references
        # would charge the model for something it never had a chance at.
        self.assertEqual(
            normalize_for_scoring("बच्चों, किताब खोलो।"),
            normalize_for_scoring("बच्चों किताब खोलो"),
        )

    def test_latin_case_is_folded(self):
        self.assertEqual(normalize_for_scoring("Model"), normalize_for_scoring("model"))

    def test_whitespace_runs_collapse(self):
        self.assertEqual(normalize_for_scoring("a   b"), "a b")


class TestScore(unittest.TestCase):
    def test_identical_text_scores_zero(self):
        result = score(["मेरा गाँव"], ["मेरा गाँव"])
        self.assertEqual(result.wer, 0.0)
        self.assertEqual(result.cer, 0.0)

    def test_one_wrong_word_in_four(self):
        result = score(["एक दो तीन चार"], ["एक दो तीन पाँच"])
        self.assertAlmostEqual(result.wer, 0.25)

    def test_deletion_counts_against_the_hypothesis(self):
        result = score(["एक दो तीन चार"], ["एक दो तीन"])
        self.assertAlmostEqual(result.wer, 0.25)

    def test_empty_hypothesis_against_real_reference_is_total_loss(self):
        result = score(["एक दो"], [""])
        self.assertAlmostEqual(result.wer, 1.0)

    def test_insertions_on_an_empty_reference_are_counted_separately(self):
        # WER against an empty reference is undefined (division by zero), so
        # the noise fixtures are scored by insertion count instead.
        result = score([""], ["का का का"])
        self.assertEqual(result.insertions, 3)
        self.assertEqual(result.ref_words, 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
