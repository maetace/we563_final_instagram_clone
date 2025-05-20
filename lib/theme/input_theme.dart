import 'package:flutter/material.dart';

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
