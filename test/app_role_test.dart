import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaanisetu/role/app_role.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('starts with no role chosen', () {
    expect(AppRoleController().value, isNull);
  });

  test('load() leaves the role null when nothing was ever stored', () async {
    SharedPreferences.setMockInitialValues({});
    final controller = AppRoleController();

    await controller.load();

    expect(controller.value, isNull);
  });

  test('load() restores a previously stored role', () async {
    SharedPreferences.setMockInitialValues({'app_role': 'student'});
    final controller = AppRoleController();

    await controller.load();

    expect(controller.value, AppRole.student);
  });

  test(
    'load() ignores a stored value that is no longer a known role',
    () async {
      SharedPreferences.setMockInitialValues({'app_role': 'headmaster'});
      final controller = AppRoleController();

      await controller.load();

      expect(controller.value, isNull);
    },
  );

  test('setRole() persists the choice for the next launch', () async {
    SharedPreferences.setMockInitialValues({});
    await AppRoleController().setRole(AppRole.teacher);

    final reloaded = AppRoleController();
    await reloaded.load();

    expect(reloaded.value, AppRole.teacher);
  });

  test('setRole() notifies listeners', () async {
    SharedPreferences.setMockInitialValues({});
    final controller = AppRoleController();
    var notifications = 0;
    controller.addListener(() => notifications++);

    await controller.setRole(AppRole.teacher);

    expect(notifications, 1);
  });

  test('load() is only performed once even if called repeatedly', () async {
    SharedPreferences.setMockInitialValues({'app_role': 'teacher'});
    final controller = AppRoleController();

    await Future.wait(<Future<void>>[controller.load(), controller.load()]);
    // A second load() after the user has switched roles in Settings must not
    // clobber that choice by re-reading the value it was constructed with.
    await controller.setRole(AppRole.student);
    await controller.load();

    expect(controller.value, AppRole.student);
  });
}
