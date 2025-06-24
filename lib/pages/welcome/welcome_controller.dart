// lib/pages/welcome/welcome_controller.dart

// ===============================
// CONTROLLER: WELCOME
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/configs.dart';
import '/routes.dart';

import '/models/account_model.dart';
import '/services/account_service.dart';

// ===============================
// WELCOME CONTROLLER
// ===============================

class WelcomeController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  final Logger _logger = Logger();

  // ===============================
  // USER DATA
  // ===============================

  final userRxn = Rxn<CurrentAccount>();

  // ===============================
  // LOADING STATES
  // ===============================

  final _isLogInLoading = false.obs;
  final _isSignUpLoading = false.obs;
  final _isSwitchAccountLoading = false.obs;

  bool get isLogInLoading => _isLogInLoading.value;
  bool get isSignUpLoading => _isSignUpLoading.value;
  bool get isSwitchAccountLoading => _isSwitchAccountLoading.value;
  bool get isLoading => isLogInLoading || isSignUpLoading || isSwitchAccountLoading;

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
    loadCurrentUser();
  }

  // ===============================
  // LOAD CURRENT USER
  // ===============================

  Future<void> loadCurrentUser() async {
    final currentAccount = await _account.getCurrentAccount();

    if (currentAccount != null) {
      userRxn.value = currentAccount;
      _logger.i('👤 Found current account: ${currentAccount.username}');
    } else {
      _logger.w('⚠️ No account in session. Redirecting to Login...');
      Get.offAllNamed(AppRoutes.login);
    }
  }

  // ===============================
  // ACTION: LOGIN
  // ===============================

  Future<void> onLogInPressed() async {
    if (_isLogInLoading.value) return;

    try {
      _isLogInLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      if (userRxn.value != null) {
        _logger.i('✅ Current account exists → navigating to Home');
        Get.offAllNamed(AppRoutes.home);
      } else {
        _logger.w('❌ No account found → navigating to Login');
        Get.offAllNamed(AppRoutes.login);
      }
    } finally {
      _isLogInLoading.value = false;
    }
  }

  // ===============================
  // ACTION: SIGN UP
  // ===============================

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
  // ACTION: SWITCH ACCOUNT
  // ===============================

  Future<void> onSwitchAccountPressed() async {
    if (_isSwitchAccountLoading.value) return;

    try {
      _isSwitchAccountLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      Get.toNamed(AppRoutes.login);
    } finally {
      _isSwitchAccountLoading.value = false;
    }
  }
}
