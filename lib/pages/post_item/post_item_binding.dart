// lib/pages/post_item/post_item_binding.dart

// ===============================
// BINDING: POST ITEM PAGE
// ===============================

import 'package:get/get.dart';
import '/pages/post_item/post_item_controller.dart';

// ===============================
// POST ITEM BINDING
// ===============================

class PostItemBinding implements Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;
    final postItem = args['postItem'];

    Get.lazyPut(() => PostItemController(postItem: postItem));
  }
}
