import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../services/account_service.dart';

class SignUpController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Username key
  final usernameKey = GlobalKey<FormFieldState>();
  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final isUsernameFocused = false.obs;
  final usernameText = ''.obs;

  // onChange callback
  void onUsernameChanged(String value) {
    usernameText.value = value;
    // usernameKey.currentState?.validate();
  }

  // Username Validator
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    }

    final errorMessage = <String>[];
    final hasLength = 3;
    final isValid = RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);

    if (value.length < hasLength) {
      errorMessage.add('Username must be at least $hasLength characters long.');
    }
    if (!isValid) {
      errorMessage.add('Username can only contain letters and numbers (no spaces or special characters).');
    }
    return errorMessage.isEmpty ? null : errorMessage.join('\n');
  }

  // Password key
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
      return 'Please enter a password.';
    }

    final errorMessage = <String>[];
    final hasLength = 8;
    final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));
    final hasSpecial = value.contains(RegExp(r'[@$!%*?&]'));
    final hasSpace = value.contains(RegExp(r'\s'));

    if (value.length < hasLength) {
      errorMessage.add('Password must be at least $hasLength characters long.');
    }
    if (hasSpace) {
      errorMessage.add('Password must not contain spaces or other whitespace characters.');
    }
    if (!hasSpecial) {
      errorMessage.add('Password must contain at least one special character (@\$!%*?&).');
    }
    if (!hasLetter) {
      errorMessage.add('Password must contain at least one letter (A–Z or a–z).');
    }
    if (!hasDigit) {
      errorMessage.add('Password must contain at least one digit (0–9).');
    }
    return errorMessage.isEmpty ? null : errorMessage.join('\n');
  }

  // Navigation Back
  void onBackPressed() {
    Get.back();
  }

  // Login Button
  void onLogInPressed() {
    Get.offNamed(AppRoutes.login);
  }

  // Sign Up Button
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  void onSignUpPressed() async {
    if (!formKey.currentState!.validate()) return;
    if (_isLoading.value) return;

    try {
      _isLoading.value = true;
      await _accountService.signUp(usernameController.text, passwordController.text, null, null, null, null);
      _isLoading.value = false;
      Get.snackbar(
        'Sign Up Successful',
        'Welcome! We\'re excited to have you join us. 🎉',
        backgroundColor: colorScheme.primaryContainer,
        colorText: colorScheme.onPrimaryContainer,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        '$e',
        backgroundColor: colorScheme.error,
        colorText: colorScheme.onError,
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
