import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const VaaniSetuApp());
}

class VaaniSetuApp extends StatelessWidget {
  const VaaniSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VaaniSetu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B3A6B)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
