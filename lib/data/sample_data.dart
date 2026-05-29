import 'package:flutter/material.dart';

import '../models/tea_product.dart';

/// Static sample content used to populate the UI before a backend is wired up.
class SampleData {
  SampleData._();

  static const TeaProduct longjing = TeaProduct(
    id: 'longjing',
    name: '明前龙井',
    origin: '浙江·杭州',
    category: '绿茶',
    tagline: '清香淡雅,鲜爽回甘',
    price: 168,
    unit: '50g',
    swatch: Color(0xFFA9B89A),
    description: '甄选明前头采芽叶,遵循传统工艺,手工炒制而成。'
        '干茶扁平挺秀,色泽嫩绿光润;汤色嫩绿明亮,香气清雅持久,滋味鲜爽甘醇,回味悠长。',
    attributes: [
      ProductAttribute(label: '采摘', value: '明前头采', icon: Icons.eco_outlined),
      ProductAttribute(label: '产地', value: '西湖龙井村', icon: Icons.terrain_outlined),
      ProductAttribute(label: '口感', value: '鲜爽回甘', icon: Icons.water_drop_outlined),
      ProductAttribute(label: '香气', value: '豆香清雅', icon: Icons.spa_outlined),
    ],
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct biluochun = TeaProduct(
    id: 'biluochun',
    name: '碧螺春',
    origin: '江苏·苏州',
    category: '绿茶',
    tagline: '花果香,鲜爽生津',
    price: 128,
    unit: '50g',
    swatch: Color(0xFFB3C0A0),
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct anjiBaicha = TeaProduct(
    id: 'anji',
    name: '安吉白茶',
    origin: '浙江·安吉',
    category: '绿茶',
    tagline: '清甜鲜爽,氨基酸丰富',
    price: 138,
    unit: '50g',
    swatch: Color(0xFFAEBE9C),
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct shanshuiPot = TeaProduct(
    id: 'shanshui_pot',
    name: '山水茶壶',
    origin: '原创设计',
    category: '陶瓷',
    tagline: '山水入器,茶香相伴',
    price: 328,
    unit: '300ml',
    swatch: Color(0xFF4C5B52),
    description: '灵感源自山水之间的宁静之美,壶身纹理如远山起伏,釉色温润,手感细腻。',
    attributes: [
      ProductAttribute(label: '材质', value: '陶瓷', icon: Icons.coffee_outlined),
      ProductAttribute(label: '容量', value: '300ml', icon: Icons.local_drink_outlined),
      ProductAttribute(label: '工艺', value: '手工拉坯', icon: Icons.handyman_outlined),
      ProductAttribute(label: '风格', value: '东方极简', icon: Icons.landscape_outlined),
    ],
    specs: ['单壶 (300ml)', '礼盒装 (壶+杯2)'],
  );

  /// 今日推荐 — the featured product on the home screen.
  static const TeaProduct featured = longjing;

  /// Quick entries under the greeting.
  static const List<QuickEntry> quickEntries = [
    QuickEntry(label: '精选茶品', icon: Icons.local_cafe_outlined),
    QuickEntry(label: '茶具器物', icon: Icons.emoji_food_beverage_outlined),
    QuickEntry(label: '茶艺课程', icon: Icons.menu_book_outlined),
    QuickEntry(label: '茶生活', icon: Icons.spa_outlined),
  ];

  static const List<TeaProduct> recommended = [
    longjing,
    biluochun,
    anjiBaicha,
    shanshuiPot,
  ];

  /// 茶语 quote shown on the home screen.
  static const String teaQuote = '"茶之为饮,发乎神农氏,闻于鲁周公。"';
  static const String teaQuoteAuthor = '—— 陆羽《茶经》';
}

/// A circular quick-entry shortcut on the home screen.
class QuickEntry {
  const QuickEntry({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
