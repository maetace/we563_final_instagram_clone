import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'log_in_controller.dart';
import '../../widgets/loading_button_widget.dart';

class LogInPage extends GetView<LogInController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          AbsorbPointer(
            absorbing: controller.isLoading,
            child: Scaffold(
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
                                          labelText: 'Username',
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
                                          labelText: 'Password',
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
                                      label: 'Log In',
                                      type: ButtonType.elevated,
                                    ),

                                    const SizedBox(height: 8),

                                    // Forgot Password Button
                                    Obx(
                                      () => LoadingButton(
                                        onPressed: controller.onForgotPassword,
                                        isLoading: controller.isForgotPasswordLoading,
                                        label: 'Forgot password?',
                                        type: ButtonType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Bottom Section
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
                              Image.asset('assets/images/meta_logo_mono.png', height: 16),
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
