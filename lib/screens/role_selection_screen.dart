import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../role/app_role.dart';
import '../theme/app_colors.dart';
import 'main_shell.dart';

/// Who is using the tablet, asked after the logo on every launch — these
/// devices are shared, so the answer can differ from one session to the
/// next. The previous answer is persisted and marked here as the current
/// one, so the common case is a single confirming tap.
///
/// Both roles get the identical shell. The role only decides which study
/// material a chapter offers (see [ChapterDetailScreen]), so nothing here
/// is a permission boundary and either choice is freely reversible.
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Future<void> _choose(BuildContext context, AppRole role) async {
    await AppRoleScope.of(context).setRole(role);
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainShell(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = context.appRole;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png', width: 110, height: 110),
                const SizedBox(height: 28),
                Text(
                  tr(context, 'role_question'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tr(context, 'role_subtitle'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),
                _RoleCard(
                  icon: Icons.co_present_rounded,
                  title: tr(context, 'role_teacher'),
                  subtitle: tr(context, 'role_teacher_subtitle'),
                  gradientColors: const [AppColors.navy, Color(0xFF3A63A8)],
                  isCurrent: current == AppRole.teacher,
                  onTap: () => _choose(context, AppRole.teacher),
                ),
                const SizedBox(height: 16),
                _RoleCard(
                  icon: Icons.school_rounded,
                  title: tr(context, 'role_student'),
                  subtitle: tr(context, 'role_student_subtitle'),
                  gradientColors: const [AppColors.teal, Color(0xFF6FBF9A)],
                  isCurrent: current == AppRole.student,
                  onTap: () => _choose(context, AppRole.student),
                ),
                const SizedBox(height: 24),
                Text(
                  tr(context, 'role_change_hint'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
    this.isCurrent = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  /// Marks the role carried over from the last session.
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors.first.withValues(alpha: 0.28),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.3,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isCurrent
                      ? Icons.check_circle_rounded
                      : Icons.chevron_right_rounded,
                  color: isCurrent ? Colors.white : Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
