// lib/pages/signup/signup_page.dart

// ===============================
// PAGE: SIGN UP
// ===============================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets.dart';
import 'signup_controller.dart';

// ===============================
// SIGNUP PAGE
// ===============================

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          // Block touch when loading
          AbsorbPointer(
            absorbing: controller.isLoading,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Get.back()),
                actions: const [LanguageSwitcher(), ThemeSwitcher()],
                actionsPadding: const EdgeInsets.only(right: 8),
                title: Text('signup'.tr),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 32),

                                    // ===============================
                                    // AVATAR PICKER
                                    // ===============================
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

                                    // ===============================
                                    // USERNAME
                                    // ===============================
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

                                    // ===============================
                                    // PASSWORD
                                    // ===============================
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

                                    // ===============================
                                    // CONFIRM PASSWORD
                                    // ===============================
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
                                          labelText: 'confirm_password'.tr,
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

                                    // ===============================
                                    // SIGN UP BUTTON
                                    // ===============================
                                    Obx(
                                      () => LoadingButton(
                                        onPressed: controller.onSignUpPressed,
                                        isLoading: controller.isSignUpLoading,
                                        label: 'signup'.tr,
                                        type: ButtonType.elevated,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // ===============================
                          // BOTTOM SECTION
                          // ===============================
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Column(
                              children: [
                                Obx(
                                  () => LoadingButton(
                                    onPressed: () => Get.back(),
                                    isLoading: controller.isLogInLoading,
                                    label: 'find_account'.tr,
                                    type: ButtonType.text,
                                  ),
                                ),
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
