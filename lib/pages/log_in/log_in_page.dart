import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'log_in_controller.dart';

class LogInPage extends GetView<LogInController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const BackButton(),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Form(
                        key: controller.logInFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),
                            Image.asset(
                              'assets/images/instagram_icon.png',
                              height: 72,
                            ),
                            const SizedBox(height: 96),

                            // Username
                            TextFormField(
                              key: controller.usernameKey,
                              controller: controller.usernameController,
                              onChanged: controller.onUsernameChanged,
                              validator: controller.usernameValidator,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Username, email or mobile number',
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Password
                            Obx(
                              () => TextFormField(
                                key: controller.passwordKey,
                                controller: controller.passwordController,
                                onChanged: controller.onPasswordChanged,
                                validator: controller.passwordValidator,
                                obscureText:
                                    !controller.isPasswordVisible.value,
                                enableSuggestions: false,
                                autocorrect: false,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted:
                                    (_) => controller.onLogInPressed(),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Log In Button
                            ElevatedButton(
                              onPressed: controller.onLogInPressed,
                              child: const Center(child: Text('Log In')),
                            ),
                            const SizedBox(height: 8),

                            // Forgot Password Button
                            TextButton(
                              onPressed: controller.onForgotPassword,
                              child: const Text('Forgot password?'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom fixed section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      OutlinedButton(
                        onPressed: controller.onSignUpPressed,
                        child: const Center(child: Text('Create new account')),
                      ),
                      const SizedBox(height: 24),
                      Image.asset(
                        'assets/images/meta_logo_mono.png',
                        height: 16,
                      ),
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
