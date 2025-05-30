import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'welcome_controller.dart';
import '../../widgets/loading_button_widget.dart';

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
                actions: [IconButton(icon: const Icon(Icons.more_horiz_rounded), onPressed: () {})],
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
                                            'Loading profile...',
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
                                              'New notifications',
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
                                    label: 'Continue',
                                    type: ButtonType.elevated,
                                  ),

                                  const SizedBox(height: 8),

                                  // Switch account
                                  LoadingButton(
                                    onPressed: controller.onSwitchAccountPressed,
                                    isLoading: controller.isSwitchAccountLoading,
                                    label: 'Use another profile',
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
                                  label: 'Create new account',
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
