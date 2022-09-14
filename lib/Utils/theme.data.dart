import 'package:flutter/material.dart';

final light = ThemeData(
  primarySwatch: const MaterialColor(4278797515, {
    50: Color(0xffe7eefe),
    100: Color(0xffcedcfd),
    200: Color(0xff9dbafb),
    300: Color(0xff6c97f9),
    400: Color(0xff3c74f6),
    500: Color(0xff0b52f4),
    600: Color(0xff0941c3),
    700: Color(0xff063193),
    800: Color(0xff042162),
    900: Color(0xff021031)
  }),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: const Color(0xff0944cb),
  primaryColorLight: const Color(0xffcedcfd),
  primaryColorDark: const Color(0xff063193),
  cardColor: const Color(0xffe2e8f0),
  errorColor: const Color(0xffef4444),
  scaffoldBackgroundColor: const Color(0xffe2e8f0),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff0944cb),
    secondary: Color(0xff0b52f4),
    surface: Color(0xffcbd5e1),
    background: Color(0xffe2e8f0),
    error: Color(0xffef4444),
    onPrimary: Color(0xffffffff),
    onSecondary: Color(0xffffffff),
    onSurface: Color(0xff0f172a),
    onBackground: Color(0xffffffff),
    onError: Color(0xfff1f5f9),
  ),
);

final dark = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: const Color(0xff9dbafb),
    primaryColorLight: const Color(0xffcedcfd),
    primaryColorDark: const Color(0xff6c97f9),
    scaffoldBackgroundColor: const Color(0xff1e293b),
    errorColor: const Color(0xfffca5a5),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9dbafb),
      secondary: Color(0xff6c97f9),
      surface: Color(0xff0f172a),
      background: Color(0xff1e293b),
      error: Color(0xfffca5a5),
      onPrimary: Color(0xff0f172a),
      onSecondary: Color(0xff0f172a),
      onSurface: Color(0xffffffff),
      onBackground: Color(0xffffffff),
      onError: Color(0xfff1f5f9),
    ));
