import 'package:flutter/material.dart';

const String fontFamily = 'Inter';

final TextTheme appTextTheme = TextTheme(
  bodyLarge: TextStyle(fontSize: 16, fontFamily: fontFamily),
  bodyMedium: TextStyle(fontSize: 14, fontFamily: fontFamily),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  ),
);
