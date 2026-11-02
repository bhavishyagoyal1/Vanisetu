import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaanisetu/data/classroom_prompts.dart';
import 'package:vaanisetu/l10n/app_language.dart';
import 'package:vaanisetu/l10n/app_language_scope.dart';
import 'package:vaanisetu/role/app_role.dart';
import 'package:vaanisetu/screens/translate_screen.dart';

/// The screen builds a FlutterTts and an AudioPlayer in initState. Neither
/// plugin exists in a test binding, so answer their channels rather than let
/// a MissingPluginException surface as an unrelated test failure.
void _stubAudioPlugins() {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  for (final name in const [
    'flutter_tts',
    'xyz.luan/audioplayers',
    'xyz.luan/audioplayers.global',
  ]) {
    messenger.setMockMethodCallHandler(MethodChannel(name), (call) async => 1);
  }
}

Future<void> _pumpTranslate(
  WidgetTester tester, {
  AppRole role = AppRole.teacher,
  Size size = const Size(411, 891),
}) async {
  SharedPreferences.setMockInitialValues({});
  _stubAudioPlugins();
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    AppRoleScope(
      controller: AppRoleController()..value = role,
      child: AppLanguageScope(
        controller: AppLanguageController(),
        child: const MaterialApp(home: TranslateScreen()),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('the header identifies the app', (tester) async {
    await _pumpTranslate(tester, role: AppRole.teacher);

    expect(find.text('VaaniSetu'), findsOneWidget);
  });

  testWidgets('the header shows a language toggle, not a role pill', (
    tester,
  ) async {
    await _pumpTranslate(tester, role: AppRole.student);

    expect(find.text('Student'), findsNothing);
    expect(find.text('Teacher'), findsNothing);
    expect(find.text('EN'), findsOneWidget);
    expect(find.text('हिंदी'), findsOneWidget);
  });

  testWidgets('tapping the Hindi segment switches the interface language', (
    tester,
  ) async {
    await _pumpTranslate(tester);
    expect(find.text('Tap to Speak'), findsOneWidget);

    await tester.tap(find.text('हिंदी'));
    await tester.pump();

    expect(find.text('Tap to Speak'), findsNothing);
    expect(find.text('बोलने के लिए दबाएँ'), findsOneWidget);
  });

  testWidgets('tapping English switches back', (tester) async {
    await _pumpTranslate(tester);

    await tester.tap(find.text('हिंदी'));
    await tester.pump();
    await tester.tap(find.text('EN'));
    await tester.pump();

    expect(find.text('Tap to Speak'), findsOneWidget);
  });

  testWidgets('the language bar names both sides of the translation', (
    tester,
  ) async {
    await _pumpTranslate(tester);

    expect(find.text('Hindi'), findsOneWidget);
    expect(find.text('Santhali'), findsOneWidget);
  });

  testWidgets('classroom prompt chips are offered', (tester) async {
    await _pumpTranslate(tester);

    expect(find.text(classroomPrompts.first.label), findsOneWidget);
  });

  testWidgets('tapping a prompt chip fills the source box with its sentence', (
    tester,
  ) async {
    await _pumpTranslate(tester);

    await tester.tap(find.text(classroomPrompts.first.label));
    await tester.pump();

    expect(find.text(classroomPrompts.first.hindi), findsOneWidget);
  });

  testWidgets('View All lists every prompt', (tester) async {
    await _pumpTranslate(tester);

    await tester.tap(find.text('View All (${classroomPrompts.length})'));
    await tester.pumpAndSettle();

    // The sheet scrolls, so assert on the ones that fit plus the count.
    expect(find.text(classroomPrompts.first.hindi), findsWidgets);
    expect(find.byType(ListView), findsWidgets);
  });

  testWidgets('the mic is tap-to-start', (tester) async {
    await _pumpTranslate(tester);

    expect(find.text('Tap to Speak'), findsOneWidget);
  });

  testWidgets('the mic shows no engine name while idle', (tester) async {
    await _pumpTranslate(tester);

    expect(find.textContaining('ONNX'), findsNothing);
    expect(find.textContaining('Streaming'), findsNothing);
    // The recording timer belongs to the listening state only.
    expect(find.text('00:00'), findsNothing);
  });

  testWidgets('the cards name the languages, not the models', (tester) async {
    await _pumpTranslate(tester);

    expect(find.textContaining('Zipformer'), findsNothing);
    expect(find.textContaining('IndicTrans2'), findsNothing);
    // The section labels themselves stay.
    expect(find.text('Source • HINDI'), findsOneWidget);
    expect(find.text('Target • SANTHALI'), findsOneWidget);
  });

  testWidgets('the source card actions sit in its top-right corner', (
    tester,
  ) async {
    await _pumpTranslate(tester);

    // The text field spans the card's content box, so its edges are the
    // corner the actions must hug.
    final content = tester.getRect(find.byType(TextField).first);
    final copy = tester.getRect(find.byIcon(Icons.copy_rounded).first);
    final speaker = tester.getRect(find.byIcon(Icons.volume_up_rounded).first);

    expect(
      copy.right,
      greaterThan(content.right - 6),
      reason: 'copy icon is not flush with the right edge',
    );
    expect(
      copy.top,
      lessThan(content.top - 18),
      reason: 'copy icon is not up in the top corner',
    );
    expect(
      speaker.right,
      lessThan(copy.left + 1),
      reason: 'speaker should sit just left of copy',
    );
  });

  testWidgets('the offline badge is gone from the header', (tester) async {
    await _pumpTranslate(tester);

    expect(find.textContaining('100%'), findsNothing);
    expect(find.textContaining('2GB'), findsNothing);
    expect(find.textContaining('Offline'), findsNothing);
  });

  group('responsive layout', () {
    const sizes = <String, Size>{
      'small phone': Size(320, 640),
      'regular phone': Size(411, 891),
      'large phone': Size(480, 1000),
      'tablet': Size(800, 1280),
    };

    sizes.forEach((name, size) {
      testWidgets('lays out without overflow on a $name', (tester) async {
        await _pumpTranslate(tester, size: size);

        expect(tester.takeException(), isNull);
      });
    });
  });
}
