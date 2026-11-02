import 'package:flutter/material.dart';

import '../data/chapter_content_data.dart';
import '../theme/app_colors.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({
    super.key,
    required this.chapter,
    required this.cards,
  });

  final String chapter;
  final List<Flashcard> cards;

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  final _pageController = PageController();
  int _index = 0;
  bool _flipped = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_index + delta).clamp(0, widget.cards.length - 1);
    if (next == _index) return;
    setState(() => _flipped = false);
    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(widget.chapter, overflow: TextOverflow.ellipsis),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                '${_index + 1} / ${widget.cards.length}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.cards.length,
                onPageChanged: (i) => setState(() {
                  _index = i;
                  _flipped = false;
                }),
                itemBuilder: (context, i) {
                  final card = widget.cards[i];
                  if (card.imagePath != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            card.imagePath!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: GestureDetector(
                      onTap: () => setState(() => _flipped = !_flipped),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          key: ValueKey(_flipped),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _flipped
                                  ? [AppColors.teal, const Color(0xFF6FBF9A)]
                                  : [AppColors.navy, const Color(0xFF3E63A0)],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(28),
                          alignment: Alignment.center,
                          child: Text(
                            _flipped ? card.meaning : card.term,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.cards[_index].imagePath == null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 4,
                ),
                child: Text(
                  'Tap the card to flip',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              )
            else
              const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _index == 0 ? null : () => _go(-1),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Prev'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _index == widget.cards.length - 1
                          ? null
                          : () => _go(1),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Next'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.teal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
