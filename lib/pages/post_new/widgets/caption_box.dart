// lib/pages/new_post/widgets/caption_box.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../post_new_controller.dart';

// Caption input box widget
class CaptionBox extends GetView<PostNewController> {
  const CaptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User avatar
        const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/avatar.webp')),
        const SizedBox(width: 12),

        // Text field for caption
        Expanded(
          child: TextFormField(
            controller: controller.descTextEditingController,
            decoration: InputDecoration(
              hintText: 'post_new_caption_box_hint'.tr, // localized hint text
              border: InputBorder.none,
            ),
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
