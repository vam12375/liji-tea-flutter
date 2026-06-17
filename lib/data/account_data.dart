import 'package:flutter/material.dart';

import '../models/account_models.dart';
import '../models/tea_product.dart';
import 'sample_data.dart';

/// Static account-related sample data (订单 / 地址 / 消息 / 足迹 / 积分).
class AccountData {
  AccountData._();

  // ---------------------------------------------------------------------------
  // 我的订单 — orders
  // ---------------------------------------------------------------------------
  static const List<OrderEntry> orders = [
    OrderEntry(
      id: 'LJ20240522001',
      status: OrderStatus.pendingPay,
      items: [
        CartItem(product: SampleData.longjing, spec: '100g', quantity: 1),
      ],
      total: 298,
      date: '2024.05.22 10:05',
    ),
    OrderEntry(
      id: 'LJ20240520017',
      status: OrderStatus.pendingShip,
      items: [
        CartItem(product: SampleData.baihaoYinzhen, spec: '50g', quantity: 2),
      ],
      total: 376,
      date: '2024.05.20 14:22',
    ),
    OrderEntry(
      id: 'LJ20240518009',
      status: OrderStatus.pendingReceive,
      items: [
        CartItem(product: SampleData.shanshuiPot, spec: '单壶 (300ml)', quantity: 1),
        CartItem(product: SampleData.chaze, spec: '竹制', quantity: 1),
      ],
      total: 356,
      date: '2024.05.18 09:41',
    ),
    OrderEntry(
      id: 'LJ20240515003',
      status: OrderStatus.pendingReview,
      items: [
        CartItem(product: SampleData.dahongpao, spec: '50g', quantity: 1),
      ],
      total: 198,
      date: '2024.05.15 20:13',
    ),
    OrderEntry(
      id: 'LJ20240510021',
      status: OrderStatus.completed,
      items: [
        CartItem(product: SampleData.molihua, spec: '100g', quantity: 1),
        CartItem(product: SampleData.guihuaWulong, spec: '50g', quantity: 1),
      ],
      total: 186,
      date: '2024.05.10 11:30',
    ),
  ];

  static List<OrderEntry> ordersByStatus(OrderStatus? status) =>
      status == null ? orders : orders.where((o) => o.status == status).toList();

  // ---------------------------------------------------------------------------
  // 收货地址 — addresses
  // ---------------------------------------------------------------------------
  static const List<Address> addresses = [
    Address(
      name: '林小茶',
      phone: '138****8888',
      region: '浙江省 杭州市 西湖区',
      detail: '龙井路 99 号 茶语小筑 6 栋 101',
      isDefault: true,
      tag: '家',
    ),
    Address(
      name: '林小茶',
      phone: '139****6666',
      region: '上海市 黄浦区',
      detail: '南京东路 1 号 云茶大厦 28 层',
      tag: '公司',
    ),
  ];

  // ---------------------------------------------------------------------------
  // 消息通知 — notifications
  // ---------------------------------------------------------------------------
  static const List<AppNotification> notifications = [
    AppNotification(
      title: '订单已发货',
      body: '您的订单 LJ20240518009 已由顺丰速运发出,请注意查收。',
      time: '10:30',
      icon: Icons.local_shipping_outlined,
      unread: true,
    ),
    AppNotification(
      title: '专属优惠券到账',
      body: '恭喜获得满 299 减 30 优惠券一张,有效期 7 天。',
      time: '昨天',
      icon: Icons.confirmation_number_outlined,
      unread: true,
    ),
    AppNotification(
      title: '谷雨新茶上市',
      body: '雨前碧螺春鲜活上新,前 100 名下单赠茶样。',
      time: '05-20',
      icon: Icons.local_florist_outlined,
    ),
    AppNotification(
      title: '积分提醒',
      body: '您有 128 积分即将参与本月清零,快去积分中心兑换好礼。',
      time: '05-18',
      icon: Icons.card_giftcard_outlined,
    ),
  ];

  // ---------------------------------------------------------------------------
  // 浏览足迹 — footprints (reuse products)
  // ---------------------------------------------------------------------------
  static const List<TeaProduct> footprintsToday = [
    SampleData.longjing,
    SampleData.baihaoYinzhen,
    SampleData.shanshuiPot,
  ];

  static const List<TeaProduct> footprintsEarlier = [
    SampleData.dahongpao,
    SampleData.biluochun,
    SampleData.puerShu,
    SampleData.molihua,
  ];

  // ---------------------------------------------------------------------------
  // 积分中心 — points
  // ---------------------------------------------------------------------------
  static const int pointsBalance = 128;

  static const List<PointRecord> pointRecords = [
    PointRecord(title: '购物奖励 · 明前龙井', date: '2024.05.22', delta: 30),
    PointRecord(title: '每日签到', date: '2024.05.21', delta: 5),
    PointRecord(title: '兑换 满99减10 优惠券', date: '2024.05.18', delta: -100),
    PointRecord(title: '评价晒单奖励', date: '2024.05.15', delta: 20),
    PointRecord(title: '邀请好友', date: '2024.05.10', delta: 50),
  ];

  // ---------------------------------------------------------------------------
  // 意见反馈 / 客服
  // ---------------------------------------------------------------------------
  static const List<String> feedbackTypes = ['功能建议', '体验问题', '商品相关', '其他'];

  static const List<String> serviceQuickQuestions = [
    '如何查询物流?',
    '可以开发票吗?',
    '怎么申请退换货?',
    '茶叶如何保存?',
  ];

  static const List<String> afterSaleTypes = ['仅退款', '退货退款', '换货'];
  static const List<String> afterSaleReasons = [
    '不想要了',
    '商品与描述不符',
    '商品破损/变质',
    '物流问题',
    '其他原因',
  ];
}
