// lib/pages/post_new/post_new_controller.dart

// ===============================
// CONTROLLER: POST NEW PAGE
// ===============================

import 'package:get/get.dart';
import 'package:flutter/material.dart';

// ===============================
// POST NEW CONTROLLER
// ===============================

class PostNewController extends GetxController {
  // ===============================
  // STATE: TEXT CONTROLLER
  // ===============================

  final descTextEditingController = TextEditingController();

  // ===============================
  // STATE: GALLERY IMAGES
  // ===============================

  final galleryImages = List<String>.generate(
    12,
    (index) => 'assets/images/${(index + 1).toString().padLeft(3, '0')}.webp',
  );

  final selectedIndexes = <int>{}.obs;

  List<String> get selectedImages => selectedIndexes.map((index) => galleryImages[index]).toList();

  // ===============================
  // STATE: CAN POST
  // ===============================

  final _canPost = false.obs;
  bool get canPost => _canPost.value;

  // ===============================
  // INIT / CLOSE
  // ===============================

  @override
  void onInit() {
    super.onInit();
    descTextEditingController.addListener(_validate);
  }

  @override
  void onClose() {
    descTextEditingController.dispose();
    super.onClose();
  }

  // ===============================
  // SELECT IMAGE
  // ===============================

  void toggleSelectImage(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      if (selectedIndexes.length < 4) {
        selectedIndexes.add(index);
      }
    }
    _validate();
  }

  void removeSelectedImage(String path) {
    final index = galleryImages.indexOf(path);
    if (index != -1) {
      selectedIndexes.remove(index);
      _validate();
    }
  }

  // ===============================
  // VALIDATE
  // ===============================

  void _validate() {
    _canPost.value = descTextEditingController.text.trim().isNotEmpty && selectedIndexes.isNotEmpty;
  }

  // ===============================
  // POST BUTTON
  // ===============================

  void onPostButtonPressed() {
    Get.back(result: {'description': descTextEditingController.text.trim(), 'images': selectedImages});
  }
}
