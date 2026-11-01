import 'package:flutter/material.dart';

import '../data/chapter_content_data.dart';
import '../theme/app_colors.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({
    super.key,
    required this.chapter,
    required this.questions,
  });

  final String chapter;
  final List<AssessmentQuestion> questions;

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  late final _selected = List<int?>.filled(widget.questions.length, null);
  bool _submitted = false;

  int get _score {
    var score = 0;
    for (var i = 0; i < widget.questions.length; i++) {
      if (_selected[i] == widget.questions[i].correctIndex) score++;
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final allAnswered = !_selected.contains(null);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(widget.chapter, overflow: TextOverflow.ellipsis),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          if (_submitted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.teal.withValues(alpha: 0.12),
              child: Text(
                'Score: $_score / ${widget.questions.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.teal,
                ),
              ),
            ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                16 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: widget.questions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, qIndex) {
                final q = widget.questions[qIndex];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.navy.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${qIndex + 1}. ${q.question}',
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var oIndex = 0; oIndex < q.options.length; oIndex++)
                        _OptionTile(
                          text: q.options[oIndex],
                          selected: _selected[qIndex] == oIndex,
                          correct: _submitted && oIndex == q.correctIndex,
                          wrong:
                              _submitted &&
                              _selected[qIndex] == oIndex &&
                              oIndex != q.correctIndex,
                          onTap: _submitted
                              ? null
                              : () =>
                                    setState(() => _selected[qIndex] = oIndex),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submitted
                    ? () => setState(() {
                        _submitted = false;
                        _selected.fillRange(0, _selected.length, null);
                      })
                    : allAnswered
                    ? () => setState(() => _submitted = true)
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(_submitted ? 'Retry' : 'Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.text,
    required this.selected,
    required this.correct,
    required this.wrong,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final bool correct;
  final bool wrong;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey.shade300;
    Color? fillColor;
    if (correct) {
      borderColor = AppColors.teal;
      fillColor = AppColors.teal.withValues(alpha: 0.1);
    } else if (wrong) {
      borderColor = Colors.redAccent;
      fillColor = Colors.redAccent.withValues(alpha: 0.08);
    } else if (selected) {
      borderColor = AppColors.navy;
      fillColor = AppColors.navy.withValues(alpha: 0.06);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: fillColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Icon(
                  correct
                      ? Icons.check_circle_rounded
                      : wrong
                      ? Icons.cancel_rounded
                      : selected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 18,
                  color: correct
                      ? AppColors.teal
                      : wrong
                      ? Colors.redAccent
                      : selected
                      ? AppColors.navy
                      : Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(text, style: const TextStyle(fontSize: 14.5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
