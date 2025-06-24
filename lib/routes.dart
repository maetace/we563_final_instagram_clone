// lib/routes.dart

import 'package:get/get.dart';

// Welcome
import 'pages/welcome/welcome_page.dart';
import 'pages/welcome/welcome_binding.dart';

// Login
import 'pages/login/login_page.dart';
import 'pages/login/login_binding.dart';

// Signup
import 'pages/signup/signup_page.dart';
import 'pages/signup/signup_binding.dart';

// Forgot Password
import 'pages/forgot_password/forgot_password_page.dart';
import 'pages/forgot_password/forgot_password_binding.dart';

// Home
import 'pages/home/home_page.dart';
import 'pages/home/home_binding.dart';

// Post Item
import 'pages/post_item/post_item_page.dart';
import 'pages/post_item/post_item_binding.dart';

// New Post
import 'pages/post_new/post_new_page.dart';
import 'pages/post_new/post_new_binding.dart';

// AppRoutes
class AppRoutes {
  // Named routes
  static const welcome = '/';
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/home';
  static const forgot = '/forgot';
  static const postItem = '/postitem';
  static const postNew = '/postnew';

  // GetPage routes
  static final routes = [
    GetPage(name: welcome, page: () => WelcomePage(), binding: WelcomeBinding()),
    GetPage(name: signup, page: () => SignupPage(), binding: SignupBinding()),
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: forgot, page: () => ForgotPasswordPage(), binding: ForgotPasswordBinding()),
    GetPage(name: postItem, page: () => PostItemPage(), binding: PostItemBinding()),
    GetPage(name: postNew, page: () => PostNewPage(), binding: PostNewBinding()),
  ];
}
