// lib/routes.dart

import 'package:get/get.dart';

import 'pages/welcome/welcome_page.dart';
import 'pages/welcome/welcome_binding.dart';
import 'pages/login/login_page.dart';
import 'pages/login/login_binding.dart';
import 'pages/signup/signup_page.dart';
import 'pages/signup/signup_binding.dart';
import 'pages/forgot_password/forgot_password_page.dart';
import 'pages/forgot_password/forgot_password_binding.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_binding.dart';

class AppRoutes {
  static const welcome = '/';
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/home';
  static const forgot = '/forgot';

  static final routes = [
    GetPage(name: welcome, page: () => WelcomePage(), binding: WelcomeBinding()),
    GetPage(name: signup, page: () => SignupPage(), binding: SignupBinding()),
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: forgot, page: () => const ForgotPasswordPage(), binding: ForgotPasswordBinding()),
  ];
}
