import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;

import '../l10n/app_strings.dart';
import '../theme/app_colors.dart';
import 'curriculum_class_screen.dart';
import 'dictionary_screen.dart';
import 'translate_screen.dart';

/// App shell: bottom nav with Vaani Translate as the landing tab (index 1,
/// selected by default) and visually larger than Curriculum/Dictionary on
/// either side of it. Tabs are swipeable (a [PageView]) as well as
/// tap-to-select.
///
/// Each tab owns its own nested [Navigator] (kept alive as siblings in the
/// PageView, not rebuilt on tab switches) so drilling into a tab —
/// Curriculum -> Class -> Subject -> Chapter -> content, say — pushes
/// within that tab's stack instead of covering the whole shell; the bottom
/// bar stays visible and sticky on every screen, not just the three tab
/// roots. Swiping between tabs is only enabled while the active tab is at
/// its own root screen — once you've drilled in, a horizontal swipe would
/// otherwise fight with that screen's own back-swipe/scroll gestures, so it
/// is disabled until you back out. The system/gesture back button pops the
/// active tab's stack first, only exiting the app once that tab is already
/// at its root.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with WidgetsBindingObserver {
  int _index = 1;
  bool _activeTabAtRoot = true;

  final _pageController = PageController(initialPage: 1);
  final _navigatorKeys = List.generate(3, (_) => GlobalKey<NavigatorState>());
  late final List<_RootTrackingObserver> _observers = List.generate(
    3,
    (i) =>
        _RootTrackingObserver(onChanged: (atRoot) => _onRootChanged(i, atRoot)),
  );

  static const _roots = [
    CurriculumClassScreen(),
    TranslateScreen(),
    DictionaryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  // Backgrounding the app mid-swipe (a notification, the home gesture, the
  // screen locking) pauses the engine's ticker while the PageView is still
  // between pages — its ballistic settle animation never gets to finish, so
  // on resume the scroll position is left at a fractional page value
  // forever (verified on-device: a sliver of the neighbouring tab stays
  // visibly bled in at the edge until some other navigation forces a fresh
  // animateToPage). Re-snap to the current tab whenever the app comes back.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    if (!_pageController.hasClients) return;
    final page = _pageController.page;
    if (page != null && (page - _index).abs() > 0.001) {
      _pageController.jumpToPage(_index);
    }
  }

  void _onRootChanged(int tabIndex, bool atRoot) {
    if (tabIndex != _index) return;
    if (_activeTabAtRoot == atRoot) return;
    setState(() => _activeTabAtRoot = atRoot);
  }

  Widget _buildTabNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      observers: [_observers[index]],
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => _roots[index]),
    );
  }

  void _onTabTapped(int index) {
    if (index == _index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      // Defensive re-snap — see didChangeAppLifecycleState's doc comment for
      // why the PageView can otherwise be stuck at a fractional page.
      final page = _pageController.hasClients ? _pageController.page : null;
      if (page != null && (page - index).abs() > 0.001) {
        _pageController.jumpToPage(index);
      }
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _index = index;
      _activeTabAtRoot =
          !(_navigatorKeys[index].currentState?.canPop() ?? false);
    });
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
        body: PageView(
          controller: _pageController,
          physics: _activeTabAtRoot
              ? const PageScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          onPageChanged: _onPageChanged,
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

/// Reports whether its [Navigator] is sitting at its root route (i.e.
/// nothing left to pop) whenever the route stack changes, so the shell can
/// gate tab-swiping on it.
class _RootTrackingObserver extends NavigatorObserver {
  _RootTrackingObserver({required this.onChanged});

  final ValueChanged<bool> onChanged;

  void _report() {
    final nav = navigator;
    if (nav == null) return;
    onChanged(!nav.canPop());
  }

  @override
  void didPush(Route route, Route? previousRoute) => _report();

  @override
  void didPop(Route route, Route? previousRoute) => _report();

  @override
  void didRemove(Route route, Route? previousRoute) => _report();
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
