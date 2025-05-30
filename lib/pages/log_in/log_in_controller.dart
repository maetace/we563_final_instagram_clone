import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/routes.dart';
import '/config/app_config.dart';
import '/account_mock.dart';

class LogInController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Form Keys
  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Focus Nodes
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // Focused
  final isUsernameFocused = false.obs;
  final isPasswordFocused = false.obs;

  // Text Observables
  final usernameText = ''.obs;
  final passwordText = ''.obs;

  void onUsernameChanged(String value) => usernameText.value = value;
  void onPasswordChanged(String value) => passwordText.value = value;

  // Visibility Toggle
  final isPasswordVisible = false.obs;
  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  // Validators
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your username';
    if (value.length < 3) return 'Username must be at least 3 characters long.';
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 8) return 'Password must be at least 8 characters long.';
    return null;
  }

  // Navigation
  void onBackPressed() => Get.back();

  // Forgot Password
  final _isForgotPasswordLoading = false.obs;
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;

  Future<void> onForgotPassword() async {
    if (_isForgotPasswordLoading.value) return;
    try {
      _isForgotPasswordLoading.value = true;
      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);
      Get.toNamed(AppRoutes.forgot);
    } finally {
      _isForgotPasswordLoading.value = false;
    }
  }

  // Sign Up
  final _isSignUpLoading = false.obs;
  bool get isSignUpLoading => _isSignUpLoading.value;

  Future<void> onSignUpPressed() async {
    if (_isSignUpLoading.value) return;
    try {
      _isSignUpLoading.value = true;
      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);
      Get.toNamed(AppRoutes.signup);
    } finally {
      _isSignUpLoading.value = false;
    }
  }

  // Log In
  final _isLogInLoading = false.obs;
  bool get isLogInLoading => _isLogInLoading.value;

  late final AccountService _account;

  Future<void> onLogInPressed() async {
    if (!formKey.currentState!.validate() || _isLogInLoading.value) return;

    try {
      _isLogInLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      await _account.logIn(usernameController.text.trim(), passwordController.text);

      final user = await _account.getCurrentUser();

      if (user != null) {
        Get.snackbar(
          'Log In Successful',
          'Welcome back, ${user.fullname}! 👋',
          colorText: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(AppRoutes.home);
      } else {
        throw 'User not found after login';
      }
    } catch (e) {
      Get.snackbar(
        'Log In Failed',
        e.toString(),
        colorText: colorScheme.onError,
        backgroundColor: colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLogInLoading.value = false;
    }
  }

  bool get isLoading => isLogInLoading || isSignUpLoading || isForgotPasswordLoading;

  @override
  void onInit() {
    super.onInit();
    _account = Get.find();

    usernameFocusNode.addListener(() {
      isUsernameFocused.value = usernameFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      isPasswordFocused.value = passwordFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
