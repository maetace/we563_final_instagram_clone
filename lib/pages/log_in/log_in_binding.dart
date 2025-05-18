import 'package:get/get.dart';

import 'log_in_controller.dart';

class LogInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogInController());
  }
}
