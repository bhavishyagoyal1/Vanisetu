import 'package:flutter/material.dart';

import '../data/curriculum_data.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import 'chapter_detail_screen.dart';

class CurriculumChaptersScreen extends StatelessWidget {
  const CurriculumChaptersScreen({
    super.key,
    required this.classNumber,
    required this.subject,
  });

  final int classNumber;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(context, 'class_n_subject', {
            'n': '$classNumber',
            'subject': subject.name,
          }),
        ),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        itemCount: subject.chapters.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final chapter = subject.chapters[index];
          return Material(
            color: AppColors.navy.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChapterDetailScreen(
                    classNumber: classNumber,
                    subjectName: subject.name,
                    chapter: chapter,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.teal,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        chapter,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
