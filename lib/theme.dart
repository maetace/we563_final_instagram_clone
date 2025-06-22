// lib/theme.dart

import 'package:flutter/material.dart';

// ===============================
//     TEXT THEME
// ===============================

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

// ===============================
//     INPUT DECORATION THEME
// ===============================

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

// ===============================
//     BUTTON THEME
// ===============================

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

// ===============================
//     COLOR SCHEMES
// ===============================

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
  onSurface: const Color(0xFFEEEEEE),
);

// ===============================
//     THEME DATA
// ===============================

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: appTextTheme,
  iconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: inputTheme(lightColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(lightColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(lightColorScheme),
  textButtonTheme: textButtonTheme(lightColorScheme),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: lightColorScheme.onSurface,
    unselectedItemColor: lightColorScheme.onSurface,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: appTextTheme,
  iconTheme: const IconThemeData(color: Colors.white),
  inputDecorationTheme: inputTheme(darkColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(darkColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(darkColorScheme),
  textButtonTheme: textButtonTheme(darkColorScheme),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: darkColorScheme.onSurface,
    unselectedItemColor: darkColorScheme.onSurface,
  ),
);
