import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:we563_final_instagram_clone/services/account_service.dart';
import 'package:we563_final_instagram_clone/services/account_service_mock.dart';

import 'routes.dart';
import 'theme/app_theme.dart';

void main() {
  _init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) => GetMaterialApp(
            useInheritedMediaQuery: true,
            title: 'Instagram Clone',
            initialRoute: AppRoutes.login,
            getPages: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,

            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
          ),
    ),
  );
}

void _init() {
  // Initialize secure storage
  Get.put(FlutterSecureStorage(), permanent: true); // Register secure storage
  Get.put<AccountService>(AccountServiceMock(), permanent: true); // Register the mock account service
}
