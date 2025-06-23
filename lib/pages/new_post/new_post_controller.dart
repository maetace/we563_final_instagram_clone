import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NewPostController extends GetxController {
  final descTextEditingController = TextEditingController();

  final galleryImages = List<String>.generate(
    12,
    (index) => 'assets/images/${(index + 1).toString().padLeft(3, '0')}.webp',
  );

  final selectedIndexes = <int>[].obs;

  List<String> get selectedImages => selectedIndexes.map((index) => galleryImages[index]).toList();

  final _canPost = false.obs;
  bool get canPost => _canPost.value;

  @override
  void onInit() {
    super.onInit();
    descTextEditingController.addListener(_validate);
  }

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

  void _validate() {
    _canPost.value = descTextEditingController.text.trim().isNotEmpty && selectedIndexes.isNotEmpty;
  }

  void onPostButtonPressed() {
    Get.back(result: {'description': descTextEditingController.text.trim(), 'images': selectedImages});
  }

  @override
  void onClose() {
    descTextEditingController.dispose();
    super.onClose();
  }
}
