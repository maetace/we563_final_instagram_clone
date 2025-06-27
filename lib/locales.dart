// lib/locales.dart

// ===============================
// APP LOCALIZATION (EN, TH)
// ===============================

import 'package:get/get.dart';

// ===============================
// TRANSLATIONS CLASS
// ===============================

/// AppTranslations
/// - Provide multi-language support
/// - Supported locales: en_US, th_TH
/// - Usage: 'key'.tr
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // ===============================
    // ENGLISH (en_US)
    // ===============================
    'en_US': {
      // ===== Auth =====
      'login': 'Log In',
      'logout': 'Log Out',
      'signup': 'Sign Up',
      'username': 'Username',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot password?',
      'find_account': 'Find my account',
      'create_new_account': 'Create new account',
      // ===== Home/Welcome =====
      'welcome': 'Welcome',
      'welcome_back': 'Welcome back, @user! 🎉',
      'continue': 'Continue',
      'use_another_profile': 'Use another profile',
      'new_notifications': 'New notifications',
      // ===== Validation =====
      'please_enter_username': 'Please enter your username.',
      'username_min': 'Username must be at least 3 characters long.',
      'username_invalid': 'Username can only contain letters and numbers (no spaces or special characters).',
      'please_enter_password': 'Please enter your password.',
      'please_confirm_password': 'Please confirm your password.',
      'password_min': 'Password must be at least 8 characters long.',
      'password_not_match': 'Passwords do not match.',
      'password_no_space': 'Password must not contain whitespace.',
      'password_special_char': 'Password must contain at least one special character (e.g. !@#\$%^&*).',
      'password_letter': 'Password must contain at least one letter (A–Z or a–z).',
      'password_digit': 'Password must contain at least one digit (0–9).',
      'password_requirements': 'Password must contain a letter, a digit, and a special character.',
      // ===== Snackbar/Message =====
      'login_success': 'Log In Successful',
      'login_failed': 'Log In Failed',
      'signup_success': 'Sign Up Successful',
      'signup_failed': 'Sign Up Failed',
      'logout_success': 'Log Out Successful',
      'logout_confirm': 'Are you sure you want to log out?',
      // ===== Forgot =====
      'forgot_password_hint': 'Enter your username to reset your password.',
      'reset_password_sent': 'Reset password link sent',
      'reset_password_sent_desc': 'A reset password link has been sent to your email.',
      'user_not_found': 'User not found',
      'loading_profile': 'Loading profile...',
      // ===== Labels =====
      'email_or_username': 'Email or username',
      'error': 'Error',
      // ===== TimeAgo =====
      'day_ago': 'day ago',
      'days_ago': 'days ago',
      'hour_ago': 'hour ago',
      'hours_ago': 'hours ago',
      'minute_ago': 'minute ago',
      'minutes_ago': 'minutes ago',
      'just_now': 'Just now',
      // ===== Post Item =====
      'comment_as': 'Comment as @user',
      'write_a_comment': 'Write a comment...',
      // ===== Post New =====
      'post_new_title': 'New Post',
      'post_new_caption_box_hint': 'What\'s happening?',
      'post_new_photos_selected': 'Selected Photos',
      'post_new_photos_select_hint': 'Select up to 4 photos',
      'post_new_post_button': 'Post Now',
      // ===== Explore =====
      'explore': 'Explore',
      'search': 'Search',
      'search_hint': 'Search anything...',
      'explore_users': 'Accoounts',
      'explore_trending': 'Posts',
      // ===== Profile =====
      'profile': 'Profile',
      // ===== Reels =====
      'reels': 'Reels',
    },

    // ===============================
    // THAI (th_TH)
    // ===============================
    'th_TH': {
      // ===== Auth =====
      'login': 'เข้าสู่ระบบ',
      'logout': 'ออกจากระบบ',
      'signup': 'สมัครสมาชิก',
      'username': 'ชื่อผู้ใช้',
      'password': 'รหัสผ่าน',
      'confirm_password': 'ยืนยันรหัสผ่าน',
      'forgot_password': 'ลืมรหัสผ่าน?',
      'find_account': 'ค้นหาบัญชีของฉัน',
      'create_new_account': 'สร้างบัญชีใหม่',
      // ===== Home/Welcome =====
      'welcome': 'ยินดีต้อนรับ',
      'welcome_back': 'ยินดีต้อนรับกลับ, @user! 🎉',
      'continue': 'ดำเนินการต่อ',
      'use_another_profile': 'ใช้บัญชีอื่น',
      'new_notifications': 'แจ้งเตือนใหม่',
      // ===== Validation =====
      'please_enter_username': 'กรุณากรอกชื่อผู้ใช้',
      'username_min': 'ชื่อผู้ใช้ต้องมีอย่างน้อย 3 ตัวอักษร',
      'username_invalid': 'ชื่อผู้ใช้ต้องเป็นภาษาอังกฤษหรือตัวเลขเท่านั้น (ไม่เว้นวรรคหรืออักขระพิเศษ)',
      'please_enter_password': 'กรุณากรอกรหัสผ่าน',
      'please_confirm_password': 'กรุณายืนยันรหัสผ่าน',
      'password_min': 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร',
      'password_not_match': 'รหัสผ่านไม่ตรงกัน',
      'password_no_space': 'รหัสผ่านต้องไม่มีเว้นวรรค',
      'password_special_char': 'รหัสผ่านต้องมีอักขระพิเศษอย่างน้อย 1 ตัว (เช่น !@#\$%^&*)',
      'password_letter': 'รหัสผ่านต้องมีตัวอักษรภาษาอังกฤษอย่างน้อย 1 ตัว',
      'password_digit': 'รหัสผ่านต้องมีตัวเลขอย่างน้อย 1 ตัว',
      'password_requirements': 'รหัสผ่านต้องมีตัวอักษร ตัวเลข และอักขระพิเศษ',
      // ===== Snackbar/Message =====
      'login_success': 'เข้าสู่ระบบสำเร็จ',
      'login_failed': 'เข้าสู่ระบบล้มเหลว',
      'signup_success': 'สมัครสมาชิกสำเร็จ',
      'signup_failed': 'สมัครสมาชิกล้มเหลว',
      'logout_success': 'ออกจากระบบสำเร็จ',
      'logout_confirm': 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?',
      // ===== Forgot =====
      'forgot_password_hint': 'กรอกชื่อผู้ใช้เพื่อขอรีเซ็ตรหัสผ่าน',
      'reset_password_sent': 'ส่งลิงก์รีเซ็ตรหัสผ่านแล้ว',
      'reset_password_sent_desc': 'ระบบได้ส่งลิงก์รีเซ็ตรหัสผ่านไปที่อีเมลของคุณแล้ว',
      'user_not_found': 'ไม่พบบัญชีผู้ใช้',
      'loading_profile': 'กำลังโหลดโปรไฟล์...',
      // ===== Labels =====
      'email_or_username': 'อีเมลหรือชื่อผู้ใช้',
      'error': 'เกิดข้อผิดพลาด',
      // ===== TimeAgo =====
      'day_ago': 'วันที่แล้ว',
      'days_ago': 'วันที่แล้ว',
      'hour_ago': 'ชั่วโมงที่แล้ว',
      'hours_ago': 'ชั่วโมงที่แล้ว',
      'minute_ago': 'นาทีที่แล้ว',
      'minutes_ago': 'นาทีที่แล้ว',
      'just_now': 'เมื่อสักครู่',
      // ===== Post Item =====
      'comment_as': 'แสดงความคิดเห็นในชื่อ @user',
      'write_a_comment': 'เขียนความคิดเห็น...',
      // ===== Post New =====
      'post_new_title': 'โพสต์ใหม่',
      'post_new_caption_box_hint': 'คุณกำลังคิดอะไรอยู่?',
      'post_new_photos_selected': 'รูปที่เลือก',
      'post_new_photos_select_hint': 'เลือกรูปได้สูงสุด 4 รูป',
      'post_new_post_button': 'โพสต์เลย',
      // ===== Explore =====
      'explore': 'สำรวจ',
      'search': 'ค้นหา',
      'search_hint': 'ค้นหาอะไรก็ได้...',
      'explore_users': 'ผู้ใช้',
      'explore_trending': 'โพส',
      // ===== Profile =====
      'profile': 'โปรไฟล์',
      // ===== Reels =====
      'reels': 'Reels',
    },
  };
}
