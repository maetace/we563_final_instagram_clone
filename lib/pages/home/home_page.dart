// lib/pages/home/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/home/home_controller.dart';
import '/pages/home/widgets/home_tab.dart'; // HomeTab widget
import '/widgets.dart'; // AppPageContainer, Switchers, LoadingButton

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static const title = 'Home';
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Obx(
        () => IndexedStack(
          index: controller.currentTabIndex,
          children: [
            const HomeTab(), // HomeTab จริง (Feed)
            _buildExploreTab(context),
            _buildNewPostTab(context),
            _buildReelsTab(context),
            _buildProfileTab(context),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
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
          onTap: controller.onBottomNavigationBarItemTap,
        ),
      ),
    );
  }

  // Other Tabs (Mock)

  Widget _buildExploreTab(BuildContext context) {
    return const Center(child: Text('Explore (mock)'));
  }

  Widget _buildNewPostTab(BuildContext context) {
    return const Center(child: Text('New Post (mock)'));
  }

  Widget _buildReelsTab(BuildContext context) {
    return const Center(child: Text('Reels (mock)'));
  }

  Widget _buildProfileTab(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          actions: const [LanguageSwitcher(), ThemeSwitcher()],
          actionsPadding: const EdgeInsets.only(right: 8),
        ),
        Expanded(
          child: AppPageContainer(
            child: Obx(() {
              final user = controller.userRxn.value;

              if (user == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final avatar = user.avatar;
              final hasAvatar = avatar.isNotEmpty;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  CircleAvatar(
                    radius: 92,
                    foregroundImage: hasAvatar ? (AssetImage(avatar) as ImageProvider) : null,
                    child: hasAvatar ? null : const Icon(Icons.person_2_outlined, size: 184),
                  ),
                  const SizedBox(height: 12),
                  Text(user.fullname, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    'welcome_back'.trParams({'user': user.fullname}),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: LoadingButton(
                          onPressed: controller.onWelcomePressed,
                          isLoading: false,
                          label: 'welcome'.tr,
                          type: ButtonType.elevated,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LoadingButton(
                          onPressed: controller.onLogOutPressed,
                          isLoading: controller.isLogOutLoading,
                          label: 'logout'.tr,
                          type: ButtonType.elevated,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // BottomNavigationBarItem

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
