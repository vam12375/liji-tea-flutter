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
}
