// lib/pages/new_post/new_post_binding.dart

// ===============================
// BINDING: POST NEW PAGE
// ===============================

import 'package:get/get.dart';
import 'post_new_controller.dart';

// ===============================
// POST NEW BINDING
// ===============================

class PostNewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostNewController());
  }
}
