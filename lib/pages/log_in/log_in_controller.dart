import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../services/account_service.dart';

class LogInController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Username key
  final usernameKey = GlobalKey<FormFieldState>();
  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final isUsernameFocused = false.obs;
  final usernameText = ''.obs;

  // Username Validator
  void onUsernameChanged(String value) {
    usernameText.value = value;
    // usernameKey.currentState?.validate();
  }

  // Username Validator
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }

    final errorMessage = <String>[];
    final hasLength = 3;

    if (value.length < hasLength) {
      errorMessage.add('Username must be at least $hasLength characters long.');
    }
    return errorMessage.isEmpty ? null : errorMessage.join('\n');
  }

  // Password Key
  final passwordKey = GlobalKey<FormFieldState>();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final isPasswordFocused = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // onChange callback
  void onPasswordChanged(String value) {
    // passwordKey.currentState?.validate();
  }

  // Password Validator
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    final errorMessage = <String>[];
    final hasLength = 6;

    if (value.length < hasLength) {
      errorMessage.add('Password must be at least $hasLength characters long.');
    }
    return errorMessage.isEmpty ? null : errorMessage.join('\n');
  }

  // Navigation Back
  void onBackPressed() {
    Get.back();
  }

  // Forgot Password Button
  void onForgotPassword() {
    Get.toNamed(AppRoutes.forgot);
  }

  // Sign Up Button
  void onSignUpPressed() {
    Get.toNamed(AppRoutes.signup);
  }

  // Log In Button
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  Future<void> onLogInPressed() async {
    if (!formKey.currentState!.validate()) return;
    if (_isLoading.value) return;

    try {
      _isLoading.value = true;
      await _accountService.logIn(usernameController.text, passwordController.text);
      _isLoading.value = false;
      Get.snackbar(
        'Log In Successful',
        'Welcome back, Demo User! 👋',
        colorText: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Log In Failed',
        '$e',
        colorText: colorScheme.onError,
        backgroundColor: colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // Initialize
  late AccountService _accountService;
  @override
  void onInit() {
    _accountService = Get.find<AccountService>();
    super.onInit();
    usernameFocusNode.addListener(() {
      isUsernameFocused.value = usernameFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      isPasswordFocused.value = passwordFocusNode.hasFocus;
    });
  }

  // Dispose
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
