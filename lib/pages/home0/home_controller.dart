// lib/pages/home/home_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/routes.dart';

import '/models/account_model.dart';
import '/services/account_service.dart';

class HomeController extends GetxController {
  final userRxn = Rxn<CurrentAccount>();
  final Logger _logger = Logger();

  final _isLogOutLoading = false.obs;
  bool get isLogOutLoading => _isLogOutLoading.value;

  late final AccountService _account;

  @override
  void onInit() {
    super.onInit();
    _account = Get.find();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    final currentAccount = await _account.getCurrentAccount();
    if (currentAccount != null) {
      userRxn.value = currentAccount;
      _logger.i('🏠 Account loaded: ${currentAccount.fullname}');
    } else {
      _logger.w('🏠 No session. Redirect to login.');
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void onWelcomePressed() {
    Get.offAllNamed(AppRoutes.welcome);
  }

  void onLogOutPressed() {
    if (Get.isBottomSheetOpen ?? false) return;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(32),
        color: Colors.white,
        child: Wrap(
          children: [
            Center(
              child: Text(
                'Are you sure you want to log out?',
                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 32),
            ListTile(leading: const Icon(Icons.close), title: const Text('No'), onTap: () => Get.back()),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Yes'),
              onTap: () async {
                Get.back();
                await _account.logOut();
                _logger.i('🔓 Logged out successfully');
                Get.snackbar(
                  'Log Out Successful',
                  'You\'ve been logged out. See you again soon! 👀',
                  colorText: Colors.white,
                  backgroundColor: Colors.green.shade400,
                );
                Get.offAllNamed(AppRoutes.welcome);
              },
            ),
          ],
        ),
      ),
    );
  }
}
