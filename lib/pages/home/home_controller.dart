import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../services/account_service.dart';

class HomeController extends GetxController {
  final AccountService _accountService = Get.find();

  void onWelcomePressed() {
    Get.offAllNamed(AppRoutes.welcome);
  }

  void onLogoutPressed() {
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
                Get.back(); // ปิด bottom sheet ก่อน
                await _accountService.logOut();
                Get.snackbar(
                  'Log Out Successful',
                  'You\'ve been logged out. See you again soon, Demo User! 👀',
                  colorText: Colors.white,
                  backgroundColor: Colors.green.shade400,
                );
                await 3.delay();
                Get.offAllNamed(AppRoutes.welcome);
              },
            ),
          ],
        ),
      ),
    );
  }
}
