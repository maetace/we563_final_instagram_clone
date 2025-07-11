// lib/pages/new_post/post_new_page.dart

// ===============================
// PAGE: POST NEW PAGE
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets.dart';
import 'post_new_controller.dart';

import 'widgets/caption_box.dart';
import 'widgets/photos_selected.dart';
import 'widgets/photos_selector.dart';
import 'widgets/post_button.dart';

// ===============================
// POST NEW PAGE
// ===============================

class PostNewPage extends GetView<PostNewController> {
  static const title = 'post_new_title';
  static const route = '/postnew';

  const PostNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // ===============================
      // APP BAR
      // ===============================
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        title: Text(title.tr, style: theme.textTheme.titleLarge),
        leading: null,
        actions: const [LanguageSwitcher(), ThemeSwitcher()],
        actionsPadding: const EdgeInsets.only(right: 8),
      ),

      // ===============================
      // BODY
      // ===============================
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  // MAIN CONTENT
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [CaptionBox(), SizedBox(height: 24), PhotosSelected(), PhotosSelector()],
                      ),
                    ),
                  ),

                  // POST BUTTON
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
