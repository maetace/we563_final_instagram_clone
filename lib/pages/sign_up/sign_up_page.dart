import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_up_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Form(
        key: controller.signUpFormKey,
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: SingleChildScrollView(
            // รองรับ scroll
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/twitter_logo.png',
                  width: 48,
                  height: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 48),

                // Full Name
                TextFormField(
                  key: controller.fullNameKey,
                  validator: controller.fullNameValidator,
                  controller: controller.fullNameController,
                  onChanged: controller.onFullNameChanged,
                  decoration: _inputDecoration('Full Name'),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),

                // Email
                TextFormField(
                  key: controller.emailKey,
                  validator: controller.emailValidator,
                  controller: controller.emailController,
                  onChanged: controller.onEmailChanged,
                  decoration: _inputDecoration('Email'),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),

                // Username
                TextFormField(
                  key: controller.usernameKey,
                  validator: controller.usernameValidator,
                  controller: controller.usernameController,
                  onChanged: controller.onUsernameChanged,
                  decoration: _inputDecoration('Username'),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),

                // Password
                Obx(
                  () => TextFormField(
                    key: controller.passwordKey,
                    validator: controller.passwordValidator,
                    onChanged: controller.onPasswordChanged,
                    controller: controller.passwordController,
                    decoration: _inputDecoration('Password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: !controller.isPasswordVisible.value,
                  ),
                ),
                const SizedBox(height: 48),

                // Sign Up Button
                Obx(
                  () => Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              controller.isLoading.value
                                  ? null
                                  : controller.onSignUpPressed,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            elevation: 0,
                            side: BorderSide(color: Colors.blue.shade200),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.blue,
                                    ),
                                  )
                                  : const Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: controller.onBackPressed,
        icon: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }
}
