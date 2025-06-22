// lib/main.dart

// ===============================
//     MAIN ENTRY POINT
// ===============================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';
import 'theme.dart';
import 'locales.dart';

import 'services/account_service.dart';
import 'services/account_service_mock.dart';
import 'services/post_service.dart';
import 'services/post_service_mock.dart';

// ===============================
//     MAIN()
// ===============================

Future<void> main() async {
  // ==== 1. Flutter Init ====
  WidgetsFlutterBinding.ensureInitialized();

  // ==== 2. Lock to Portrait Mode ====
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // ==== 3. Load .env (ENVIRONMENT) ====
  await dotenv.load(fileName: ".env.mock");

  // ==== 4.  Load shared_preferences (Storage) ====
  final prefs = await SharedPreferences.getInstance();
  // Load User Locale
  final savedLocale = prefs.getString('locale');
  final locale = savedLocale != null ? Locale(savedLocale.split('_')[0], savedLocale.split('_')[1]) : Get.deviceLocale;
  // ThemeMode
  final savedTheme = prefs.getString('themeMode');
  final themeMode = switch (savedTheme) {
    'dark' => ThemeMode.dark,
    'light' => ThemeMode.light,
    _ => ThemeMode.system,
  };

  // ==== 5. Global Dependency Injection ====
  _init();

  // ==== 6. Run Application ====
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) => GetMaterialApp(
            useInheritedMediaQuery: true,
            title: 'Instagram Clone',

            // ==== Routing ====
            initialRoute: AppRoutes.welcome,
            getPages: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            builder: DevicePreview.appBuilder,

            // ==== Theme ====
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,

            // ==== Localization ====
            translations: AppTranslations(),
            locale: locale,
            fallbackLocale: const Locale('th', 'TH'),
          ),
    ),
  );
}

// ===============================
//     GLOBAL SERVICE INIT
// ===============================

void _init() {
  Get.put<AccountService>(AccountServiceMock(), permanent: true);
  Get.put<PostService>(PostServiceMock(), permanent: true);
}
