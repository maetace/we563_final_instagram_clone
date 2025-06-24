// lib/pages/signup/signup_binding.dart

// ===============================
// BINDING: SIGN UP
// ===============================

import 'package:get/get.dart';
import 'signup_controller.dart';

// ===============================
// SIGNUP BINDING
// ===============================

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}
