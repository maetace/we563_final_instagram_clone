// lib/pages/login/login_binding.dart

// ===============================
// BINDING: LOGIN
// ===============================

import 'package:get/get.dart';
import 'login_controller.dart';

// ===============================
// LOGIN BINDING
// ===============================

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
