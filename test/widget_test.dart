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
    // No static logo image any more — the splash is the intro video
    // full-screen (or, before it's ready/in a test with no real video_player
    // platform to answer to, a plain gradient background) with no other
    // logo drawn over it.
    expect(find.byType(Image), findsNothing);

    // Deliberately pump() rather than pumpAndSettle(): the splash runs two
    // AnimationControllers with repeat(), which schedule frames forever, so
    // pumpAndSettle can never settle and times out. (Its Duration argument is
    // the frame interval, not a timeout — an easy one to misread.)
    //
    // The delay completes *during* the first pump, so pushReplacement only
    // builds on the following frame - the 600ms transition therefore starts
    // after the wait, not at it. Stepping frames explicitly avoids depending
    // on a magic total. Completing the transition also disposes the splash's
    // controllers, so they do not leak into the next test.
    //
    // 22000ms: SplashScreen._navigateAfterDelay's overall wait is the max of
    // three futures, and in this test environment (no real video_player or
    // path_provider platform implementation) the binding one is
    // HindiAsrService.prewarm() capped at maxVideoInitWait +
    // maxVideoPlayWait + maxExtraWait (3000 + 15000 + 4000ms) — not the
    // video's own (much shorter, since it never actually initializes here)
    // fallbackVisibleTime.
    await tester.pump(const Duration(milliseconds: 22000)); // delay elapses
    await tester.pump(); // pushReplacement builds the new route
    await tester.pump(
      const Duration(milliseconds: 900),
    ); // 600ms transition + margin

    expect(find.byType(SplashScreen), findsNothing);
  });
}
