// lib/pages/new_post/widgets/photos_selected.dart

// ===============================
// WIDGET: SELECTED PHOTOS
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../post_new_controller.dart';

// ===============================
// SELECTED PHOTOS
// ===============================

class PhotosSelected extends GetView<PostNewController> {
  const PhotosSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.selectedImages.isEmpty) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Text('Selected Photos', style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),

          // WRAP SELECTED IMAGES
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                controller.selectedImages.map((path) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // IMAGE BOX
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

                      // REMOVE BUTTON
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
    });
  }
}
