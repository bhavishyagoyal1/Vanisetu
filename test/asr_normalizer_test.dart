import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vaanisetu/services/asr/hindi_text_normalizer.dart';

/// The Dart half of the normalizer's shared contract.
///
/// `models/ASR Model/eval/normalizer_cases.json` is the single source of truth
/// for how transcripts must be shaped. The Python implementation
/// (`models/ASR Model/tests/test_normalize.py`) reads the same file. If both
/// suites pass, the two implementations agree — which is the only thing
/// stopping them drifting apart as the lexicon grows.
void main() {
  group('shared contract', () {
    late List<dynamic> cases;

    setUpAll(() {
      final file = File('models/ASR Model/eval/normalizer_cases.json');
      expect(
        file.existsSync(),
        isTrue,
        reason: 'shared cases file missing — run from the package root',
      );
      cases = (jsonDecode(file.readAsStringSync())
          as Map<String, dynamic>)['cases'] as List<dynamic>;
      expect(cases, isNotEmpty);
    });

    test('every shared case matches', () {
      for (final entry in cases) {
        final testCase = entry as Map<String, dynamic>;
        expect(
          normalizeTranscript(testCase['input'] as String),
          testCase['expected'] as String,
          reason: 'case: ${testCase['name']}',
        );
      }
    });
  });

  group('script invariant', () {
    test('no Latin or ASCII digits survive normalization', () {
      // The contract with IndicTrans2's hin_Deva tag, asserted on the
      // codepoint set rather than by eyeballing samples.
      const messy = 'मैं 5 baje school गया aur 25 rupee ka pen khareeda';
      final out = normalizeTranscript(messy);
      expect(out, isNotEmpty);
      expect(RegExp(r'[A-Za-z0-9]').hasMatch(out), isFalse);
    });

    test('unknown Latin words still convert', () {
      // The lexicon can never cover every English word a teacher says, so
      // anything it misses must still leave the output free of Latin.
      final out = normalizeTranscript('यह एक blorp है');
      expect(RegExp(r'[A-Za-z]').hasMatch(out), isFalse);
    });
  });

  group('hallucination guard', () {
    test('suppresses the silence signature', () {
      // The exact string the recognizer produced from 4s of bit-exact
      // silence, captured by running the model.
      expect(
        normalizeTranscript('का  का का का का का का का का का का का का का का'),
        isEmpty,
      );
    });

    test('does not suppress emphatic doubling', () {
      expect(normalizeTranscript('बहुत बहुत अच्छा'), 'बहुत बहुत अच्छा।');
    });
  });

  group('robustness', () {
    test('an absurdly long digit run does not throw', () {
      // int.parse would overflow on this; the digit-by-digit path must catch
      // it before that happens.
      expect(() => normalizeTranscript('1' * 40), returnsNormally);
    });

    test('classroom sentences are left untouched', () {
      final file = File('models/test/classroom_sentences.txt');
      expect(file.existsSync(), isTrue);
      final sentences = file
          .readAsLinesSync()
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty);
      expect(sentences, isNotEmpty);
      for (final sentence in sentences) {
        // These are already clean Devanagari, so any edit is a false positive.
        expect(normalizeTranscript(sentence), sentence, reason: sentence);
      }
    });
  });
}
