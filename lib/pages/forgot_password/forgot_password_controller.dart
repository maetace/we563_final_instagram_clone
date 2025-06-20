import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/configs.dart';

import '/data.dart';

class ForgotPasswordController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Form Keys
  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final isUsernameFocused = false.obs;
  final usernameText = ''.obs;

  final _isForgotPasswordLoading = false.obs;
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;
  bool get isLoading => isForgotPasswordLoading;

  // Service
  late final AccountService _account;

  @override
  void onInit() {
    super.onInit();
    _account = Get.find<AccountService>();

    usernameFocusNode.addListener(() {
      isUsernameFocused.value = usernameFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    usernameController.dispose();
    usernameFocusNode.dispose();
    super.onClose();
  }

  // Input Callback
  void onUsernameChanged(String value) {
    usernameText.value = value;
  }

  // Validator
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_username'.tr;
    if (value.length < 3) return 'username_min'.tr;
    return null;
  }

  // Navigation
  void onBackPressed() => Get.back();

  // Action
  Future<void> onForgotPasswordPressed() async {
    if (!formKey.currentState!.validate() || isForgotPasswordLoading) return;

    try {
      _isForgotPasswordLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      final user = await _account.findUserByUsername(usernameController.text.trim());

      if (user != null) {
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
