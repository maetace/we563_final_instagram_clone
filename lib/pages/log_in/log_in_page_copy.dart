import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'log_in_controller.dart';

class LogInPage extends GetView<LogInController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),

                            Image.asset('assets/images/instagram_icon.png', height: 72),

                            const SizedBox(height: 96),

                            // Username
                            Obx(
                              () => TextFormField(
                                key: controller.usernameKey,
                                controller: controller.usernameController,
                                focusNode: controller.usernameFocusNode,
                                onChanged: controller.onUsernameChanged,
                                validator: controller.usernameValidator,
                                enabled: !controller.isLogInLoading,
                                decoration: InputDecoration(
                                  labelText: 'Username, email or mobile number',
                                  suffixIcon:
                                      (controller.isUsernameFocused.value && controller.usernameText.value.isNotEmpty)
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
                                onChanged: controller.onPasswordChanged,
                                validator: controller.passwordValidator,
                                obscureText: !controller.isPasswordVisible.value,
                                enabled: !controller.isLogInLoading,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon:
                                      (controller.isPasswordFocused.value ||
                                              controller.passwordController.text.length > 1)
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
                            Obx(
                              () => Stack(
                                alignment: Alignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: controller.isLogInLoading ? null : controller.onLogInPressed,
                                    child: const Center(child: Text('Log In')),
                                  ),
                                  if (controller.isLogInLoading)
                                    const Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Forgot Password Button
                            TextButton(onPressed: controller.onForgotPassword, child: const Text('Forgot password?')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom fixed section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                  child: Column(
                    children: [
                      Obx(
                        () => OutlinedButton(
                          onPressed: controller.isLogInLoading ? null : controller.onSignUpPressed,
                          child: const Center(child: Text('Create new account')),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Image.asset('assets/images/meta_logo_mono.png', height: 16),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
