import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaanisetu/l10n/app_language.dart';
import 'package:vaanisetu/l10n/app_language_scope.dart';
import 'package:vaanisetu/role/app_role.dart';
import 'package:vaanisetu/screens/settings_screen.dart';

Future<AppRoleController> _pumpSettings(
  WidgetTester tester,
  AppRole role,
) async {
  SharedPreferences.setMockInitialValues({});
  final controller = AppRoleController()..value = role;
  await tester.pumpWidget(
    AppRoleScope(
      controller: controller,
      child: AppLanguageScope(
        controller: AppLanguageController(),
        child: const MaterialApp(home: SettingsScreen()),
      ),
    ),
  );
  await tester.pump();
  return controller;
}

void main() {
  testWidgets('settings offers both roles', (tester) async {
    await _pumpSettings(tester, AppRole.teacher);

    expect(find.text('Teacher'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
  });

  testWidgets('picking the other role switches and persists it', (
    tester,
  ) async {
    final controller = await _pumpSettings(tester, AppRole.teacher);

    await tester.tap(find.text('Student'));
    await tester.pumpAndSettle();

    expect(controller.value, AppRole.student);

    final reloaded = AppRoleController();
    await reloaded.load();
    expect(reloaded.value, AppRole.student);
  });

  testWidgets('the app language setting still works alongside it', (
    tester,
  ) async {
    await _pumpSettings(tester, AppRole.student);

    expect(find.text('English'), findsOneWidget);
    expect(find.text('हिंदी'), findsOneWidget);
  });
}
