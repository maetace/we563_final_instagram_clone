// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: const [LanguageSwitcher(), ThemeSwitcher()],
        actionsPadding: const EdgeInsets.only(right: 8),
      ),
      body: SafeArea(
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

                // Fullname
                Text(user.fullname, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                // Welcome message
                Text(
                  'welcome_back'.trParams({'user': user.fullname}),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
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
    );
  }
}
