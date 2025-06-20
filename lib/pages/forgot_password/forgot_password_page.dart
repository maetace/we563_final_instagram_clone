// lib/pages/forgot_password/forgot_password_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          AbsorbPointer(
            absorbing: controller.isLoading,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: controller.onBackPressed,
                ),
                title: Text('forgot_password'.tr),
                actions: const [LanguageSwitcher(), ThemeSwitcher()],
                actionsPadding: const EdgeInsets.only(right: 8),
              ),
              body: SafeArea(
                child: AppPageContainer(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 48),
                        Text('find_account'.tr, style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 12),
                        Text('forgot_password_hint'.tr, style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 24),

                        // Username Input
                        Obx(
                          () => TextFormField(
                            key: controller.usernameKey,
                            controller: controller.usernameController,
                            focusNode: controller.usernameFocusNode,
                            textInputAction: TextInputAction.done,
                            onChanged: controller.onUsernameChanged,
                            validator: controller.usernameValidator,
                            decoration: InputDecoration(
                              labelText: 'email_or_username'.tr,
                              suffixIcon:
                                  controller.isUsernameFocused.value && controller.usernameText.value.isNotEmpty
                                      ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          controller.usernameController.clear();
                                          controller.usernameText.value = '';
                                        },
                                      )
                                      : null,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Continue Button
                        Obx(
                          () => LoadingButton(
                            onPressed: controller.onForgotPasswordPressed,
                            isLoading: controller.isForgotPasswordLoading,
                            label: 'continue'.tr,
                            type: ButtonType.elevated,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
