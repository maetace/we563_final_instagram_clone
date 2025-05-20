import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

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

  // Navigation Back
  void onBackPressed() {
    Get.back();
  }

  // Sign Up Button
  void onSignUpPressed() {
    Get.toNamed(AppRoutes.signup);
  }

  // Forgot Password Button
  void onForgotPassword() {
    Get.toNamed(AppRoutes.forgot);
  }

  // Log In Button
  void onLogInPressed() async {
    if (!logInFormKey.currentState!.validate()) return;

    void showError(String title, String message) {
      final colorScheme = Theme.of(Get.context!).colorScheme;
      Get.snackbar(
        title,
        message,
        colorText: colorScheme.onError,
        backgroundColor: colorScheme.error,
      );
    }

    void showSuccess(String title, String message) {
      final colorScheme = Theme.of(Get.context!).colorScheme;
      Get.snackbar(
        title,
        message,
        colorText: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
      );
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1)); // simulate delay

    final username = usernameController.text;
    final password = passwordController.text;

    if (username != 'we563dpu') {
      isLoading.value = false;
      showError(
        'Login Failed',
        'The username you entered does not exist. Please check and try again.',
      );
      return;
    }

    if (password != 'Qweqwe!2') {
      isLoading.value = false;
      showError(
        'Login Failed',
        'Incorrect username or password. Please try again.',
      );
      return;
    }

    isLoading.value = false;
    showSuccess('Log In Successful', 'Welcome back, Demo User! 👋');
    Get.offAllNamed('/home');
  }

  // Username
  void onUsernameChanged(String value) {
    usernameKey.currentState?.validate();
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
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
