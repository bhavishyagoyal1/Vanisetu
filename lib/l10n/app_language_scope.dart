import 'package:flutter/widgets.dart';

import 'app_language.dart';

/// Wraps the app so any descendant can read the current [AppLanguage] and
/// rebuild when it changes, without prop-drilling it through every screen.
class AppLanguageScope extends InheritedNotifier<AppLanguageController> {
  const AppLanguageScope({
    super.key,
    required AppLanguageController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppLanguageController of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppLanguageScope>();
    assert(scope != null, 'No AppLanguageScope found in context');
    return scope!.notifier!;
  }
}

extension AppLanguageContext on BuildContext {
  AppLanguage get appLanguage => AppLanguageScope.of(this).value;
}
