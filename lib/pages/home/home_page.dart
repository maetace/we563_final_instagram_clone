import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import '../../widgets/loading_button_widget.dart';

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
