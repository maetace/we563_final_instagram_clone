import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;

import '/routes.dart';
import '/config/app_config.dart';
import '/account_mock.dart';

class SignUpController extends GetxController {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  final Logger _logger = Logger();

  // Form Keys
  final formKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final passwordConfirmKey = GlobalKey<FormFieldState>();

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  // Focus Nodes
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final passwordConfirmFocusNode = FocusNode();

  // Focused
  final isUsernameFocused = false.obs;
  final isPasswordFocused = false.obs;
  final isPasswordConfirmFocused = false.obs;

  // onChange callback
  final usernameText = ''.obs;
  final passwordText = ''.obs;
  final passwordConfirmText = ''.obs;

  void onUsernameChanged(String value) => usernameText.value = value;
  void onPasswordChanged(String value) => passwordText.value = value;
  void onPasswordConfirmChanged(String value) => passwordConfirmText.value = value;

  // Visibility Toggle
  final isPasswordVisible = false.obs;
  final isPasswordConfirmVisible = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void togglePasswordConfirmVisibility() => isPasswordConfirmVisible.value = !isPasswordConfirmVisible.value;

  // Avatar Selection (preset from assets)
  final availableAvatars = [
    'assets/mock_avatars/default.jpg',
    'assets/mock_avatars/yelena.jpg',
    'assets/mock_avatars/usagent.jpg',
    'assets/mock_avatars/valentina.jpg',
    'assets/mock_avatars/melgold.jpg',
    'assets/mock_avatars/redgadian.jpg',
    'assets/mock_avatars/taskmaster.jpg',
    'assets/mock_avatars/justbob.jpg',
    'assets/mock_avatars/ghost.jpg',
    'assets/mock_avatars/buckybarnes.jpg',
    'assets/mock_avatars/baronzemo.jpg',
  ];

  final selectedAvatar = ''.obs;

  void onAvatarSelected(String path) {
    selectedAvatar.value = path;
  }

  // Avatar Upload (optional – unused here but kept for future use)
  final avatarFile = Rxn<File>();
  final avatarBytes = Rxn<Uint8List>();

  Future<void> pickAvatar() async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
      if (result != null && result.files.single.bytes != null) {
        avatarBytes.value = result.files.single.bytes!;
        final fileName = result.files.single.name; // ⬅️ ได้ชื่อไฟล์โดยตรงจาก Web
        selectedAvatar.value = 'assets/mock_avatars/$fileName';

        _logger.i('📷 Avatar picked (Web) – $fileName');
      } else {
        _logger.w('❌ Avatar pick canceled (Web)');
      }
    } else {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        avatarFile.value = File(image.path);
        final fileName = p.basename(image.path); // ⬅️ ใช้ path package ดึงชื่อไฟล์
        selectedAvatar.value = 'assets/mock_avatars/$fileName';

        _logger.i('📷 Avatar picked (Mobile) – $fileName');
      } else {
        _logger.w('❌ Avatar pick canceled (Mobile)');
      }
    }
  }

  // Validators
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a username.';
    final errors = <String>[];
    if (value.length < 3) errors.add('Username must be at least 3 characters long.');
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      errors.add('Username can only contain letters and numbers (no spaces or special characters).');
    }
    return errors.isEmpty ? null : errors.join('\n');
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password.';
    final errors = <String>[];
    if (value.length < 8) errors.add('Password must be at least 8 characters long.');
    if (value.contains(RegExp(r'\s'))) errors.add('Password must not contain whitespace.');
    if (!RegExp(r'[^\w\s]').hasMatch(value)) {
      errors.add('Password must contain at least one special character (e.g. !@#\$%^&*).');
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      errors.add('Password must contain at least one letter (A–Z or a–z).');
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      errors.add('Password must contain at least one digit (0–9).');
    }
    return errors.isEmpty ? null : errors.join('\n');
  }

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password.';
    if (value != passwordController.text) return 'Passwords do not match.';
    return null;
  }

  // Navigation
  void onBackPressed() => Get.back();

  // Log In Loading
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

  // Sign Up Loading
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
        // null, // email
        selectedAvatar.value.isNotEmpty ? selectedAvatar.value : 'assets/mock_avatars/default.jpg',
      );

      await _accountService.saveSession(uid: uid, token: 'mock_token');

      final user = await _accountService.getCurrentUser();

      Get.snackbar(
        'Sign Up Successful',
        user != null ? 'Welcome, ${user.fullname}! 🎉' : 'Welcome! We\'re excited to have you join us. 🎉',
        backgroundColor: colorScheme.primaryContainer,
        colorText: colorScheme.onPrimaryContainer,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Sign Up Failed',
        '$e',
        backgroundColor: colorScheme.error,
        colorText: colorScheme.onError,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isSignUpLoading.value = false;
    }
  }

  bool get isLoading => isSignUpLoading || isLogInLoading;

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
