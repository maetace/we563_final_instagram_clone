import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  // Form Keys
  final logInFormKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  // Navigation
  void onBackPressed() {
    Get.back();
  }

  void onLogInPressed() async {
    if (!logInFormKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1)); // simulate delay

    final username = usernameController.text;
    final password = passwordController.text;

    if (username != '@userdemo') {
      isLoading.value = false;
      Get.snackbar(
        'Login Failed',
        'The username you entered does not exist. Please check and try again.',
        colorText: Colors.white,
        backgroundColor: Colors.red.shade400,
      );
      return;
    }

    if (password != '1q2w3e4r') {
      isLoading.value = false;
      Get.snackbar(
        'Login Failed',
        'Incorrect username or password. Please try again.',
        colorText: Colors.white,
        backgroundColor: Colors.red.shade400,
      );
      return;
    }

    isLoading.value = false;
    Get.snackbar(
      'Log In Successful',
      'Welcome back, Demo User! 👋',
      colorText: Colors.white,
      backgroundColor: Colors.green.shade400,
    );
    Get.offAllNamed('/home');
  }

  // Username
  void onUsernameChanged(String value) {
    usernameKey.currentState?.validate();
  }

  String? usernameVlaidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    if (!value.startsWith('@')) {
      return 'Username must start with @';
    }
    return null;
  }

  // Password
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void onPasswordChanged(String value) {
    passwordKey.currentState?.validate();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
