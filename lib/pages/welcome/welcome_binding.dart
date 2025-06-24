// lib/pages/welcome/welcome_binding.dart

// ===============================
// BINDING: WELCOME
// ===============================

import 'package:get/get.dart';
import 'welcome_controller.dart';

// ===============================
// WELCOME BINDING
// ===============================

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
