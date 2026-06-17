import 'package:flutter/material.dart';

/// A product review (商品评价).
class Review {
  const Review({
    required this.author,
    required this.rating,
    required this.content,
    required this.date,
    this.repurchase = 0,
    this.images = 0,
  });

  final String author;
  final int rating; // 1-5
  final String content;
  final String date;
  final int repurchase; // 回购次数
  final int images; // attached image count
}

/// A solar-term page (节气): 清明 / 谷雨 / 白露 / 冬至.
class SolarTerm {
  const SolarTerm({
    required this.name,
    required this.pinyin,
    required this.poem,
    required this.recommendName,
    required this.recommendDesc,
    required this.recommendPrice,
    required this.recommendTags,
    required this.foods,
    required this.wellness,
    required this.gradient,
  });

  final String name; // 清明
  final String pinyin; // QING MING
  final String poem;
  final String recommendName; // 明前龙井
  final String recommendDesc;
  final int recommendPrice;
  final List<String> recommendTags;
  final List<TermFood> foods; // 茶食搭配
  final List<TermWellness> wellness; // 节气养生
  final List<Color> gradient;
}

class TermFood {
  const TermFood({required this.name, required this.desc});
  final String name;
  final String desc;
}

class TermWellness {
  const TermWellness({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

/// A tea growing region (茶叶产区).
class TeaRegion {
  const TeaRegion({
    required this.province,
    required this.title,
    required this.desc,
    required this.swatch,
  });

  final String province; // 安徽
  final String title; // 黄山·核心产区
  final String desc;
  final Color swatch;
}

/// A step in the brewing guide (冲泡指南).
class BrewStep {
  const BrewStep({required this.title, required this.desc, required this.icon});
  final String title;
  final String desc;
  final IconData icon;
}

/// A gift box option (茶礼定制 / 礼盒推荐).
class GiftBox {
  const GiftBox({
    required this.name,
    required this.desc,
    required this.priceFrom,
    required this.swatch,
  });

  final String name; // 山水·大雅礼盒
  final String desc;
  final int priceFrom;
  final Color swatch;
}

/// A discount coupon (优惠券).
class Coupon {
  const Coupon({
    required this.amount,
    required this.threshold,
    required this.scope,
    required this.expiry,
    this.usable = true,
  });

  final int amount; // 30
  final int threshold; // 满 299
  final String scope; // 全场通用
  final String expiry; // 2024.06.01
  final bool usable;
}
