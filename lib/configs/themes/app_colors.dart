import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF505CDC);
  static const Color secondary = Color(0xFFF6BA16);

  // Background

  // Text
  static const Color primaryText = Color(0xFF3E3E3E);

  // Border
  static const Color primaryBorder = primary;

  // Button
  static const Color primaryButton = primary;
  static const Color disabledButton = Color(0xFFC2C2C2);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
