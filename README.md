# 📸 WE563 Final Project - Instagram Clone

A Flutter application developed as a final project for the course **WE563 - การพัฒนาแอปพลิเคชันบนอุปกรณ์พกพา**.  
This project follows a clean MVC architecture using GetX for state and route management.

---

## 📦 Project Information

| Item           | Detail                                                 |
|----------------|--------------------------------------------------------|
| **Project Name** | `we563_final_instagram_clone`                        |
| **Folder Name**  | `we563_final_instagram_clone`                        |
|----------------|--------------------------------------------------------|
| **Repository**   | [GitHub Repo](https://github.com/maetace/we563_final_instagram_clone) |

---

## 📄 Project Structure (Files & Folders)

```plaintext
.
├── assets
│   ├── images
│   │   ├── avatar.jpg
│   │   ├── instagram_icon.png
│   │   ├── instagram_icon.svg
│   │   ├── meta_logo_mono.png
│   │   ├── meta_logo_mono.svg
│   │   └── meta_logo.svg
│   └── mock_avatars
│       ├── baronzemo.jpg
│       ├── buckybarnes.jpg
│       ├── default.jpg
│       ├── ghost.jpg
│       ├── justbob.jpg
│       ├── melgold.jpg
│       ├── redgadian.jpg
│       ├── taskmaster.jpg
│       ├── usagent.jpg
│       ├── valentina.jpg
│       └── yelena.jpg
├── lib
│   ├── account_mock.dart
│   ├── config
│   │   ├── app_config.dart
│   │   └── env_loader.dart
│   ├── main.dart
│   ├── models
│   │   └── Archive.zip
│   ├── pages
│   │   ├── forgot_password
│   │   │   ├── forgot_password_binding.dart
│   │   │   ├── forgot_password_controller.dart
│   │   │   └── forgot_password_page.dart
│   │   ├── home
│   │   │   ├── home_binding.dart
│   │   │   ├── home_controller.dart
│   │   │   └── home_page.dart
│   │   ├── log_in
│   │   │   ├── log_in_binding.dart
│   │   │   ├── log_in_controller.dart
│   │   │   └── log_in_page.dart
│   │   ├── sign_up
│   │   │   ├── sign_up_binding.dart
│   │   │   ├── sign_up_controller.dart
│   │   │   └── sign_up_page.dart
│   │   └── welcome
│   │       ├── welcome_binding.dart
│   │       ├── welcome_controller.dart
│   │       └── welcome_page.dart
│   ├── routes.dart
│   ├── services
│   │   └── Archive.zip
│   ├── theme
│   │   └── Archive.zip
│   ├── theme.dart
│   ├── utils.dart
│   └── widgets
│       └── loading_button_widget.dart
├── pubspec.yaml
└── README.md
```

---

## 📄 lib/main.dart

```plaintext
// lib/main.dart

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
```

---

## 📄 lib/routes.dart

```plaintext
// lib/routes.dart

import 'package:get/get.dart';

import 'pages/home/home_binding.dart';
import 'pages/home/home_page.dart';
import 'pages/log_in/log_in_binding.dart';
import 'pages/log_in/log_in_page.dart';
import 'pages/sign_up/sign_up_binding.dart';
import 'pages/sign_up/sign_up_page.dart';
import 'pages/welcome/welcome_binding.dart';
import 'pages/welcome/welcome_page.dart';
import 'pages/forgot_password/forgot_password_binding.dart';
import 'pages/forgot_password/forgot_password_page.dart';

class AppRoutes {
  static const welcome = '/';
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/home';
  static const forgot = '/forgot';

  static final routes = [
    GetPage(name: welcome, page: () => WelcomePage(), binding: WelcomeBinding()),
    GetPage(name: signup, page: () => SignUpPage(), binding: SignUpBinding()),
    GetPage(name: login, page: () => LogInPage(), binding: LogInBinding()),
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: forgot, page: () => const ForgotPasswordPage(), binding: ForgotPasswordBinding()),
  ];
}
```

---

## 📄 lib/widgets/loading_button_widget.dart

```plaintext
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;
  final ButtonType type;

  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.label,
    this.type = ButtonType.elevated,
  });

  @override
  Widget build(BuildContext context) {
    final Widget loader = switch (type) {
      ButtonType.elevated => const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      ButtonType.outlined || ButtonType.text => const CircularProgressIndicator(strokeWidth: 2),
    };

    final Widget child = isLoading ? SizedBox(height: 20, width: 20, child: loader) : Text(label);

    final ButtonStyle style = ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)));

    return switch (type) {
      ButtonType.elevated => ElevatedButton(onPressed: onPressed, style: style, child: child),
      ButtonType.outlined => OutlinedButton(onPressed: onPressed, style: style, child: child),
      ButtonType.text => TextButton(onPressed: onPressed, style: style, child: child),
    };
  }
}

enum ButtonType { elevated, outlined, text }
```

---

## 📄 lib/theme.dart

```plaintext
// lib/theme.dart

import 'package:flutter/material.dart';

const String fontFamily = 'roboto';

final TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, fontFamily: fontFamily),
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: fontFamily),
  titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, fontFamily: fontFamily),
  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: fontFamily),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: fontFamily),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, fontFamily: fontFamily),
);

InputDecorationTheme inputTheme(ColorScheme colorScheme) {
  return InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surface,
    hintStyle: TextStyle(color: colorScheme.outline, fontSize: 16),
    labelStyle: TextStyle(color: colorScheme.outline, fontSize: 16),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: colorScheme.outline, width: 1.5),
    ),
  );
}

ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) => ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    elevation: 0,
  ),
);

OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) => OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: colorScheme.onSecondary,
    side: BorderSide(color: colorScheme.secondary, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  ),
);

TextButtonThemeData textButtonTheme(ColorScheme colorScheme) => TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: colorScheme.onSurface,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0064E0),
  brightness: Brightness.light,
).copyWith(
  primary: const Color(0xFF0064E0),
  onPrimary: const Color(0xFFFFFFFF),
  secondary: const Color(0xFF2D639F),
  onSecondary: const Color(0xFF0055BB),
  surface: const Color(0xFFFFFFFF),
  onSurface: const Color(0xFF000000),
);

final darkColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF0064E0), brightness: Brightness.dark).copyWith(
  primary: const Color(0xFF0064E0),
  onPrimary: const Color(0xFFDDDDDD),
  secondary: const Color(0xFF6389BA),
  onSecondary: const Color(0xFF0055BB),
  surface: const Color(0xFF162127),
  onSurface: const Color(0xEEEEEEEE),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: appTextTheme,
  inputDecorationTheme: inputTheme(lightColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(lightColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(lightColorScheme),
  textButtonTheme: textButtonTheme(lightColorScheme),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: appTextTheme,
  inputDecorationTheme: inputTheme(darkColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(darkColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(darkColorScheme),
  textButtonTheme: textButtonTheme(darkColorScheme),
);
```

---

<!-- ## 📄 

```plaintext

``` -->

---
