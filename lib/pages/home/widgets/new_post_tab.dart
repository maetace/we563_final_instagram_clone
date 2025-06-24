// lib/pages/home/widgets/new_post_tab.dart

// ===============================
// WIDGET: NEW POST TAB
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/routes.dart';
import '/services/post_service.dart';
import '/pages/home/home_controller.dart';

// ===============================
// NEW POST TAB
// ===============================

class NewPostTab extends GetView<HomeController> {
  const NewPostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add_box),
        label: const Text('Create New Post'),

        // ===============================
        // ON PRESS: NEW POST
        // ===============================
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.postNew);

          if (result != null && result is Map) {
            final description = result['description'] as String;
            final imagePaths = List<String>.from(result['images']);

            // Create Post
            final postService = Get.find<PostService>();
            await postService.createPostItem(description: description, images: imagePaths);

            // Refresh feed
            controller.onRefreshPosts();
          }
        },
      ),
    );
  }
}
