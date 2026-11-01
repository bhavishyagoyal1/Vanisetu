import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;

import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import 'curriculum_class_screen.dart';
import 'dictionary_screen.dart';
import 'translate_screen.dart';

/// App shell: bottom nav with Vaani Translate as the landing tab (index 1,
/// selected by default) and visually larger than Curriculum/Dictionary on
/// either side of it.
///
/// Each tab owns its own nested [Navigator] (kept alive under an
/// [IndexedStack], not rebuilt on tab switches) so drilling into a tab —
/// Curriculum -> Class -> Subject -> Chapter -> content, say — pushes
/// within that tab's stack instead of covering the whole shell; the bottom
/// bar stays visible and sticky on every screen, not just the three tab
/// roots. The system/gesture back button is wired to pop the active tab's
/// stack first, only exiting the app once that tab is already at its root.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 1;

  final _navigatorKeys = List.generate(3, (_) => GlobalKey<NavigatorState>());

  static const _roots = [
    CurriculumClassScreen(),
    TranslateScreen(),
    DictionaryScreen(),
  ];

  Widget _buildTabNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => _roots[index]),
    );
  }

  void _onTabTapped(int index) {
    if (index == _index) {
      // Tapping the already-active tab again: pop back to its root, a
      // common convention for bottom-nav apps.
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _index = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final navigator = _navigatorKeys[_index].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: List.generate(3, _buildTabNavigator),
        ),
        bottomNavigationBar: _BottomNavBar(
          index: _index,
          onChanged: _onTabTapped,
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // Tall enough for the featured item's bigger 56px circle + label —
        // the non-featured items (40px circle) fit with room to spare.
        height: 80,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            _NavItem(
              icon: Icons.auto_stories_rounded,
              label: tr(context, 'nav_curriculum'),
              color: AppColors.orange,
              selected: index == 0,
              onTap: () => onChanged(0),
            ),
            _NavItem(
              icon: Icons.translate_rounded,
              label: tr(context, 'nav_translate'),
              color: AppColors.teal,
              selected: index == 1,
              featured: true,
              onTap: () => onChanged(1),
            ),
            _NavItem(
              icon: Icons.menu_book_rounded,
              label: tr(context, 'nav_dictionary'),
              color: AppColors.navy,
              selected: index == 2,
              onTap: () => onChanged(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
    this.featured = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool selected;
  final bool featured;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = featured ? 30.0 : 22.0;
    final boxSize = featured ? 56.0 : 40.0;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: boxSize,
              height: boxSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? color : color.withValues(alpha: 0.1),
                boxShadow: featured && selected
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: selected ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? color : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
