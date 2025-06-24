// lib/pages/new_post/widgets/photos_selector.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../post_new_controller.dart';

// Widget for selecting photos from gallery
class PhotosSelector extends GetView<PostNewController> {
  const PhotosSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title: show hint text for photo selection
        Text('post_new_photos_select_hint'.tr, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),

        // Grid view of gallery images (3 columns)
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // prevent inner scroll (use outer scroll)
          itemCount: controller.galleryImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns in grid
            crossAxisSpacing: 8, // spacing between columns
            mainAxisSpacing: 8, // spacing between rows
            childAspectRatio: 1, // square image
          ),

          // Use Obx inside itemBuilder to make each grid item reactive
          itemBuilder: (context, index) {
            final path = controller.galleryImages[index];

            return Obx(() {
              // Each item observes selectedIndexes → will update checkmark when selection changes
              final isSelected = controller.selectedIndexes.contains(index);

              return GestureDetector(
                onTap: () => controller.toggleSelectImage(index), // handle image select/deselect
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Image box with border (selected or unselected)
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? theme
                                        .colorScheme
                                        .primary // border color when selected
                                    : theme.colorScheme.outlineVariant, // border color when unselected
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(path, fit: BoxFit.cover), // display image
                        ),
                      ),
                    ),

                    // Show checkmark overlay if selected
                    if (isSelected)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                          child: const Icon(Icons.check, size: 16, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              );
            });
          },
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
