import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF0F1115);
  static const Color card = Color(0xFF1C1F26);
  static const Color primary = Color(0xFF7C4DFF);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    useMaterial3: true,
    fontFamily: 'Roboto',
  );
}
