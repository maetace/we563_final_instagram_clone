// lib/main.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs.dart';
import 'locales.dart';
import 'data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.mock");

  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('locale');
  final locale = saved != null ? Locale(saved.split('_')[0], saved.split('_')[1]) : Get.deviceLocale;

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
            builder: DevicePreview.appBuilder,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,

            translations: AppTranslations(),

            locale: locale,
            fallbackLocale: const Locale('th', 'TH'),
          ),
    ),
  );
}

void _init() {
  Get.put<AccountService>(AccountServiceMock(), permanent: true);
}
