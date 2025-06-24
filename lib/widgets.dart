// lib/widgets.dart

// ===============================
// COMMON WIDGETS
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ===============================
// LOADING BUTTON
// ===============================

/// LoadingButton
/// - Supports Elevated / Outlined / Text Button
/// - Show loading spinner when [isLoading] = true
/// - Used for form submit, async actions
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
    // Loader color per button type
    final loader = switch (type) {
      ButtonType.elevated => const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      ButtonType.outlined || ButtonType.text => const CircularProgressIndicator(strokeWidth: 2),
    };

    final ButtonStyle style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 24)),
      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.2)),
    );

    final Widget child = Center(
      child:
          isLoading
              ? SizedBox(width: 24, height: 24, child: loader)
              : FittedBox(fit: BoxFit.scaleDown, child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
    );

    return switch (type) {
      ButtonType.elevated => ElevatedButton(onPressed: onPressed, style: style, child: child),
      ButtonType.outlined => OutlinedButton(onPressed: onPressed, style: style, child: child),
      ButtonType.text => TextButton(onPressed: onPressed, style: style, child: child),
    };
  }
}

enum ButtonType { elevated, outlined, text }

// ===============================
// LANGUAGE SWITCHER
// ===============================

/// LanguageSwitcher
/// - Toggle between 'th_TH' and 'en_US'
/// - Save language to SharedPreferences
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final isThai = (Get.locale?.languageCode ?? 'th') == 'th';

    return IconButton(
      icon: const Icon(Icons.language),
      tooltip: 'change_language'.tr,
      onPressed: () async {
        final newLocale = isThai ? const Locale('en', 'US') : const Locale('th', 'TH');
        Get.updateLocale(newLocale);

        // Save to shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('locale', '${newLocale.languageCode}_${newLocale.countryCode}');
      },
    );
  }
}

// ===============================
// THEME SWITCHER
// ===============================

/// ThemeSwitcher
/// - Toggle between light / dark theme
/// - Save themeMode to SharedPreferences
class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      tooltip: 'change_theme'.tr,
      onPressed: () async {
        final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
        Get.changeThemeMode(newMode);

        // Save to shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('themeMode', newMode.name); // "light" / "dark" / "system"
      },
    );
  }
}

// ===============================
// PAGE CONTAINER (MAX WIDTH)
// ===============================

/// AppPageContainer
/// - Center content with maxWidth constraint
/// - Default maxWidth: 430px (Mobile-friendly)
/// - Adds horizontal padding
class AppPageContainer extends StatelessWidget {
  final Widget child;

  const AppPageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18), child: child),
      ),
    );
  }
}
