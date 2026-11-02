import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vaanisetu/data/chapter_content_data.dart';
import 'package:vaanisetu/data/chapter_content_map.dart';
import 'package:vaanisetu/l10n/app_language.dart';
import 'package:vaanisetu/l10n/app_language_scope.dart';
import 'package:vaanisetu/role/app_role.dart';
import 'package:vaanisetu/screens/assessment_screen.dart';
import 'package:vaanisetu/screens/chapter_detail_screen.dart';

/// A chapter that really has authored content, so the tiles open the real
/// screens rather than the placeholder.
const _classNumber = 1;
const _subject = 'Hindi';
const _chapter = 'मेरा गाँव';

Widget _app(AppRole role, Widget child) {
  return AppRoleScope(
    controller: AppRoleController()..value = role,
    child: AppLanguageScope(
      controller: AppLanguageController(),
      child: MaterialApp(home: child),
    ),
  );
}

Future<void> _pumpChapter(WidgetTester tester, AppRole role) async {
  await tester.pumpWidget(
    _app(
      role,
      const ChapterDetailScreen(
        classNumber: _classNumber,
        subjectName: _subject,
        chapter: _chapter,
      ),
    ),
  );
  await tester.pump();
}

void main() {
  test('the fixture chapter has content, so the tiles are the real ones', () {
    final content =
        chapterContentData[chapterContentKey(_classNumber, _subject, _chapter)];
    expect(content, isNotNull);
    expect(content!.assessment, isNotEmpty);
  });

  testWidgets('a teacher gets the worksheet, flashcards and assessment', (
    tester,
  ) async {
    await _pumpChapter(tester, AppRole.teacher);

    expect(find.text('Worksheet'), findsOneWidget);
    expect(find.text('Flashcards'), findsOneWidget);
    expect(find.text('Assessment'), findsOneWidget);
  });

  testWidgets('a student gets flashcards and the assessment, no worksheet', (
    tester,
  ) async {
    await _pumpChapter(tester, AppRole.student);

    expect(find.text('Worksheet'), findsNothing);
    expect(find.text('Flashcards'), findsOneWidget);
    expect(find.text('Assessment'), findsOneWidget);
  });

  testWidgets("a teacher's assessment opens as an answer key", (tester) async {
    await _pumpChapter(tester, AppRole.teacher);

    await tester.tap(find.text('Assessment'));
    await tester.pumpAndSettle();

    expect(find.byType(AssessmentScreen), findsOneWidget);
    expect(find.text('Answer key'), findsOneWidget);
    expect(find.text('Submit'), findsNothing);
  });

  testWidgets("a student's assessment opens as an unanswered quiz", (
    tester,
  ) async {
    await _pumpChapter(tester, AppRole.student);

    await tester.tap(find.text('Assessment'));
    await tester.pumpAndSettle();

    expect(find.byType(AssessmentScreen), findsOneWidget);
    expect(find.text('Answer key'), findsNothing);
    expect(find.text('Submit'), findsOneWidget);
  });
}
