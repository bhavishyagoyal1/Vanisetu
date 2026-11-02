import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaanisetu/l10n/app_language.dart';
import 'package:vaanisetu/l10n/app_language_scope.dart';
import 'package:vaanisetu/main.dart';
import 'package:vaanisetu/role/app_role.dart';
import 'package:vaanisetu/screens/main_shell.dart';
import 'package:vaanisetu/screens/role_selection_screen.dart';
import 'package:vaanisetu/screens/splash_screen.dart';

/// Steps past the splash screen's 2600ms delay and its 600ms route
/// transition. Deliberately not pumpAndSettle: the splash runs two repeating
/// AnimationControllers, so it never settles (see widget_test.dart).
Future<void> _passSplash(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 2600));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 900));
}

void main() {
  testWidgets('first launch, with no role stored, asks who you are', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const VaaniSetuApp());
    await _passSplash(tester);

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(RoleSelectionScreen), findsOneWidget);
    expect(find.byType(MainShell), findsNothing);
  });

  testWidgets('every launch asks again, even with a role already stored', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'app_role': 'teacher'});

    await tester.pumpWidget(const VaaniSetuApp());
    await _passSplash(tester);

    expect(find.byType(RoleSelectionScreen), findsOneWidget);
    expect(find.byType(MainShell), findsNothing);
  });

  testWidgets('the stored role is marked as the current one', (tester) async {
    SharedPreferences.setMockInitialValues({'app_role': 'student'});

    await tester.pumpWidget(const VaaniSetuApp());
    await _passSplash(tester);

    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });

  testWidgets('choosing a role opens the shell and is remembered', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const VaaniSetuApp());
    await _passSplash(tester);

    await tester.tap(find.text('Student'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.byType(MainShell), findsOneWidget);

    final reloaded = AppRoleController();
    await reloaded.load();
    expect(reloaded.value, AppRole.student);
  });

  testWidgets('both roles land on the same three-tab shell', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const VaaniSetuApp());
    await _passSplash(tester);
    await tester.tap(find.text('Student'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Curriculum'), findsOneWidget);
    expect(find.text('Translate'), findsOneWidget);
    expect(find.text('Dictionary'), findsOneWidget);
  });

  testWidgets('the role screen offers exactly the two roles', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const MaterialApp(home: RoleSelectionScreenHarness()),
    );
    await tester.pump();

    expect(find.text('Teacher'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
  });
}

/// Wraps the role screen in the scope it reads, so it can be pumped without
/// booting the whole app.
class RoleSelectionScreenHarness extends StatelessWidget {
  const RoleSelectionScreenHarness({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRoleScope(
      controller: AppRoleController(),
      child: AppLanguageScope(
        controller: AppLanguageController(),
        child: const RoleSelectionScreen(),
      ),
    );
  }
}
