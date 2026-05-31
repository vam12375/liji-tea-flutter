import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography tokens for the 李记·TEA design system.
///
/// 中文字体: 思源宋体 (Noto Serif SC) for headings · HarmonyOS Sans
/// 替代�?Noto Sans SC for body. 英文: Cormorant Garamond / Inter.
///
/// 字体加载策略�?
/// 1. 优先使用本地字体文件（assets/fonts/�?
/// 2. 如果本地字体不可用，回退�?google_fonts
/// 3. 最终回退到系统字�?
class AppTypography {
  AppTypography._();

  // 字体家族名称（与 pubspec.yaml 中的配置对应�?
  static const String _serifFamily = 'NotoSerifSC';
  static const String _sansFamily = 'NotoSansSC';
  static const String _latinFamily = 'CormorantGaramond';

  // 是否使用本地字体（如�?assets/fonts/ 中有字体文件则为 true�?
  static const bool _useLocalFonts = true; // TODO: 添加字体文件后改�?true

  /// Serif display family used for headings and brand moments (思源宋体).
  static TextStyle serif({
    required double size,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    if (_useLocalFonts) {
      return TextStyle(
        fontFamily: _serifFamily,
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    }
    return GoogleFonts.notoSerifSc(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Sans family used for body and UI text (HarmonyOS Sans 替代).
  static TextStyle sans({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    if (_useLocalFonts) {
      return TextStyle(
        fontFamily: _sansFamily,
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    }
    return GoogleFonts.notoSansSc(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Latin serif for the LIJI·TEA wordmark and English headings.
  static TextStyle latin({
    required double size,
    FontWeight weight = FontWeight.w500,
    Color color = AppColors.textPrimary,
    double? letterSpacing,
  }) {
    if (_useLocalFonts) {
      return TextStyle(
        fontFamily: _latinFamily,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );
    }
    return GoogleFonts.cormorantGaramond(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Semantic scale (中文字体 scale from the board).
  static TextStyle get h1 => serif(size: 28, weight: FontWeight.w600, height: 1.3);
  static TextStyle get h2 => serif(size: 22, weight: FontWeight.w600, height: 1.3);
  static TextStyle get h3 => serif(size: 18, weight: FontWeight.w600, height: 1.4);
  static TextStyle get bodyLarge => sans(size: 16, height: 1.6);
  static TextStyle get body => sans(size: 14, height: 1.6, color: AppColors.textSecondary);
  static TextStyle get caption => sans(size: 12, height: 1.5, color: AppColors.textTertiary);
}
