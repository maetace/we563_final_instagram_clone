// lib/pages/new_post/widgets/photos_selector.dart

// ===============================
// WIDGET: PHOTOS SELECTOR (GRID)
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../post_new_controller.dart';

// ===============================
// PHOTOS SELECTOR
// ===============================

class PhotosSelector extends GetView<PostNewController> {
  const PhotosSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SECTION TITLE
        Text('post_new_photos_select_hint'.tr, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),

        // GRID VIEW
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

            return Obx(() {
              final isSelected = controller.selectedIndexes.contains(index);

              return GestureDetector(
                onTap: () => controller.toggleSelectImage(index),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // IMAGE BOX
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(path, fit: BoxFit.cover),
                        ),
                      ),
                    ),

                    // CHECKMARK
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
