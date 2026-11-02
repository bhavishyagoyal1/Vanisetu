import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vaanisetu/main.dart';
import 'package:vaanisetu/screens/splash_screen.dart';

void main() {
  testWidgets('App starts on the splash screen and advances past it', (
    WidgetTester tester,
  ) async {
    // A stored role keeps this test about the splash alone; where it lands
    // with and without one is covered by role_routing_test.dart.
    SharedPreferences.setMockInitialValues({'app_role': 'teacher'});

    await tester.pumpWidget(const VaaniSetuApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Deliberately pump() rather than pumpAndSettle(): the splash runs two
    // AnimationControllers with repeat(), which schedule frames forever, so
    // pumpAndSettle can never settle and times out. (Its Duration argument is
    // the frame interval, not a timeout — an easy one to misread.)
    //
    // The delay completes *during* the first pump, so pushReplacement only
    // builds on the following frame - the 600ms transition therefore starts
    // after 2600ms, not at it. Stepping frames explicitly avoids depending on
    // a magic total. Completing the transition also disposes the splash's
    // controllers, so they do not leak into the next test.
    await tester.pump(const Duration(milliseconds: 2600)); // delay elapses
    await tester.pump(); // pushReplacement builds the new route
    await tester.pump(
      const Duration(milliseconds: 900),
    ); // 600ms transition + margin

    expect(find.byType(SplashScreen), findsNothing);
  });
}
