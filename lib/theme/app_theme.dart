import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'text_theme.dart';
import 'input_theme.dart';
import 'button_theme.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: appTextTheme,
  inputDecorationTheme: inputTheme(lightColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(lightColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(lightColorScheme),
  textButtonTheme: textButtonTheme(lightColorScheme),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: appTextTheme,
  inputDecorationTheme: inputTheme(darkColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(darkColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(darkColorScheme),
  textButtonTheme: textButtonTheme(darkColorScheme),
);
