// lib/pages/new_post/new_post_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we563_final_instagram_clone/pages/new_post/new_post_controller.dart';

class NewPostPage extends GetView<NewPostController> {
  static const title = 'New Post';
  static const route = '/newpost';

  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
        title: const Text('New Post'),
        centerTitle: true,
        actions: const [SizedBox(width: 8)],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  // main scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // caption
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/avatar.webp')),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.descTextEditingController,
                                  decoration: const InputDecoration(
                                    hintText: 'What\'s happening?',
                                    border: InputBorder.none,
                                  ),
                                  maxLines: null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // selected photos
                          Obx(() {
                            if (controller.selectedImages.isEmpty) {
                              return const SizedBox();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Selected Photos', style: theme.textTheme.titleSmall),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children:
                                      controller.selectedImages.map((path) {
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: theme.colorScheme.outlineVariant),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.asset(path, fit: BoxFit.cover),
                                              ),
                                            ),
                                            Positioned(
                                              top: -6,
                                              right: -6,
                                              child: IconButton(
                                                icon: const Icon(Icons.cancel, size: 20, color: Colors.redAccent),
                                                onPressed: () => controller.removeSelectedImage(path),
                                                tooltip: 'Remove',
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                ),
                                const SizedBox(height: 24),
                              ],
                            );
                          }),

                          // select up to 4 photos
                          Text('Select up to 4 photos', style: theme.textTheme.titleSmall),
                          const SizedBox(height: 12),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.galleryImages.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              final path = controller.galleryImages[index];
                              final isSelected = controller.selectedIndexes.contains(index);

                              return GestureDetector(
                                onTap: () => controller.toggleSelectImage(index),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? theme.colorScheme.primary
                                                    : theme.colorScheme.outlineVariant,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(path, fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Positioned(
                                        top: 6,
                                        right: 6,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.check, size: 16, color: Colors.white),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // bottom button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Obx(
                      () => ElevatedButton.icon(
                        onPressed: controller.canPost ? controller.onPostButtonPressed : null,
                        icon: const Icon(Icons.send),
                        label: const Text('Post Now'),
                        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
