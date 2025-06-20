// lib/pages/welcome_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/configs.dart';
import '/data.dart';
import '/widgets.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => Stack(
        children: [
          AbsorbPointer(
            absorbing: controller.isLoading,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: theme.colorScheme.surface,
                actions: const [LanguageSwitcher()],
                actionsPadding: const EdgeInsets.only(right: 8),
              ),
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        // Upper scrollable section
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 24),

                                  // Instagram logo
                                  Image.asset('assets/images/instagram_icon.png', height: 48),

                                  const SizedBox(height: 48),

                                  // Avatar & Username block
                                  Obx(() {
                                    final user = controller.userRxn.value;

                                    if (user == null) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 176,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 88,
                                                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 88,
                                                    color: theme.colorScheme.onSurface,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                  child: CircularProgressIndicator(strokeWidth: 2),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          Text(
                                            'loading_profile'.tr,
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: theme.colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      );
                                    }

                                    return Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 88,
                                          foregroundImage:
                                              user.avatar.startsWith('http')
                                                  ? NetworkImage(user.avatar)
                                                  : AssetImage(user.avatar) as ImageProvider,
                                        ),
                                        const SizedBox(height: 24),
                                        Text(user.username, style: theme.textTheme.titleLarge),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.circle, size: 8, color: theme.colorScheme.error),
                                            const SizedBox(width: 4),
                                            Text(
                                              'new_notifications'.tr,
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                color: theme.colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),

                                  const SizedBox(height: 24),

                                  // Continue button
                                  LoadingButton(
                                    onPressed: controller.onLogInPressed,
                                    isLoading: controller.isLogInLoading,
                                    label: 'continue'.tr,
                                    type: ButtonType.elevated,
                                  ),

                                  const SizedBox(height: 8),

                                  // Switch account
                                  LoadingButton(
                                    onPressed: controller.onSwitchAccountPressed,
                                    isLoading: controller.isSwitchAccountLoading,
                                    label: 'use_another_profile'.tr,
                                    type: ButtonType.text,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Bottom section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                          child: Column(
                            children: [
                              Obx(
                                () => LoadingButton(
                                  onPressed: controller.onSignUpPressed,
                                  isLoading: controller.isSignUpLoading,
                                  label: 'create_new_account'.tr,
                                  type: ButtonType.outlined,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Image.asset('assets/images/meta_logo_mono.png', height: 12),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==== CONTROLLER ====
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

// ==== BINDING ====
class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
