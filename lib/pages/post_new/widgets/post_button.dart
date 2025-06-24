// lib/pages/new_post/widgets/post_button.dart

// ===============================
// WIDGET: POST BUTTON (BOTTOM)
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../post_new_controller.dart';

// ===============================
// POST BUTTON
// ===============================

class PostButton extends GetView<PostNewController> {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => ElevatedButton.icon(
          onPressed: controller.canPost ? controller.onPostButtonPressed : null,
          icon: const Icon(Icons.send),
          label: Text('post_new_post_button'.tr),
          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
        ),
      ),
    );
  }
}
