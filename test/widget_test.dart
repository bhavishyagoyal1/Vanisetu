import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vaanisetu/main.dart';
import 'package:vaanisetu/screens/splash_screen.dart';

void main() {
  testWidgets('App starts on the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const VaaniSetuApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Let the splash screen's navigation timer fire so it doesn't leak.
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
