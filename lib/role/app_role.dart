import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Who is holding the tablet. Chosen once on first launch and changeable
/// later in Settings — see [AppRoleController].
///
/// This is a content-audience concern, not a permissions one: nothing here
/// restricts access, it only decides which study material a chapter offers
/// (teachers get the worksheet and an answer key, students get the quiz).
enum AppRole {
  teacher('teacher'),
  student('student');

  const AppRole(this.code);

  /// Stable storage key — persisted, so do not rename without a migration.
  final String code;
}

/// Holds the chosen [AppRole] and persists it across restarts.
///
/// `null` means "not chosen yet", which is what routes the splash to the
/// role screen instead of straight to the shell; it is a real state, not a
/// missing value, so it is never silently defaulted to a role.
///
/// Mirrors `AppLanguageController`: a single app-wide instance wrapped
/// around the app in an [AppRoleScope], read by screens via
/// `context.appRole`.
class AppRoleController extends ValueNotifier<AppRole?> {
  AppRoleController() : super(null);

  static const _prefsKey = 'app_role';

  Future<void>? _loading;

  /// Reads the stored role. Idempotent and memoized: the splash awaits this
  /// to decide where to go, and it must not re-read (and so undo) a role the
  /// user has since changed in Settings.
  Future<void> load() {
    return _loading ??= _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code == null) return;
    for (final role in AppRole.values) {
      if (role.code == code) {
        value = role;
        return;
      }
    }
  }

  Future<void> setRole(AppRole role) async {
    value = role;
    // A role set before load() ran would otherwise be overwritten when the
    // memoized load finally resolves.
    _loading ??= Future.value();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, role.code);
  }
}

/// Wraps the app so any descendant can read the current [AppRole] and
/// rebuild when it changes, without prop-drilling it through every screen.
class AppRoleScope extends InheritedNotifier<AppRoleController> {
  const AppRoleScope({
    super.key,
    required AppRoleController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppRoleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppRoleScope>();
    assert(scope != null, 'No AppRoleScope found in context');
    return scope!.notifier!;
  }

  /// One-shot read that does NOT subscribe the caller to role changes.
  ///
  /// [of] is illegal before `initState` completes, which is exactly where
  /// SplashScreen needs the role to decide where to route — and a splash
  /// that rebuilt on a later role change would be wrong anyway.
  static AppRoleController read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppRoleScope>();
    assert(scope != null, 'No AppRoleScope found in context');
    return scope!.notifier!;
  }
}

extension AppRoleContext on BuildContext {
  AppRole? get appRole => AppRoleScope.of(this).value;
}
