// lib/pages/forgot_password/forgot_password_controller.dart

// ===============================
// CONTROLLER: FORGOT PASSWORD
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/services/account_service.dart';
import '/configs.dart';

// ===============================
// FORGOT PASSWORD CONTROLLER
// ===============================

class ForgotPasswordController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // ===============================
  // FORM KEYS
  // ===============================

  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();

  // ===============================
  // TEXT CONTROLLER / FOCUS
  // ===============================

  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final isUsernameFocused = false.obs;
  final usernameText = ''.obs;

  // ===============================
  // LOADING STATE
  // ===============================

  final _isForgotPasswordLoading = false.obs;
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;
  bool get isLoading => isForgotPasswordLoading;

  // ===============================
  // SERVICE
  // ===============================

  late final AccountService _account;

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
  }

  // ===============================
  // CLEANUP
  // ===============================

  @override
  void onClose() {
    usernameController.dispose();
    usernameFocusNode.dispose();
    super.onClose();
  }

  // ===============================
  // INPUT CALLBACK
  // ===============================

  void onUsernameChanged(String value) {
    usernameText.value = value;
  }

  // ===============================
  // VALIDATOR
  // ===============================

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_username'.tr;
    if (value.length < 3) return 'username_min'.tr;
    return null;
  }

  // ===============================
  // NAVIGATION
  // ===============================

  void onBackPressed() => Get.back();

  // ===============================
  // ACTION: FORGOT PASSWORD
  // ===============================

  Future<void> onForgotPasswordPressed() async {
    if (!formKey.currentState!.validate() || isForgotPasswordLoading) return;

    try {
      _isForgotPasswordLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      final account = await _account.findAccountByUsername(usernameController.text.trim());

      if (account != null) {
        Get.snackbar(
          'reset_password_sent'.tr,
          'reset_password_sent_desc'.tr,
          colorText: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw 'user_not_found'.tr;
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        e.toString(),
        colorText: colorScheme.onError,
        backgroundColor: colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isForgotPasswordLoading.value = false;
    }
  }
}
