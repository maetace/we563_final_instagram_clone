// lib/pages/new_post/post_new_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'post_new_controller.dart';

import 'widgets/caption_box.dart';
import 'widgets/photos_selected.dart';
import 'widgets/photos_selector.dart';
import 'widgets/post_button.dart';

// Page for creating a new post
class PostNewPage extends GetView<PostNewController> {
  static const title = 'post_new_title';
  static const route = '/postnew';

  const PostNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with close button
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close), // close icon
          onPressed: () => Get.back(), // close action
        ),
        title: Text(title.tr), // localized title
        centerTitle: true,
      ),

      // Main body with SafeArea
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard on tap outside
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430), // max width constraint
              child: Column(
                children: [
                  // Main scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CaptionBox(), // caption text input
                          SizedBox(height: 24),
                          PhotosSelected(), // selected photos list
                          PhotosSelector(), // photo selection grid
                        ],
                      ),
                    ),
                  ),

                  // Bottom post button
                  const PostButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
