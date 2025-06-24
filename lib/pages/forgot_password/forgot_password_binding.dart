// lib/pages/forgot_password/forgot_password_binding.dart

// ===============================
// BINDING: FORGOT PASSWORD
// ===============================

import 'package:get/get.dart';
import 'forgot_password_controller.dart';

// ===============================
// FORGOT PASSWORD BINDING
// ===============================

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}
