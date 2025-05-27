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

## 📄 lib/main.dart

```plaintext
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'account_mock.dart';

import 'routes.dart';
import 'theme/app_theme.dart';

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

<!-- ## 📄 

```plaintext

``` -->

---
