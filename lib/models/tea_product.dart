import 'package:flutter/material.dart';

/// A single tea / tea-ware product.
class TeaProduct {
  const TeaProduct({
    required this.id,
    required this.name,
    required this.origin,
    required this.category,
    required this.tagline,
    required this.price,
    required this.unit,
    required this.swatch,
    this.description,
    this.attributes = const [],
    this.specs = const [],
  });

  final String id;
  final String name; // 明前龙井
  final String origin; // 浙江·杭州
  final String category; // 绿茶
  final String tagline; // 清香淡雅,鲜爽回甘
  final int price; // 168
  final String unit; // 50g
  final Color swatch; // decorative placeholder color
  final String? description;
  final List<ProductAttribute> attributes;
  final List<String> specs; // 50g / 100g / 250g
}

/// A labelled product attribute shown on the detail page (采摘 / 产地 …).
class ProductAttribute {
  const ProductAttribute({required this.label, required this.value, required this.icon});

  final String label; // 采摘
  final String value; // 明前头采
  final IconData icon;
}
