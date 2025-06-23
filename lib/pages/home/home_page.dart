// lib/pages/home/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/services/post_service.dart';
import 'home_controller.dart';

import 'widgets/home_tab.dart';
import 'widgets/explore_tab.dart';
import 'widgets/reels_tab.dart';
import 'widgets/profile_tab.dart';
import 'widgets/bottom_nav_bar.dart';

import '/routes.dart';

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
          children: [const HomeTab(), const ExploreTab(), const ReelsTab(), const ProfileTab()],
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        onNewPostTap: () async {
          // ไปหน้า new post → รอ result
          final result = await Get.toNamed(AppRoutes.newPost);

          if (result != null && result is Map) {
            final description = result['description'] as String;
            final imagePaths = List<String>.from(result['images']);

            // Create Post
            final postService = Get.find<PostService>();
            await postService.createPostItem(description: description, images: imagePaths);

            // กลับมา → refresh feed
            controller.onRefreshPosts();
            controller.onBottomNavigationBarItemTap(0); // กลับไป feed tab
          }
        },
      ),
    );
  }
}
