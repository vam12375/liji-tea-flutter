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

  // 按钮和输入框
  static const double button = 8; // 主按钮、次按钮
  static const double input = 8; // 输入框
  static const double chip = 999; // 标签、分段控制器（胶囊形）

  // 卡片
  static const double cardSmall = 12; // 小卡片、图片
  static const double cardMedium = 16; // 中等卡片、产品卡片
  static const double cardLarge = 20; // 大卡片、故事卡片

  // 弹窗
  static const double modal = 16; // 底部弹窗、对话框

  // 兼容旧代码（待迁移）
  @Deprecated('Use cardLarge instead')
  static const double card = 20;
  @Deprecated('Use cardMedium instead')
  static const double productCard = 16;
  @Deprecated('Use cardSmall instead')
  static const double image = 12;
}

/// Component size tokens.
class AppSize {
  AppSize._();

  // 按钮高度
  static const double buttonLarge = 48; // 主要 CTA
  static const double buttonMedium = 40; // 表单、对话框
  static const double buttonSmall = 32; // 卡片内操作

  // 图标尺寸
  static const double iconSmall = 20;
  static const double iconMedium = 24;
  static const double iconLarge = 28;

  // 触达区域
  static const double touchTarget = 48; // 最小触达区域（无障碍）
}
