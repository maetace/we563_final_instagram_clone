import 'package:get/get.dart';
import 'package:we563_final_instagram_clone/widgets/loading_overlay/loading_overlay_controller.dart';

import '../../routes.dart';
import '../../services/account_service.dart';

class WelcomeController extends GetxController {
  void onSignUpPressed() {
    Get.toNamed(AppRoutes.signup);
  }

  void onLogInPressed() {
    Get.toNamed(AppRoutes.login);
  }

  // Initialize
  late LoadingOverlayController _loadingOverlayController;
  late AccountService _accountService;
  @override
  void onInit() {
    _loadingOverlayController = Get.find();
    _accountService = Get.find();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      final isLoggedIn = await _accountService.isLoggedIn();
      _loadingOverlayController.show();
      if (isLoggedIn) {
        Get.snackbar(
          'เข้าสู่ระบบแล้ว',
          'มี token อยู่ในระบบแล้ว',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Get.theme.colorScheme.onPrimary,
          backgroundColor: Get.theme.colorScheme.primary,
        );
        await 3.delay();
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar(
          'ยังไม่ได้เข้าสู่ระบบ',
          'ไม่มี token ในระบบ',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Get.theme.colorScheme.onPrimary,
          backgroundColor: Get.theme.colorScheme.error,
        );
      }
    } catch (e) {
      Get.snackbar(
        'ไม่สามารถเข้าสู่ระบบได้',
        'กรุณาตรวจสอบการเชื่อมต่อระบบ',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Get.theme.colorScheme.onPrimary,
        backgroundColor: Get.theme.colorScheme.primary,
      );
    } finally {
      _loadingOverlayController.hide();
    }
    super.onReady();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
