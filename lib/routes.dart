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
    GetPage(
      name: welcome,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(name: signup, page: () => SignUpPage(), binding: SignUpBinding()),
    GetPage(name: login, page: () => LogInPage(), binding: LogInBinding()),
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
      name: forgot,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
