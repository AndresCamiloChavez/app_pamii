import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF27F3D);
  static const Color primaryColorLight = Color(0xFF5D60A6);
  static const Color primaryColorDark = Color(0xFF0A00B6);
  static const Color secondaryColor =
      Color(0xFF6A6DA6); // Renombrado de accentColor a secondaryColor
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColorLight,
      primaryColorDark: AppColors.primaryColorDark,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors
            .secondaryColor, // Uso de secondary en lugar de accentColor
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.primaryColorDark),
      ),
    );
  }
}
