// lib/pages/home/widgets/profile_tab.dart

// ===============================
// WIDGET: PROFILE TAB
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/pages/home/home_controller.dart';
import '/widgets.dart';

// ===============================
// PROFILE TAB
// ===============================

class ProfileTab extends GetView<HomeController> {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // ===============================
        // APP BAR
        // ===============================
        AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          titleSpacing: 16,
          title: Text('profile'.tr, style: theme.textTheme.titleLarge),
          actions: const [LanguageSwitcher(), ThemeSwitcher()],
          actionsPadding: const EdgeInsets.only(right: 8),
        ),

        // ===============================
        // PROFILE INFO
        // ===============================
        Expanded(
          child: AppPageContainer(
            child: Obx(() {
              final user = controller.userRxn.value;

              if (user == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final avatar = user.avatar;
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
                  Text(user.fullname, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    'welcome_back'.trParams({'user': user.fullname}),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // ===============================
                  // ACTION BUTTONS
                  // ===============================
                  Row(
                    children: [
                      Expanded(
                        child: LoadingButton(
                          onPressed: controller.onWelcomePressed,
                          isLoading: false,
                          label: 'welcome'.tr,
                          type: ButtonType.elevated,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LoadingButton(
                          onPressed: controller.onLogOutPressed,
                          isLoading: controller.isLogOutLoading,
                          label: 'logout'.tr,
                          type: ButtonType.elevated,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
