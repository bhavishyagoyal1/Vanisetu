import 'package:flutter/material.dart';

import '../diagnostics/ram_monitor_controller.dart';
import '../l10n/app_language.dart';
import '../l10n/app_language_scope.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppLanguageScope.of(context);
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
          Text(
            tr(context, 'app_language_label'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            tr(context, 'app_language_description'),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.navy.withValues(alpha: 0.08)),
            ),
            child: Column(
              children: [
                for (final language in AppLanguage.values) ...[
                  if (language != AppLanguage.values.first)
                    Divider(
                      height: 1,
                      color: AppColors.navy.withValues(alpha: 0.06),
                    ),
                  ListenableBuilder(
                    listenable: controller,
                    builder: (context, _) {
                      final selected = controller.value == language;
                      return RadioListTile<AppLanguage>(
                        value: language,
                        groupValue: controller.value,
                        onChanged: (value) {
                          if (value != null) controller.setLanguage(value);
                        },
                        activeColor: AppColors.teal,
                        title: Text(
                          language.label,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            tr(context, 'diagnostics_label'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.navy.withValues(alpha: 0.08)),
            ),
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
