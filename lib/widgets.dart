import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final isThai = (Get.locale?.languageCode ?? 'th') == 'th';

    return IconButton(
      icon: Icon(Icons.language),
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
