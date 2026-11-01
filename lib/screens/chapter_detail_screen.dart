import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import 'content_placeholder_screen.dart';

/// Chapter -> {Lesson, Worksheet, Flashcards, Assessment}. Each leads to a
/// placeholder for now — see ContentPlaceholderScreen's doc comment for why.
class ChapterDetailScreen extends StatelessWidget {
  const ChapterDetailScreen({
    super.key,
    required this.classNumber,
    required this.subjectName,
    required this.chapter,
  });

  final int classNumber;
  final String subjectName;
  final String chapter;

  static const _worksheetColor = Color(0xFFE0524D);
  static const _flashcardsColor = Color(0xFF2FAF6B);
  static const _assessmentColor = Color(0xFFE0568C);

  void _open(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ContentPlaceholderScreen(
          title: title,
          icon: icon,
          color: color,
          subtitle: subtitle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(chapter, overflow: TextOverflow.ellipsis),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(context, 'class_n_subject', {
                'n': '$classNumber',
                'subject': subjectName,
              }),
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            _ContentTile(
              icon: Icons.description_rounded,
              color: _worksheetColor,
              title: tr(context, 'content_worksheet'),
              onTap: () => _open(
                context,
                title: tr(context, 'content_worksheet'),
                icon: Icons.description_rounded,
                color: _worksheetColor,
                subtitle: tr(context, 'content_worksheet_subtitle', {
                  'chapter': chapter,
                }),
              ),
            ),
            const SizedBox(height: 12),
            _ContentTile(
              icon: Icons.style_rounded,
              color: _flashcardsColor,
              title: tr(context, 'content_flashcards'),
              onTap: () => _open(
                context,
                title: tr(context, 'content_flashcards'),
                icon: Icons.style_rounded,
                color: _flashcardsColor,
                subtitle: tr(context, 'content_flashcards_subtitle', {
                  'chapter': chapter,
                }),
              ),
            ),
            const SizedBox(height: 12),
            _ContentTile(
              icon: Icons.fact_check_rounded,
              color: _assessmentColor,
              title: tr(context, 'content_assessment'),
              onTap: () => _open(
                context,
                title: tr(context, 'content_assessment'),
                icon: Icons.fact_check_rounded,
                color: _assessmentColor,
                subtitle: tr(context, 'content_assessment_subtitle', {
                  'chapter': chapter,
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentTile extends StatelessWidget {
  const _ContentTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.15)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
