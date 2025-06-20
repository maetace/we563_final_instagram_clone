// lib/pages/home_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/configs.dart';
import '/data.dart';
import '/widgets.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Obx(() {
          final user = controller.userRxn.value;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final avatar = controller.userRxn.value?.avatar ?? '';
          final hasAvatar = avatar.isNotEmpty;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 92,
                foregroundImage: hasAvatar ? (AssetImage(avatar) as ImageProvider) : null,
                child: hasAvatar ? null : const Icon(Icons.person_2_outlined, size: 184),
              ),
              const SizedBox(height: 12),

              // Fullname
              Text(avatar, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Welcome message
              Text(
                'Welcome back, ${user.fullname}! 🎉',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: LoadingButton(
                      onPressed: controller.onWelcomePressed,
                      isLoading: controller.isLogOutLoading,
                      label: 'Welcome',
                      type: ButtonType.elevated,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: LoadingButton(
                      onPressed: controller.onLogOutPressed,
                      isLoading: controller.isLogOutLoading,
                      label: 'Log Out',
                      type: ButtonType.elevated,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ==== CONTROLLER ===
class HomeController extends GetxController {
  final userRxn = Rxn<CurrentUser>();
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
    final currentUser = await _account.getCurrentUser();
    if (currentUser != null) {
      userRxn.value = currentUser;
      _logger.i('🏠 User loaded: ${currentUser.fullname}');
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
                await _account.logOut(); // ✅ ใช้ service โดยตรง
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

// ==== BINDING ====
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
