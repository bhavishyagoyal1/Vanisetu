import 'package:flutter/material.dart';

import '../diagnostics/ram_monitor_controller.dart';
import '../l10n/app_language.dart';
import '../l10n/app_language_scope.dart';
import '../l10n/app_strings.dart';
import '../role/app_role.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = AppLanguageScope.of(context);
    final roleController = AppRoleScope.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(tr(context, 'settings_title')),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          20,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        children: [
          _SectionHeader(
            label: tr(context, 'role_label'),
            description: tr(context, 'role_description'),
          ),
          _SettingsCard(
            child: ListenableBuilder(
              listenable: roleController,
              builder: (context, _) {
                return RadioGroup<AppRole>(
                  groupValue: roleController.value,
                  onChanged: (value) {
                    if (value != null) roleController.setRole(value);
                  },
                  child: Column(
                    children: [
                      for (final role in AppRole.values) ...[
                        if (role != AppRole.values.first) const _CardDivider(),
                        RadioListTile<AppRole>(
                          value: role,
                          activeColor: AppColors.teal,
                          title: Text(
                            tr(context, _roleTitleKey(role)),
                            style: TextStyle(
                              fontWeight: roleController.value == role
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            tr(context, _roleSubtitleKey(role)),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          _SectionHeader(
            label: tr(context, 'app_language_label'),
            description: tr(context, 'app_language_description'),
          ),
          _SettingsCard(
            child: ListenableBuilder(
              listenable: languageController,
              builder: (context, _) {
                return RadioGroup<AppLanguage>(
                  groupValue: languageController.value,
                  onChanged: (value) {
                    if (value != null) languageController.setLanguage(value);
                  },
                  child: Column(
                    children: [
                      for (final language in AppLanguage.values) ...[
                        if (language != AppLanguage.values.first)
                          const _CardDivider(),
                        RadioListTile<AppLanguage>(
                          value: language,
                          activeColor: AppColors.teal,
                          title: Text(
                            language.label,
                            style: TextStyle(
                              fontWeight: languageController.value == language
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          Text(
            tr(context, 'diagnostics_label'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _SettingsCard(
            child: ListenableBuilder(
              listenable: RamMonitorController.instance,
              builder: (context, _) {
                return SwitchListTile(
                  value: RamMonitorController.instance.enabled,
                  onChanged: RamMonitorController.instance.setEnabled,
                  activeTrackColor: AppColors.teal,
                  title: Text(
                    tr(context, 'ram_monitor_label'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    tr(context, 'ram_monitor_description'),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String _roleTitleKey(AppRole role) =>
    role == AppRole.teacher ? 'role_teacher' : 'role_student';

String _roleSubtitleKey(AppRole role) =>
    role == AppRole.teacher ? 'role_teacher_subtitle' : 'role_student_subtitle';

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.description});

  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.4),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.navy.withValues(alpha: 0.08)),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: AppColors.navy.withValues(alpha: 0.06));
  }
}
