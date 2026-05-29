/// Spacing tokens for the 李记·TEA design system.
///
/// 4pt base unit — all spacing is a multiple of 4 (间距系统).
class AppSpacing {
  AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // Layout
  static const double screenMargin = 16; // 边距 / Margin
  static const double gutter = 16; // 列间距 / Gutter
}

/// Corner radius tokens.
class AppRadius {
  AppRadius._();

  static const double card = 20; // story / seasonal / space cards
  static const double productCard = 16; // tea product card
  static const double chip = 999;
  static const double button = 999;
  static const double image = 12;
}
