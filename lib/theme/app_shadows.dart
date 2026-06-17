import 'package:flutter/material.dart';

/// Shadow tokens for the 李记·TEA design system.
///
/// 阴影系统 - 统一的投影规范，营造层次感和深度。
class AppShadows {
  AppShadows._();

  /// 卡片阴影（轻微）- 用于普通卡片、列表项
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x08000000), // 黑色 5% 透明度
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  /// 卡片阴影（中等）- 用于悬浮卡片、重要内容
  static const List<BoxShadow> cardElevated = [
    BoxShadow(
      color: Color(0x0F000000), // 黑色 6% 透明度
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  /// 浮动元素阴影 - 用于弹窗、悬浮按钮
  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x14000000), // 黑色 8% 透明度
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  /// 深色模式卡片阴影
  static const List<BoxShadow> cardDark = [
    BoxShadow(
      color: Color(0x40000000), // 黑色 25% 透明度
      blurRadius: 12,
      offset: Offset(0, 2),
    ),
  ];

  /// 无阴影
  static const List<BoxShadow> none = [];
}
