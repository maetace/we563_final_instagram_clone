import 'package:flutter/foundation.dart'; // สำหรับ kIsWeb
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_up_controller.dart';
import '../../widgets/loading_button_widget.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

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
                leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Get.back()),
              ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 0),

                                    // ✅ Avatar Picker
                                    GestureDetector(
                                      onTap: controller.pickAvatar,
                                      child: Obx(
                                        () => CircleAvatar(
                                          radius: 86,
                                          backgroundColor: Theme.of(context).colorScheme.outlineVariant,
                                          backgroundImage:
                                              kIsWeb
                                                  ? (controller.avatarBytes.value != null
                                                      ? MemoryImage(controller.avatarBytes.value!)
                                                      : null)
                                                  : (controller.avatarFile.value != null
                                                      ? FileImage(controller.avatarFile.value!)
                                                      : null),
                                          child:
                                              (controller.avatarFile.value == null &&
                                                      controller.avatarBytes.value == null)
                                                  ? Icon(
                                                    Icons.person_rounded,
                                                    size: 172,
                                                    color: Theme.of(context).colorScheme.outline,
                                                  )
                                                  : null,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    // Username
                                    Obx(
                                      () => TextFormField(
                                        key: controller.usernameKey,
                                        controller: controller.usernameController,
                                        focusNode: controller.usernameFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) => controller.passwordFocusNode.requestFocus(),
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
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) => controller.passwordConfirmFocusNode.requestFocus(),
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

                                    // Confirm Password
                                    Obx(
                                      () => TextFormField(
                                        key: controller.passwordConfirmKey,
                                        controller: controller.passwordConfirmController,
                                        focusNode: controller.passwordConfirmFocusNode,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) => controller.onSignUpPressed(),
                                        onChanged: controller.onPasswordConfirmChanged,
                                        validator: controller.passwordConfirmValidator,
                                        obscureText: !controller.isPasswordConfirmVisible.value,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          suffixIcon:
                                              (controller.isPasswordConfirmFocused.value ||
                                                      controller.passwordConfirmText.value.isNotEmpty)
                                                  ? IconButton(
                                                    icon: Icon(
                                                      controller.isPasswordConfirmVisible.value
                                                          ? Icons.visibility_outlined
                                                          : Icons.visibility_off_outlined,
                                                    ),
                                                    onPressed: controller.togglePasswordConfirmVisibility,
                                                  )
                                                  : null,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    // Sign Up Button
                                    Obx(
                                      () => LoadingButton(
                                        onPressed: controller.onSignUpPressed,
                                        isLoading: controller.isSignUpLoading,
                                        label: 'Sign Up',
                                        type: ButtonType.elevated,
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
                                  // onPressed: controller.onLogInPressed,
                                  onPressed: () => Get.back(),
                                  isLoading: controller.isLogInLoading,
                                  label: 'Find my account',
                                  type: ButtonType.text,
                                ),
                              ),
                              // const SizedBox(height: 24),
                              // Image.asset('assets/images/meta_logo_mono.png', height: 16),
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
