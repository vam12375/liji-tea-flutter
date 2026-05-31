import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Assembles the [ThemeData] for 李记·TEA from the design tokens.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.riceWhite,
      colorScheme: const ColorScheme.light(
        primary: AppColors.inkGreen,
        secondary: AppColors.pineGreen,
        tertiary: AppColors.gold,
        surface: AppColors.riceWhite,
        onPrimary: AppColors.riceWhite,
        onSurface: AppColors.charcoalBlack,
      ),
      dividerColor: AppColors.divider,
      textTheme: base.textTheme.copyWith(
        displayLarge: AppTypography.h1,
        headlineSmall: AppTypography.h2,
        titleLarge: AppTypography.h3,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.body,
        labelSmall: AppTypography.caption,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.riceWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.charcoalBlack,
        centerTitle: false,
      ),
    );
  }

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.inkBlack,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        secondary: AppColors.riceGray,
        tertiary: AppColors.pineGreen,
        surface: Color(0xFF151918),
        onPrimary: AppColors.inkBlack,
        onSurface: AppColors.riceWhite,
      ),
      dividerColor: const Color(0xFF2A302D),
      textTheme: base.textTheme.copyWith(
        displayLarge: AppTypography.h1.copyWith(color: AppColors.riceWhite),
        headlineSmall: AppTypography.h2.copyWith(color: AppColors.riceWhite),
        titleLarge: AppTypography.h3.copyWith(color: AppColors.riceWhite),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.riceWhite),
        bodyMedium: AppTypography.body.copyWith(color: AppColors.riceGray),
        labelSmall: AppTypography.caption.copyWith(color: AppColors.riceGray),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.inkBlack,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.riceWhite,
        centerTitle: false,
      ),
    );
  }
}
