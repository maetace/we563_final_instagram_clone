// lib/pages/login/login_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

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
                actions: const [LanguageSwitcher(), ThemeSwitcher()],
                actionsPadding: const EdgeInsets.only(right: 8),
              ),
              body: SafeArea(
                child: AppPageContainer(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 48),
                                    Image.asset('assets/images/instagram_icon.png', height: 72),
                                    const SizedBox(height: 96),
                                    // Username
                                    Obx(
                                      () => TextFormField(
                                        key: controller.usernameKey,
                                        controller: controller.usernameController,
                                        focusNode: controller.usernameFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          controller.passwordFocusNode.requestFocus();
                                        },
                                        onChanged: controller.onUsernameChanged,
                                        validator: controller.usernameValidator,
                                        decoration: InputDecoration(
                                          labelText: 'username'.tr,
                                          suffixIcon:
                                              (controller.isUsernameFocused.value &&
                                                      controller.usernameText.value.isNotEmpty)
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
                                    const SizedBox(height: 16),
                                    // Password
                                    Obx(
                                      () => TextFormField(
                                        key: controller.passwordKey,
                                        controller: controller.passwordController,
                                        focusNode: controller.passwordFocusNode,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) {
                                          controller.onLogInPressed();
                                        },
                                        onChanged: controller.onPasswordChanged,
                                        validator: controller.passwordValidator,
                                        obscureText: !controller.isPasswordVisible.value,
                                        decoration: InputDecoration(
                                          labelText: 'password'.tr,
                                          suffixIcon:
                                              (controller.isPasswordFocused.value ||
                                                      controller.passwordText.value.isNotEmpty)
                                                  ? IconButton(
                                                    icon: Icon(
                                                      controller.isPasswordVisible.value
                                                          ? Icons.visibility_outlined
                                                          : Icons.visibility_off_outlined,
                                                    ),
                                                    onPressed: controller.togglePasswordVisibility,
                                                  )
                                                  : null,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Log In Button
                                    LoadingButton(
                                      onPressed: controller.onLogInPressed,
                                      isLoading: controller.isLogInLoading,
                                      label: 'login'.tr,
                                      type: ButtonType.elevated,
                                    ),
                                    const SizedBox(height: 8),
                                    // Forgot Password Button
                                    Obx(
                                      () => LoadingButton(
                                        onPressed: controller.onForgotPassword,
                                        isLoading: controller.isForgotPasswordLoading,
                                        label: 'forgot_password'.tr,
                                        type: ButtonType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Bottom Section
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
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
                                Image.asset('assets/images/meta_logo.png', height: 16),
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
          ),
        ],
      ),
    );
  }
}
