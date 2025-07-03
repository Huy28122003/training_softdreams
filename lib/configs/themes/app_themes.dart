import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        foregroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.16,
        ),
        systemOverlayStyle: darkSystemUiOverlayStyle,
        centerTitle: true,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(
            width: 1.5,
            color: AppColors.primaryBorder,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.12,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.disabledButton,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.12,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: AppColors.primaryText,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.12,
          ),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.primary,
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.secondary,
      ),
      fontFamily: 'Inter',
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.16,
        ),
        systemOverlayStyle: lightSystemUiOverlayStyle,
        centerTitle: true,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          side: BorderSide(
            width: 1.5,
            color: AppColors.primaryBorder,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.disabledButton,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 8.0,
          ),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF1C1D23),
      primaryColor: AppColors.primary,
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
        secondary: AppColors.secondary,
      ),
      fontFamily: 'Inter',
    );
  }
}

const lightSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
  statusBarColor: Colors.transparent,
);

const darkSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
  statusBarColor: Colors.transparent,
);
