import 'package:flutter/material.dart';

/// Color tokens for the 李记·TEA design system.
///
/// Mirrors the "01 Color Tokens" section of the Foundation System board.
class AppColors {
  AppColors._();

  // Primary / 主色
  static const Color inkGreen = Color(0xFF1E3A32); // 墨绿
  static const Color pineGreen = Color(0xFF355B4C); // 松针绿

  // Neutral / 中性色
  static const Color riceWhite = Color(0xFFFBF8F3); // 米白 (background)
  static const Color ricePaperGray = Color(0xFFE7E2D9); // 宣纸灰 (surface)
  static const Color charcoalBlack = Color(0xFF1A1A1A); // 炭黑 (text)

  // Accent / 强调色
  static const Color gold = Color(0xFFC6A56B); // 烫金

  // Dark theme (夜茶模式)
  static const Color inkBlack = Color(0xFF0D0F0E);
  static const Color riceGray = Color(0xFFA8A296);

  // Derived text colors
  static const Color textPrimary = charcoalBlack;
  static const Color textSecondary = Color(0xFF6B6B66);
  static const Color textTertiary = Color(0xFF9C9A92);

  // Lines & dividers
  static const Color divider = Color(0xFFE3DED4);
  static const Color cardSurface = Color(0xFFFCFAF5);
}
