// lib/utils.dart

// ===============================
// APP UTILITIES
// ===============================

import 'dart:math';
import 'package:get/get.dart';

// ===============================
// RANDOM STRING GENERATOR
// ===============================

/// Generate a random string of given [length]
/// - Used for temp ID, testing purpose
String randomString(int length) {
  var r = Random.secure();
  var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return Iterable.generate(length, (_) => chars[r.nextInt(chars.length)]).join();
}

// ===============================
// TIME AGO FORMATTER
// ===============================

/// Convert [date] to human-readable "time ago" string
/// - Supports i18n with '.tr'
String timeAgo(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inDays >= 1) {
    return diff.inDays == 1 ? '1 ${'day_ago'.tr}' : '${diff.inDays} ${'days_ago'.tr}';
  } else if (diff.inHours >= 1) {
    return diff.inHours == 1 ? '1 ${'hour_ago'.tr}' : '${diff.inHours} ${'hours_ago'.tr}';
  } else if (diff.inMinutes >= 1) {
    return diff.inMinutes == 1 ? '1 ${'minute_ago'.tr}' : '${diff.inMinutes} ${'minutes_ago'.tr}';
  } else {
    return 'just_now'.tr;
  }
}

// ===============================
// PATH / URL HELPER
// ===============================

/// Check if [path] is a web URL (http or https)
bool isWebPath(String path) {
  return path.contains('http://') || path.contains('https://');
}
