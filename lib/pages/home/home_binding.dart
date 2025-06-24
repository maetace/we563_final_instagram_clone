// lib/pages/home/home_binding.dart

// ===============================
// BINDING: HOME
// ===============================

import 'package:get/get.dart';
import 'home_controller.dart';

// ===============================
// HOME BINDING
// ===============================

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
