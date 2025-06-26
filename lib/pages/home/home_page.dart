// lib/pages/home/home_page.dart

// ===============================
// PAGE: HOME
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/services/post_service.dart';
import 'home_controller.dart';

import 'widgets/home_tab.dart';
import 'widgets/explore_tab.dart';
import 'widgets/reels_tab.dart';
import 'widgets/profile_tab.dart';
import 'widgets/bottom_nav_bar.dart';

import '/pages/post_new/post_new_binding.dart';
import '/pages/post_new/post_new_page.dart';

// ===============================
// LOGGER
// ===============================

final Logger _logger = Logger();

// ===============================
// HOME PAGE
// ===============================

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static const title = 'Home';
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,

      // ===============================
      // BODY: TABS
      // ===============================
      body: Obx(
        () => IndexedStack(
          index: controller.currentTabIndex,
          children: [
            const HomeTab(),
            const ExploreTab(),
            Obx(() => ReelsTab(currentTabIndex: controller.currentTabIndex)),
            const ProfileTab(),
          ],
        ),
      ),

      // ===============================
      // BOTTOM NAV BAR
      // ===============================
      bottomNavigationBar: Obx(
        () => HomeBottomNavBar(
          currentIndex: controller.currentTabIndex,
          isReelsTab: controller.currentTabIndex == 2,
          avatar: controller.userRxn.value?.avatar ?? '',

          // ===============================
          // NEW POST
          // ===============================
          onPostNewTap: () async {
            // final result = await Get.toNamed(AppRoutes.postNew);
            final result = await Get.to(() => PostNewPage(), binding: PostNewBinding(), fullscreenDialog: true);
            _logger.i('result from postNewPage = $result');

            if (result != null && result is Map) {
              final description = result['description'] as String;
              final imagePaths = List<String>.from(result['images']);
              _logger.i('createPostItem(description: $description, images: $imagePaths)');

              final postService = Get.find<PostService>();
              await postService.createPostItem(description: description, images: imagePaths);

              controller.onBottomNavigationBarItemTap(0);
              await controller.onRefreshPosts();
              controller.scrollController.jumpTo(0);
            }
          },

          // ===============================
          // SWITCH TAB
          // ===============================
          onTabSelected: (newTabIndex) {
            controller.onBottomNavigationBarItemTap(newTabIndex);
          },
        ),
      ),
    );
  }
}
