// lib/pages/home/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/home/home_controller.dart';
import '/widgets.dart'; // LoadingButton, AppPageContainer, Switchers

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
            _buildHomeTab(context), // ➜ Tab 0: Feed / Home
            _buildExploreTab(context), // ➜ Tab 1: Explore
            _buildNewPostTab(context), // ➜ Tab 2: Add Post
            _buildReelsTab(context), // ➜ Tab 3: Reels
            _buildProfileTab(context), // ➜ Tab 4: Profile (Layout เดิม)
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
            _createBottomNavigationBarItem(Icons.video_library_outlined, Icons.video_library), // Reels
            _createProfileNavigationBarItem(context), // Profile Avatar
          ],
          currentIndex: controller.currentTabIndex,
          onTap: controller.onBottomNavigationBarItemTap,
        ),
      ),
    );
  }

  // ====== Home Tab (with Instagram AppBar) ======

  Widget _buildHomeTab(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            titleSpacing: 16, // margin left
            title: Image.asset(
              'assets/images/instagram_logo.png',
              height: 38, // ใช้ตามที่คุณวัดจริง
            ),
            actions: [
              IconButton(icon: Icon(Icons.favorite_border, size: 28), onPressed: () {}),
              IconButton(icon: Icon(Icons.chat_bubble_outline, size: 28), onPressed: () {}),
              const SizedBox(width: 8),
            ],
          ),
          Expanded(child: Center(child: Text('Feed / Home (mock)', style: Theme.of(context).textTheme.titleLarge))),
        ],
      ),
    );
  }

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
    return SafeArea(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
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

                    // Fullname
                    Text(user.fullname, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    // Welcome message
                    Text(
                      'welcome_back'.trParams({'user': user.fullname}),
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 48),

                    // Buttons
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
      ),
    );
  }

  // ====== BottomNavigationBarItem (icon only, size 28 px) ======

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
        radius: 14, // 14 * 2 = 28 px
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
