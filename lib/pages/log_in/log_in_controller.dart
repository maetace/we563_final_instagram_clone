import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../services/account_service.dart';

class LogInController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Form Key
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

  // onChange callback
  final usernameText = ''.obs;
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

  // Visibility
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
  final _isSignUpLoading = false.obs;
  bool get isSignUpLoading => _isSignUpLoading.value;
  Future<void> onSignUpPressed() async {
    _isSignUpLoading.value = true;
    await 3.delay();
    _isSignUpLoading.value = false;
    Get.toNamed(AppRoutes.signup);
  }

  // Log In Button
  final _isLogInLoading = false.obs;
  bool get isLogInLoading => _isLogInLoading.value;
  Future<void> onLogInPressed() async {
    if (!formKey.currentState!.validate()) return;
    if (_isLogInLoading.value) return;
    try {
      _isLogInLoading.value = true;
      await _accountService.logIn(usernameController.text, passwordController.text);
      _isLogInLoading.value = false;
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
      _isLogInLoading.value = false;
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
