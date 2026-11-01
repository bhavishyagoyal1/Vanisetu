import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The app's own interface language — separate from the Translate feature's
/// source/target languages (Hindi/Santali/Mundari), which are a translation
/// concern, not a display-language one.
enum AppLanguage {
  english('en', 'English'),
  hindi('hi', 'हिंदी');

  const AppLanguage(this.code, this.label);

  final String code;
  final String label;
}

/// Holds the current app language and persists the user's choice across
/// restarts. A single app-wide instance ([instance]) is wrapped around the
/// app in an [AppLanguageScope]; screens read it via `context.appLanguage`
/// and look up strings via `tr(context, 'key')` (see app_strings.dart).
class AppLanguageController extends ValueNotifier<AppLanguage> {
  AppLanguageController() : super(AppLanguage.english);

  static const _prefsKey = 'app_language_code';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code == null) return;
    value = AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.english,
    );
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (value == language) return;
    value = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, language.code);
  }
}
