// lib/pages/new_post/new_post_binding.dart

import 'package:get/get.dart';
import 'post_new_controller.dart';

class PostNewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostNewController());
  }
}
