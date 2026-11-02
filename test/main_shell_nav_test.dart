import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaanisetu/l10n/app_language.dart';
import 'package:vaanisetu/l10n/app_language_scope.dart';
import 'package:vaanisetu/role/app_role.dart';
import 'package:vaanisetu/screens/curriculum_class_screen.dart';
import 'package:vaanisetu/screens/dictionary_screen.dart';
import 'package:vaanisetu/screens/main_shell.dart';
import 'package:vaanisetu/screens/translate_screen.dart';

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

Future<void> _pumpShell(
  WidgetTester tester, {
  Size size = const Size(411, 891),
}) async {
  SharedPreferences.setMockInitialValues({});
  _stubAudioPlugins();
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    AppRoleScope(
      controller: AppRoleController()..value = AppRole.teacher,
      child: AppLanguageScope(
        controller: AppLanguageController(),
        child: const MaterialApp(home: MainShell()),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('opens on the Translate tab', (tester) async {
    await _pumpShell(tester);

    expect(find.byType(TranslateScreen), findsOneWidget);
  });

  testWidgets('the bar offers all three destinations', (tester) async {
    await _pumpShell(tester);

    expect(find.text('Curriculum'), findsOneWidget);
    expect(find.text('Translate'), findsOneWidget);
    expect(find.text('Dictionary'), findsOneWidget);
  });

  testWidgets('tapping Curriculum switches to it', (tester) async {
    await _pumpShell(tester);

    await tester.tap(find.text('Curriculum'));
    await tester.pumpAndSettle();

    expect(find.byType(CurriculumClassScreen), findsOneWidget);
  });

  testWidgets('tapping Dictionary switches to it', (tester) async {
    await _pumpShell(tester);

    await tester.tap(find.text('Dictionary'));
    await tester.pumpAndSettle();

    expect(find.byType(DictionaryScreen), findsOneWidget);
  });

  group('responsive layout', () {
    const sizes = <String, Size>{
      'small phone': Size(320, 640),
      'regular phone': Size(411, 891),
      'tablet': Size(800, 1280),
    };

    sizes.forEach((name, size) {
      testWidgets('the nav bar fits a $name', (tester) async {
        await _pumpShell(tester, size: size);

        expect(tester.takeException(), isNull);
      });
    });
  });
}
