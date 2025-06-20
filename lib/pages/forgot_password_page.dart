import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/configs.dart';
import '/data.dart';
import '/widgets.dart';

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
                actions: const [LanguageSwitcher()],
                actionsPadding: const EdgeInsets.only(right: 8),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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

// ==== CONTROLLER ====
class ForgotPasswordController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Form Keys
  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final isUsernameFocused = false.obs;
  final usernameText = ''.obs;

  final _isForgotPasswordLoading = false.obs;
  bool get isForgotPasswordLoading => _isForgotPasswordLoading.value;
  bool get isLoading => isForgotPasswordLoading;

  // Service
  late final AccountService _account;

  @override
  void onInit() {
    super.onInit();
    _account = Get.find<AccountService>();

    usernameFocusNode.addListener(() {
      isUsernameFocused.value = usernameFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    usernameController.dispose();
    usernameFocusNode.dispose();
    super.onClose();
  }

  // Input Callback
  void onUsernameChanged(String value) {
    usernameText.value = value;
  }

  // Validator
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_username'.tr;
    if (value.length < 3) return 'username_min'.tr;
    return null;
  }

  // Navigation
  void onBackPressed() => Get.back();

  // Action
  Future<void> onForgotPasswordPressed() async {
    if (!formKey.currentState!.validate() || isForgotPasswordLoading) return;

    try {
      _isForgotPasswordLoading.value = true;

      if (AppConfig.useMockDelay) {
        await Future.delayed(AppConfig.mockDelay);
      }

      final user = await _account.findUserByUsername(usernameController.text.trim());

      if (user != null) {
        Get.snackbar(
          'reset_password_sent'.tr,
          'reset_password_sent_desc'.tr,
          colorText: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw 'user_not_found'.tr;
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        e.toString(),
        colorText: colorScheme.onError,
        backgroundColor: colorScheme.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isForgotPasswordLoading.value = false;
    }
  }
}

// ==== BINDING ====
class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}
