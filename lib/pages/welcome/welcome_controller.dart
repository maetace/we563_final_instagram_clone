// lib/pages/welcome/welcome_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:logger/logger.dart';

import '/configs.dart';
import '/data.dart';
import '/routes.dart';

class WelcomeController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  final Logger _logger = Logger();

  // User data
  final userRxn = Rxn<CurrentUser>();

  // Loading states
  final _isLogInLoading = false.obs;
  final _isSignUpLoading = false.obs;
  final _isSwitchAccountLoading = false.obs;

  bool get isLogInLoading => _isLogInLoading.value;
  bool get isSignUpLoading => _isSignUpLoading.value;
  bool get isSwitchAccountLoading => _isSwitchAccountLoading.value;
  bool get isLoading => isLogInLoading || isSignUpLoading || isSwitchAccountLoading;

  late final AccountService _account;

  @override
  void onInit() {
    super.onInit();
    _account = Get.find();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    final currentUser = await _account.getCurrentUser();

    if (currentUser != null) {
      userRxn.value = currentUser;
      _logger.i('👤 Found current user: ${currentUser.username}');
    } else {
      _logger.w('⚠️ No user in session. Redirecting to Login...');
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> onLogInPressed() async {
    if (_isLogInLoading.value) return;
    try {
      _isLogInLoading.value = true;

      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);

      if (userRxn.value != null) {
        _logger.i('✅ Current user exists → navigating to Home');
        Get.offAllNamed(AppRoutes.home);
      } else {
        _logger.w('❌ No user found → navigating to Login');
        Get.offAllNamed(AppRoutes.login);
      }
    } finally {
      _isLogInLoading.value = false;
    }
  }

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

  Future<void> onSwitchAccountPressed() async {
    if (_isSwitchAccountLoading.value) return;
    try {
      _isSwitchAccountLoading.value = true;
      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);
      Get.toNamed(AppRoutes.login);
    } finally {
      _isSwitchAccountLoading.value = false;
    }
  }
}
