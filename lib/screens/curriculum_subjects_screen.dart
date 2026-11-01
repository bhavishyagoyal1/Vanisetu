import 'package:flutter/material.dart';

import '../data/curriculum_data.dart';
import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import 'curriculum_chapters_screen.dart';

class CurriculumSubjectsScreen extends StatelessWidget {
  const CurriculumSubjectsScreen({super.key, required this.classNumber});

  final int classNumber;

  static const _subjectIcons = {
    'Hindi': Icons.menu_book,
    'English': Icons.translate,
    'Mathematics': Icons.calculate,
    'Environmental Studies': Icons.eco,
  };

  @override
  Widget build(BuildContext context) {
    final classCurriculum = curriculumData.firstWhere(
      (c) => c.classNumber == classNumber,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'class_n_subjects', {'n': '$classNumber'})),
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
        itemCount: classCurriculum.subjects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final subject = classCurriculum.subjects[index];
          return Material(
            color: AppColors.teal.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CurriculumChaptersScreen(
                    classNumber: classNumber,
                    subject: subject,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.teal.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _subjectIcons[subject.name] ?? Icons.book,
                      color: AppColors.navy,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        subject.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      tr(context, 'n_chapters', {
                        'n': '${subject.chapters.length}',
                      }),
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_ios, size: 14),
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
