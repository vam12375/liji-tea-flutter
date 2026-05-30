import 'package:flutter/material.dart';

import 'tea_product.dart';

/// Order lifecycle status (订单状态).
enum OrderStatus {
  pendingPay, // 待付款
  pendingShip, // 待发货
  pendingReceive, // 待收货
  pendingReview, // 待评价
  completed, // 已完成
}

extension OrderStatusLabel on OrderStatus {
  String get label => switch (this) {
        OrderStatus.pendingPay => '待付款',
        OrderStatus.pendingShip => '待发货',
        OrderStatus.pendingReceive => '待收货',
        OrderStatus.pendingReview => '待评价',
        OrderStatus.completed => '已完成',
      };
}

/// A placed order (我的订单).
class OrderEntry {
  const OrderEntry({
    required this.id,
    required this.status,
    required this.items,
    required this.total,
    required this.date,
  });

  final String id; // 订单号
  final OrderStatus status;
  final List<CartItem> items;
  final int total;
  final String date;
}

/// A shipping address (收货地址).
class Address {
  const Address({
    required this.name,
    required this.phone,
    required this.region,
    required this.detail,
    this.isDefault = false,
    this.tag,
  });

  final String name; // 林小茶
  final String phone; // 138****8888
  final String region; // 浙江省 杭州市 西湖区
  final String detail; // 龙井路 99 号茶语小筑 6 栋 101
  final bool isDefault;
  final String? tag; // 家 / 公司
}

/// A message in the notification centre (消息通知).
class AppNotification {
  const AppNotification({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    this.unread = false,
  });

  final String title;
  final String body;
  final String time;
  final IconData icon;
  final bool unread;
}

/// A single points ledger entry (积分明细).
class PointRecord {
  const PointRecord({required this.title, required this.date, required this.delta});

  final String title; // 购物奖励 / 兑换优惠券
  final String date;
  final int delta; // +50 / -100
}
