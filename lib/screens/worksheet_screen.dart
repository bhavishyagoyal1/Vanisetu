import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class WorksheetScreen extends StatelessWidget {
  const WorksheetScreen({
    super.key,
    required this.chapter,
    required this.questions,
  });

  final String chapter;
  final List<String> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(chapter, overflow: TextOverflow.ellipsis),
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
        itemCount: questions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.navy.withValues(alpha: 0.08)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFE0524D),
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
                    questions[index],
                    style: const TextStyle(fontSize: 15.5, height: 1.4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
