// lib/pages/login/login_controller.dart

// ===============================
// CONTROLLER: LOGIN
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/configs.dart';
import '/routes.dart';
import '/services/account_service.dart';

// ===============================
// LOGIN CONTROLLER
// ===============================

class LoginController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // ===============================
  // FORM KEYS
  // ===============================

  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  // ===============================
  // TEXT CONTROLLERS
  // ===============================

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // ===============================
  // FOCUS NODES
  // ===============================

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // ===============================
  // FOCUS OBSERVABLES
  // ===============================

  final isUsernameFocused = false.obs;
  final isPasswordFocused = false.obs;

  // ===============================
  // TEXT OBSERVABLES
  // ===============================

  final usernameText = ''.obs;
  final passwordText = ''.obs;

  void onUsernameChanged(String value) => usernameText.value = value;
  void onPasswordChanged(String value) => passwordText.value = value;

  // ===============================
  // PASSWORD VISIBILITY
  // ===============================

  final isPasswordVisible = false.obs;
  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  // ===============================
  // VALIDATORS
  // ===============================

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_username'.tr;
    if (value.length < 3) return 'username_min'.tr;
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_password'.tr;
    if (value.length < 8) return 'password_min'.tr;
    return null;
  }

  // ===============================
  // NAVIGATION
  // ===============================

  void onBackPressed() => Get.back();

  // ===============================
  // FORGOT PASSWORD
  // ===============================

  final _isForgotPasswordLoading = false.obs;
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;

  Future<void> onForgotPassword() async {
    if (_isForgotPasswordLoading.value) return;

    try {
      _isForgotPasswordLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      Get.toNamed(AppRoutes.forgot);
    } finally {
      _isForgotPasswordLoading.value = false;
    }
  }

  // ===============================
  // SIGN UP
  // ===============================

  final _isSignUpLoading = false.obs;
  bool get isSignUpLoading => _isSignUpLoading.value;

  Future<void> onSignUpPressed() async {
    if (_isSignUpLoading.value) return;

    try {
      _isSignUpLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      Get.toNamed(AppRoutes.signup);
    } finally {
      _isSignUpLoading.value = false;
    }
  }

  // ===============================
  // LOG IN
  // ===============================

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

      final account = await _account.getCurrentAccount();

      if (account != null) {
        Get.snackbar(
          'login_success'.tr,
          'welcome_back'.trParams({'user': account.fullname}),
          colorText: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAllNamed(AppRoutes.home);
      } else {
        throw 'user_not_found'.tr;
      }
    } catch (e) {
      Get.snackbar(
        'login_failed'.tr,
        e.toString(),
        colorText: colorScheme.onError,
        backgroundColor: colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLogInLoading.value = false;
    }
  }

  // ===============================
  // IS LOADING
  // ===============================

  bool get isLoading => isLogInLoading || isSignUpLoading || isForgotPasswordLoading;

  // ===============================
  // INIT
  // ===============================

  @override
  void onInit() {
    super.onInit();
    _account = Get.find<AccountService>();

    usernameFocusNode.addListener(() {
      isUsernameFocused.value = usernameFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      isPasswordFocused.value = passwordFocusNode.hasFocus;
    });
  }

  // ===============================
  // CLEANUP
  // ===============================

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
