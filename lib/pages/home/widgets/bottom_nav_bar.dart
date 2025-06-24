// lib/pages/home/widgets/bottom_nav_bar.dart

// ===============================
// WIDGET: HOME BOTTOM NAV BAR
// ===============================

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// ===============================
// LOGGER
// ===============================

final Logger _logger = Logger();

// ===============================
// HOME BOTTOM NAV BAR
// ===============================

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final bool isReelsTab;
  final String avatar;
  final VoidCallback onNewPostTap;
  final Function(int newTabIndex) onTabSelected;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.isReelsTab,
    required this.avatar,
    required this.onNewPostTap,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ⭐ Map currentIndex → navBarIndex
    final navBarIndex = currentIndex >= 2 ? currentIndex + 1 : currentIndex;

    return Theme(
      data: theme.copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isReelsTab ? Colors.black : theme.bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: isReelsTab ? Colors.white : theme.bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: isReelsTab ? Colors.white70 : theme.bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: navBarIndex,

        // ===============================
        // ON TAP
        // ===============================
        onTap: (index) {
          _logger.i('[BottomNavBar] tapped index = $index');
          if (index == 2) {
            onNewPostTap();
          } else {
            final newTabIndex = index > 2 ? index - 1 : index;
            _logger.i('[BottomNavBar] will switch to tab index = $newTabIndex');
            onTabSelected(newTabIndex);
          }
        },

        // ===============================
        // ITEMS
        // ===============================
        items: [
          _createBottomNavigationBarItem(
            normalIcon: Icons.home_outlined,
            selectedIcon: Icons.home,
            isSelected: currentIndex == 0,
          ),
          _createBottomNavigationBarItem(
            normalIcon: Icons.search_outlined,
            selectedIcon: Icons.zoom_in,
            isSelected: currentIndex == 1,
          ),
          _createBottomNavigationBarItem(
            normalIcon: Icons.add_box_outlined,
            selectedIcon: Icons.add_box,
            isSelected: false,
          ),
          _createBottomNavigationBarItem(
            normalIcon: Icons.video_library_outlined,
            selectedIcon: Icons.video_library,
            isSelected: currentIndex == 2,
          ),
          _createProfileNavigationBarItem(isSelected: currentIndex == 3),
        ],
      ),
    );
  }

  // ===============================
  // NAV ITEM (ICON)
  // ===============================

  BottomNavigationBarItem _createBottomNavigationBarItem({
    required IconData normalIcon,
    required IconData selectedIcon,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(icon: Icon(isSelected ? selectedIcon : normalIcon, size: 28), label: '');
  }

  // ===============================
  // NAV ITEM (PROFILE)
  // ===============================

  BottomNavigationBarItem _createProfileNavigationBarItem({required bool isSelected}) {
    final hasAvatar = avatar.isNotEmpty;

    return BottomNavigationBarItem(
      icon: CircleAvatar(
        radius: 14,
        backgroundImage: hasAvatar ? AssetImage(avatar) : null,
        child: hasAvatar ? null : Icon(isSelected ? Icons.person : Icons.person_outline, size: 20),
      ),
      label: '',
    );
  }
}
