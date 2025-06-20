// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/configs.dart';
import '/data.dart';
import '/widgets.dart';

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
                actions: const [LanguageSwitcher()],
                actionsPadding: const EdgeInsets.only(right: 8),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 48),
                                    Image.asset('assets/images/instagram_icon.png', height: 72),
                                    const SizedBox(height: 96),

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
                                  label: 'create_new_account'.tr,
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

// ... Controller ไม่ต้องเปลี่ยน

// ==== CONTROLLER ====
class LoginController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Form Keys
  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Focus Nodes
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // Focused
  final isUsernameFocused = false.obs;
  final isPasswordFocused = false.obs;

  // Text Observables
  final usernameText = ''.obs;
  final passwordText = ''.obs;

  void onUsernameChanged(String value) => usernameText.value = value;
  void onPasswordChanged(String value) => passwordText.value = value;

  // Visibility Toggle
  final isPasswordVisible = false.obs;
  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  // Validators
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_username'.tr;
    if (value.length < 3) return 'username_min'.tr;
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_password'.tr;
    if (value.length < 8) return 'password_min'.tr;
    return null;
  }

  // Navigation
  void onBackPressed() => Get.back();

  // Forgot Password
  final _isForgotPasswordLoading = false.obs;
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;

  Future<void> onForgotPassword() async {
    if (_isForgotPasswordLoading.value) return;
    try {
      _isForgotPasswordLoading.value = true;
      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);
      Get.toNamed(AppRoutes.forgot);
    } finally {
      _isForgotPasswordLoading.value = false;
    }
  }

  // Sign Up
  final _isSignUpLoading = false.obs;
  bool get isSignUpLoading => _isSignUpLoading.value;

  Future<void> onSignUpPressed() async {
    if (_isSignUpLoading.value) return;
    try {
      _isSignUpLoading.value = true;
      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);
      Get.toNamed(AppRoutes.signup);
    } finally {
      _isSignUpLoading.value = false;
    }
  }

  // Log In
  final _isLogInLoading = false.obs;
  bool get isLogInLoading => _isLogInLoading.value;

  late final AccountService _account;

  Future<void> onLogInPressed() async {
    if (!formKey.currentState!.validate() || _isLogInLoading.value) return;

    try {
      _isLogInLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      await _account.logIn(usernameController.text.trim(), passwordController.text);

      final user = await _account.getCurrentUser();

      if (user != null) {
        Get.snackbar(
          'login_success'.tr,
          'welcome_back'.trParams({'user': user.fullname}),
          colorText: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(AppRoutes.home);
      } else {
        throw 'user_not_found'.tr;
      }
    } catch (e) {
      Get.snackbar(
        'login_failed'.tr,
        e.toString(),
        colorText: colorScheme.onError,
        backgroundColor: colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLogInLoading.value = false;
    }
  }

  bool get isLoading => isLogInLoading || isSignUpLoading || isForgotPasswordLoading;

  @override
  void onInit() {
    super.onInit();
    _account = Get.find();

    usernameFocusNode.addListener(() {
      isUsernameFocused.value = usernameFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      isPasswordFocused.value = passwordFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}

// ==== BINDING ====
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
