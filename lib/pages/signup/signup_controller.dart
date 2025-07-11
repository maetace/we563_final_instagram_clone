// lib/pages/signup/signup_controller.dart

// ===============================
// CONTROLLER: SIGN UP
// ===============================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import '/configs.dart';
import '/routes.dart';
import '/services/account_service.dart';

// ===============================
// SIGNUP CONTROLLER
// ===============================

class SignupController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  final Logger _logger = Logger();

  // ===============================
  // FORM KEYS
  // ===============================

  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final passwordConfirmKey = GlobalKey<FormFieldState>();

  // ===============================
  // TEXT CONTROLLERS
  // ===============================

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  // ===============================
  // FOCUS NODES
  // ===============================

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final passwordConfirmFocusNode = FocusNode();

  // ===============================
  // FOCUS OBSERVABLES
  // ===============================

  final isUsernameFocused = false.obs;
  final isPasswordFocused = false.obs;
  final isPasswordConfirmFocused = false.obs;

  // ===============================
  // TEXT OBSERVABLES
  // ===============================

  final usernameText = ''.obs;
  final passwordText = ''.obs;
  final passwordConfirmText = ''.obs;

  void onUsernameChanged(String value) => usernameText.value = value;
  void onPasswordChanged(String value) => passwordText.value = value;
  void onPasswordConfirmChanged(String value) => passwordConfirmText.value = value;

  // ===============================
  // PASSWORD VISIBILITY
  // ===============================

  final isPasswordVisible = false.obs;
  final isPasswordConfirmVisible = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void togglePasswordConfirmVisibility() => isPasswordConfirmVisible.value = !isPasswordConfirmVisible.value;

  // ===============================
  // AVATAR SELECTION (PRESET)
  // ===============================

  final availableAvatars = [
    'assets/avatars_mock/default.jpg',
    'assets/avatars_mock/yelena.jpg',
    'assets/avatars_mock/usagent.jpg',
    'assets/avatars_mock/valentina.jpg',
    'assets/avatars_mock/melgold.jpg',
    'assets/avatars_mock/redgadian.jpg',
    'assets/avatars_mock/taskmaster.jpg',
    'assets/avatars_mock/justbob.jpg',
    'assets/avatars_mock/ghost.jpg',
    'assets/avatars_mock/buckybarnes.jpg',
    'assets/avatars_mock/baronzemo.jpg',
  ];

  final selectedAvatar = ''.obs;

  void onAvatarSelected(String path) {
    selectedAvatar.value = path;
  }

  // ===============================
  // AVATAR UPLOAD (WEB/MOBILE)
  // ===============================

  final avatarFile = Rxn<File>();
  final avatarBytes = Rxn<Uint8List>();

  Future<void> pickAvatar() async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
      if (result != null && result.files.single.bytes != null) {
        avatarBytes.value = result.files.single.bytes!;
        final fileName = result.files.single.name;
        selectedAvatar.value = 'assets/avatars_mock/$fileName';
        _logger.i('📷 Avatar picked (Web) – $fileName');
      } else {
        _logger.w('❌ Avatar pick canceled (Web)');
      }
    } else {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        avatarFile.value = File(image.path);
        final fileName = p.basename(image.path);
        selectedAvatar.value = 'assets/avatars_mock/$fileName';
        _logger.i('📷 Avatar picked (Mobile) – $fileName');
      } else {
        _logger.w('❌ Avatar pick canceled (Mobile)');
      }
    }
  }

  // ===============================
  // VALIDATORS
  // ===============================

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_username'.tr;
    final errors = <String>[];
    if (value.length < 3) errors.add('username_min'.tr);
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) errors.add('username_invalid'.tr);
    return errors.isEmpty ? null : errors.join('\n');
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_enter_password'.tr;
    final errors = <String>[];
    if (value.length < 8) errors.add('password_min'.tr);
    if (value.contains(RegExp(r'\s'))) errors.add('password_no_space'.tr);
    if (!RegExp(r'[^\w\s]').hasMatch(value)) errors.add('password_special_char'.tr);
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) errors.add('password_letter'.tr);
    if (!RegExp(r'\d').hasMatch(value)) errors.add('password_digit'.tr);
    return errors.isEmpty ? null : errors.join('\n');
  }

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) return 'please_confirm_password'.tr;
    if (value != passwordController.text) return 'password_not_match'.tr;
    return null;
  }

  // ===============================
  // NAVIGATION
  // ===============================

  void onBackPressed() => Get.back();

  // ===============================
  // LOG IN BUTTON
  // ===============================

  final _isLogInLoading = false.obs;
  bool get isLogInLoading => _isLogInLoading.value;

  Future<void> onLogInPressed() async {
    if (_isLogInLoading.value) return;
    try {
      _isLogInLoading.value = true;
      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);
      Get.offAllNamed(AppRoutes.login);
    } finally {
      _isLogInLoading.value = false;
    }
  }

  // ===============================
  // SIGN UP BUTTON
  // ===============================

  final _isSignUpLoading = false.obs;
  bool get isSignUpLoading => _isSignUpLoading.value;

  Future<void> onSignUpPressed() async {
    if (_isSignUpLoading.value || !formKey.currentState!.validate()) return;

    try {
      _isSignUpLoading.value = true;
      if (AppConfig.useMockDelay) await Future.delayed(AppConfig.mockDelay);

      final uid = const Uuid().v4();

      await _accountService.signUp(
        uid,
        usernameController.text,
        passwordController.text,
        selectedAvatar.value.isNotEmpty ? selectedAvatar.value : 'assets/avatars_mock/default.jpg',
      );

      await _accountService.saveSession(uid: uid, token: 'mock_token');

      final account = await _accountService.getCurrentAccount();

      Get.snackbar(
        'signup_success'.tr,
        account != null ? 'welcome_back'.trParams({'user': account.fullname}) : 'welcome'.tr,
        backgroundColor: colorScheme.primaryContainer,
        colorText: colorScheme.onPrimaryContainer,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'signup_failed'.tr,
        '$e',
        backgroundColor: colorScheme.error,
        colorText: colorScheme.onError,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isSignUpLoading.value = false;
    }
  }

  // ===============================
  // IS LOADING
  // ===============================

  bool get isLoading => isSignUpLoading || isLogInLoading;

  // ===============================
  // INIT
  // ===============================

  late AccountService _accountService;

  @override
  void onInit() {
    _accountService = Get.find<AccountService>();
    super.onInit();

    usernameFocusNode.addListener(() {
      isUsernameFocused.value = usernameFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      isPasswordFocused.value = passwordFocusNode.hasFocus;
    });
    passwordConfirmFocusNode.addListener(() {
      isPasswordConfirmFocused.value = passwordConfirmFocusNode.hasFocus;
    });
  }

  // ===============================
  // CLEANUP
  // ===============================

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmFocusNode.dispose();
    super.onClose();
  }
}
