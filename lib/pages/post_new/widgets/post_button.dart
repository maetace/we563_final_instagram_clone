// lib/pages/new_post/widgets/post_button.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../post_new_controller.dart';

// Bottom post button widget
class PostButton extends GetView<PostNewController> {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => ElevatedButton.icon(
          onPressed: controller.canPost ? controller.onPostButtonPressed : null, // button action
          icon: const Icon(Icons.send), // send icon
          label: Text('post_new_post_button'.tr), // localized button label
          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)), // min height
        ),
      ),
    );
  }
}
