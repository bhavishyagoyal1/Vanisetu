import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vaanisetu/data/classroom_prompts.dart';

/// The prompts are a hand-curated copy of the in-domain sentence list used to
/// test the MT pipeline. Pinning them to that file keeps the two from
/// drifting: if someone edits the source list, this fails until the Dart copy
/// is updated too.
void main() {
  test('every prompt is one of the repo classroom sentences, in order', () {
    final source = File('models/test/classroom_sentences.txt')
        .readAsLinesSync()
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    expect(source, isNotEmpty, reason: 'source sentence list is missing');
    expect(classroomPrompts.map((p) => p.hindi).toList(), source);
  });

  test('every prompt carries an emoji and a short chip label', () {
    for (final prompt in classroomPrompts) {
      expect(prompt.emoji, isNotEmpty, reason: prompt.hindi);
      expect(prompt.label, isNotEmpty, reason: prompt.hindi);
      // Chips are laid out in a single horizontal row; a long label would
      // blow the chip out rather than wrap.
      expect(
        prompt.label.length,
        lessThanOrEqualTo(20),
        reason: '${prompt.label} is too long for a chip',
      );
    }
  });

  test('chip labels are drawn from the sentence they stand for', () {
    // The label is a shortened form of the full sentence, not a separate
    // phrase — so tapping a chip cannot insert something the label did not
    // promise.
    for (final prompt in classroomPrompts) {
      final words = prompt.label.split(' ');
      expect(
        words.every((word) => prompt.hindi.contains(word)),
        isTrue,
        reason: '"${prompt.label}" is not contained in "${prompt.hindi}"',
      );
    }
  });

  test('prompts are unique', () {
    final seen = classroomPrompts.map((p) => p.hindi).toSet();
    expect(seen.length, classroomPrompts.length);
  });
}
