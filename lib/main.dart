import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'account_mock.dart';

import 'routes.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.mock");

  _init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) => GetMaterialApp(
            useInheritedMediaQuery: true,
            title: 'Instagram Clone',
            initialRoute: AppRoutes.welcome,
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
  Get.put<AccountService>(AccountServiceMock(), permanent: true);
}
