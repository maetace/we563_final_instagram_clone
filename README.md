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

## 📁 Project Structure

```plaintext
.
├── analysis_options.yaml
├── assets
│   └── images
│       └── instagram_icon.png
├── codemagic.yaml
├── firebase.json
├── lib
│   ├── main.dart
│   ├── models
│   ├── pages
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
│   ├── theme
│   │   ├── app_theme.dart
│   │   ├── button_theme.dart
│   │   ├── color_schemes.dart
│   │   ├── input_theme.dart
│   │   └── text_theme.dart
│   ├── utils.dart
│   └── widgets
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── structure.txt
└── we563_final_instagram_clone.iml

13 directories, 29 files
```

---

## 📦 pubspec.yaml

```plaintext
name: we563_final_instagram_clone
description: "WE563 Final Project - Instagram Clone"
publish_to: "none"
version: 0.1.0

environment:
  sdk: ^3.7.0

dependencies:
  flutter:
    sdk: flutter
  get: ^4.7.2 # Updated 2025-02-18
  device_preview: ^1.2.0 # Updated 2025-03-12
  flutter_secure_storage: ^9.2.4 # Updated 2025-01-10
  carousel_slider: ^4.2.1 # Updated 2025-04-05
  shimmer: ^3.0.0 # Updated 2023-05-20
  image_picker: ^1.0.7 # Updated 2025-04-15
  cupertino_icons: ^1.0.6 # Updated 2025-03-28

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0 # Updated 2025-05-01

flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

---

## 📄 main.dart

```plaintext
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';
import 'theme/app_theme.dart';

void main() {
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
```

---

## 📄 routes.dart

```plaintext
import 'package:get/get.dart';

import 'pages/home/home_binding.dart';
import 'pages/home/home_page.dart';
import 'pages/log_in/log_in_binding.dart';
import 'pages/log_in/log_in_page.dart';
import 'pages/sign_up/sign_up_binding.dart';
import 'pages/sign_up/sign_up_page.dart';
import 'pages/welcome/welcome_binding.dart';
import 'pages/welcome/welcome_page.dart';

class AppRoutes {
  static const welcome = '/';
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/home';

  static final routes = [
    GetPage(
      name: welcome,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(name: signup, page: () => SignUpPage(), binding: SignUpBinding()),
    GetPage(name: login, page: () => LogInPage(), binding: LogInBinding()),
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
  ];
}
```

---

## 📄 app_theme.dart

```plaintext
import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'text_theme.dart';
import 'input_theme.dart';
import 'button_theme.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: appTextTheme,
  inputDecorationTheme: inputTheme(lightColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(lightColorScheme),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: appTextTheme,
  inputDecorationTheme: inputTheme(darkColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(darkColorScheme),
);
```

---

## 📄 color_schemes.dart

```plaintext
import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0064E0), // Instagram blue
  brightness: Brightness.light,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0064E0),
  brightness: Brightness.dark,
);
```

---

## 📄 text_theme.dart

```plaintext
import 'package:flutter/material.dart';

const String fontFamily = 'Inter';

final TextTheme appTextTheme = TextTheme(
  bodyLarge: TextStyle(fontSize: 16, fontFamily: fontFamily),
  bodyMedium: TextStyle(fontSize: 14, fontFamily: fontFamily),
  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: fontFamily,),
);
```

---

## 📄 input_theme.dart

```plaintext
import 'package:flutter/material.dart';

InputDecorationTheme inputTheme(ColorScheme colorScheme) {
  return InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surface,
    hintStyle: TextStyle(
      color: colorScheme.onSurface.withAlpha(0.6 as int),
      fontSize: 14,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
    ),
  );
}
```

---

## 📄 button_theme.dart

```plaintext
import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
```

---
