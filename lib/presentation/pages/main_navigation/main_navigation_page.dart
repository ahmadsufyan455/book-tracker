import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:librio/core/ext/ext_context.dart';
import 'package:librio/core/theme/app_colors.dart';
import 'package:librio/presentation/pages/home/home_page.dart';
import 'package:librio/presentation/pages/library/library_page.dart';
import 'package:librio/presentation/pages/settings/settings_page.dart';
import 'package:librio/presentation/pages/stats/stats_page.dart';

@RoutePage()
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;

  final List<Widget> _pages = [
    const HomePage(),
    const LibraryPage(),
    const StatsPage(),
    const SettingsPage(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    NavigationItem(
      icon: Icons.library_books_outlined,
      activeIcon: Icons.library_books,
      label: 'Library',
    ),
    NavigationItem(
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart,
      label: 'Stats',
    ),
    NavigationItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.librioDarkSurface
              : AppColors.librioLightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
              blurRadius: 12,
              offset: const Offset(0, -2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navigationItems.length,
                (index) => _buildNavigationItem(index, isDark),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(int index, bool isDark) {
    final item = _navigationItems[index];
    final isSelected = index == _currentIndex;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.librioBlue.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? item.activeIcon : item.icon,
                key: ValueKey(isSelected),
                color: isSelected
                    ? AppColors.librioBlue
                    : isDark
                    ? AppColors.librioDarkSubtitle
                    : AppColors.librioLightSubtitle,
                size: 22,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? AppColors.librioBlue
                    : isDark
                    ? AppColors.librioDarkSubtitle
                    : AppColors.librioLightSubtitle,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
