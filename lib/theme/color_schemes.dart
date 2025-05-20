import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0064E0), // Instagram blue
  brightness: Brightness.light,
).copyWith(
  primary: const Color(0xFF0064E0),
  onPrimary: const Color(0xFFFFFFFF),
  secondary: const Color(0xFF2D639F),
  onSecondary: const Color(0xFF0055BB),
  surface: const Color(0xFFFFFFFF),
  onSurface: const Color(0xFF000000),
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0064E0),
  brightness: Brightness.dark,
).copyWith(
  primary: const Color(0xFF0064E0),
  onPrimary: const Color(0xFFDDDDDD),
  secondary: const Color(0xFF6389BA),
  onSecondary: const Color(0xFF0055BB),
  surface: const Color(0xFF162127),
  onSurface: const Color(0xEEEEEEEE),
);
