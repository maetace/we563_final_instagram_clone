import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();

  final fullNameKey = GlobalKey<FormFieldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void onBackPressed() {
    Get.back();
  }

  Future<void> onSignUpPressed() async {
    if (isLoading.value) return;

    if (!signUpFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    // จำลอง call service (รอเชื่อม API)
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    Get.snackbar(
      'Sign Up Successful',
      'Welcome! We\'re excited to have you join us. 🎉',
      colorText: Colors.white,
      backgroundColor: Colors.green.shade400,
    );

    Get.offAllNamed('/home');
  }

  // Validators
  String? fullNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length > 250) {
      return 'Full name cannot exceed 250 characters';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return !emailRegex.hasMatch(value) ? 'Enter a valid email address' : null;
  }

  String? usernameValidator(String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9]{3,100}$');
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your username';
    }
    if (!regex.hasMatch(value)) {
      return 'Username must be 3–100 characters, letters/numbers only';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must include:\n• At least 8 characters\n• At least one letter\n• One number\n• One special character';
    }
    return null;
  }

  // OnChange callbacks
  void onFullNameChanged(String value) {
    fullNameKey.currentState?.validate();
  }

  void onEmailChanged(String value) {
    emailKey.currentState?.validate();
  }

  void onUsernameChanged(String value) {
    usernameKey.currentState?.validate();
  }

  void onPasswordChanged(String value) {
    passwordKey.currentState?.validate();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
