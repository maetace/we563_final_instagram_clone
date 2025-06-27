// lib/pages/new_post/widgets/caption_box.dart

// ===============================
// WIDGET: CAPTION BOX
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../post_new_controller.dart';

// ===============================
// CAPTION BOX
// ===============================

class CaptionBox extends GetView<PostNewController> {
  const CaptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // USER AVATAR
        const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/avatars_mock/yelena.jpg')),
        const SizedBox(width: 12),

        // CAPTION TEXTFIELD
        Expanded(
          child: TextFormField(
            controller: controller.descTextEditingController,
            decoration: InputDecoration(hintText: 'post_new_caption_box_hint'.tr, border: InputBorder.none),
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
