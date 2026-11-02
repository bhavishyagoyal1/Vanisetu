import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'diagnostics/ram_monitor_overlay.dart';
import 'l10n/app_language.dart';
import 'l10n/app_language_scope.dart';
import 'role/app_role.dart';
import 'screens/splash_screen.dart';

void main() {
  // Without this, an exception thrown inside a gesture callback (e.g. a
  // failed plugin call) is swallowed by Flutter's zone handler and only
  // ever reaches the console — never the user. Logging it to logcat here
  // is what makes that failure diagnosable on a device with no attached
  // terminal.
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint(
      'FlutterError: ${details.exceptionAsString()}\n${details.stack}',
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Uncaught error: $error\n$stack');
    return true;
  };

  runApp(const VaaniSetuApp());
}

class VaaniSetuApp extends StatefulWidget {
  const VaaniSetuApp({super.key});

  @override
  State<VaaniSetuApp> createState() => _VaaniSetuAppState();
}

class _VaaniSetuAppState extends State<VaaniSetuApp> {
  final _languageController = AppLanguageController();
  final _roleController = AppRoleController();

  @override
  void initState() {
    super.initState();
    _languageController.load();
    // Started here rather than awaited: SplashScreen awaits the same
    // memoized future before it decides where to route, so the prefs read
    // overlaps the splash animation instead of delaying first paint.
    _roleController.load();
  }

  @override
  void dispose() {
    _languageController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppRoleScope(
      controller: _roleController,
      child: AppLanguageScope(
        controller: _languageController,
        child: MaterialApp(
          title: 'VaaniSetu',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1B3A6B),
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const SplashScreen(),
          builder: (context, child) {
            return Stack(children: [?child, const RamMonitorOverlay()]);
          },
        ),
      ),
    );
  }
}
