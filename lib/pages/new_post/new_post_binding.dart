// lib/pages/new_post/new_post_binding.dart

import 'package:get/get.dart';
import 'new_post_controller.dart';

class NewPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewPostController());
  }
}
