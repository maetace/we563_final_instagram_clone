// lib/pages/home/widgets/bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pages/home/home_controller.dart';

class HomeBottomNavBar extends GetView<HomeController> {
  final VoidCallback onNewPostTap;

  const HomeBottomNavBar({super.key, required this.onNewPostTap});

  @override
  Widget build(BuildContext context) {
    final isReelsTab = controller.currentTabIndex == 3;
    final theme = Theme.of(context);

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
        items: [
          _createBottomNavigationBarItem(Icons.home_outlined, Icons.home),
          _createBottomNavigationBarItem(Icons.search_outlined, Icons.search),
          _createBottomNavigationBarItem(Icons.add_box_outlined, Icons.add_box),
          _createBottomNavigationBarItem(Icons.video_library_outlined, Icons.video_library),
          _createProfileNavigationBarItem(context),
        ],
        currentIndex: controller.currentTabIndex,
        onTap: (index) {
          if (index == 2) {
            // ⭐ ถ้าเป็น NewPost → call callback
            onNewPostTap();
          } else {
            controller.onBottomNavigationBarItemTap(index);
          }
        },
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(IconData normalIcon, IconData selectedIcon) {
    return BottomNavigationBarItem(
      icon: Icon(normalIcon, size: 28),
      activeIcon: Icon(selectedIcon, size: 28),
      label: '',
    );
  }

  BottomNavigationBarItem _createProfileNavigationBarItem(BuildContext context) {
    final user = controller.userRxn.value;
    final avatar = user?.avatar ?? '';
    final hasAvatar = avatar.isNotEmpty;

    return BottomNavigationBarItem(
      icon: CircleAvatar(
        radius: 14,
        backgroundImage: hasAvatar ? AssetImage(avatar) : null,
        child: hasAvatar ? null : const Icon(Icons.person_outline, size: 20),
      ),
      activeIcon: CircleAvatar(
        radius: 14,
        backgroundImage: hasAvatar ? AssetImage(avatar) : null,
        child: hasAvatar ? null : const Icon(Icons.person, size: 20),
      ),
      label: '',
    );
  }
}
