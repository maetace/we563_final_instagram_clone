import 'package:get/get.dart';
import '../../routes.dart';

class WelcomeController extends GetxController {
  void onSignUpPressed() {
    Get.toNamed(AppRoutes.signup);
  }

  void onLogInPressed() {
    Get.toNamed(AppRoutes.login);
  }
}
