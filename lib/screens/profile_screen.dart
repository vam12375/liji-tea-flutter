import 'package:flutter/material.dart';

import '../models/account_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/app_icon.dart';
import '../widgets/soft_card.dart';
import 'address_screen.dart';
import 'after_sale_screen.dart';
import 'coupon_screen.dart';
import 'customer_service_screen.dart';
import 'favorites_screen.dart';
import 'feedback_screen.dart';
import 'footprint_screen.dart';
import 'notification_screen.dart';
import 'order_list_screen.dart';
import 'points_screen.dart';
import 'settings_screen.dart';

/// 我的 — profile, order shortcuts, and a menu list.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
        children: [
          _header(context),
          const SizedBox(height: AppSpacing.md),
          _statsRow(context),
          const SizedBox(height: AppSpacing.md),
          _orderCard(context),
          const SizedBox(height: AppSpacing.md),
          _menuCard(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
          child: Center(
            child: Text('茶',
                style: AppTypography.serif(size: 26, weight: FontWeight.w600, color: AppColors.gold)),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text('林小茶', style: AppTypography.h3),
                const SizedBox(width: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Text('VIP 3',
                      style: AppTypography.sans(size: 11, weight: FontWeight.w600, color: AppColors.gold)),
                ),
              ]),
              const SizedBox(height: AppSpacing.xxs),
              Text('茶龄 365 天 · 一杯清茶,半日闲', style: AppTypography.caption),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const AppIcon(AppIcon.message, color: AppColors.textSecondary),
              onPressed: () => _push(context, const NotificationScreen()),
            ),
            IconButton(
              icon: const AppIcon(AppIcon.settings, color: AppColors.textSecondary),
              onPressed: () => _push(context, const SettingsScreen()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statsRow(BuildContext context) {
    final items = <(String, String, VoidCallback)>[
      ('128', '积分', () => _push(context, const PointsScreen())),
      ('5', '优惠券', () => _push(context, const CouponScreen())),
      ('12', '收藏', () => _push(context, const FavoritesScreen())),
      ('3', '足迹', () => _push(context, const FootprintScreen())),
    ];
    return SoftCard(
      child: Row(
        children: [
          for (final it in items)
            Expanded(
              child: GestureDetector(
                onTap: it.$3,
                child: Column(
                  children: [
                    Text(it.$1, style: AppTypography.serif(size: 20, weight: FontWeight.w700, color: AppColors.inkGreen)),
                    const SizedBox(height: 2),
                    Text(it.$2, style: AppTypography.caption),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _orderCard(BuildContext context) {
    final orders = <(IconData, String, VoidCallback)>[
      (Icons.account_balance_wallet_outlined, '待付款',
          () => _push(context, const OrderListScreen(initialStatus: OrderStatus.pendingPay))),
      (Icons.inventory_2_outlined, '待发货',
          () => _push(context, const OrderListScreen(initialStatus: OrderStatus.pendingShip))),
      (Icons.local_shipping_outlined, '待收货',
          () => _push(context, const OrderListScreen(initialStatus: OrderStatus.pendingReceive))),
      (Icons.rate_review_outlined, '待评价',
          () => _push(context, const OrderListScreen(initialStatus: OrderStatus.pendingReview))),
      (Icons.support_agent_outlined, '退款/售后', () => _push(context, const AfterSaleScreen())),
    ];
    return SoftCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('我的订单', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
              GestureDetector(
                onTap: () => _push(context, const OrderListScreen()),
                child: Row(children: [
                  Text('全部订单', style: AppTypography.caption),
                  const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
                ]),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              for (final o in orders)
                Expanded(
                  child: GestureDetector(
                    onTap: o.$3,
                    child: Column(
                      children: [
                        Icon(o.$1, size: 24, color: AppColors.pineGreen),
                        const SizedBox(height: AppSpacing.xs),
                        Text(o.$2, style: AppTypography.sans(size: 11)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context) {
    const iconColor = AppColors.pineGreen;
    final items = <(Widget, String, VoidCallback)>[
      (const AppIcon(AppIcon.favorite, size: 20, color: iconColor), '我的收藏', () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const FavoritesScreen()))),
      (const Icon(Icons.confirmation_number_outlined, size: 20, color: iconColor), '我的优惠券', () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CouponScreen()))),
      (const AppIcon(AppIcon.location, size: 20, color: iconColor), '收货地址', () => _push(context, const AddressScreen())),
      (const Icon(Icons.history_outlined, size: 20, color: iconColor), '浏览足迹', () => _push(context, const FootprintScreen())),
      (const Icon(Icons.feedback_outlined, size: 20, color: iconColor), '意见反馈', () => _push(context, const FeedbackScreen())),
      (const Icon(Icons.headset_mic_outlined, size: 20, color: iconColor), '联系客服', () => _push(context, const CustomerServiceScreen())),
      (const AppIcon(AppIcon.settings, size: 20, color: iconColor), '设置', () => _push(context, const SettingsScreen())),
    ];
    return SoftCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            InkWell(
              onTap: items[i].$3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  border: i == items.length - 1
                      ? null
                      : const Border(bottom: BorderSide(color: AppColors.divider)),
                ),
                child: Row(
                  children: [
                    items[i].$1,
                    const SizedBox(width: AppSpacing.sm),
                    Text(items[i].$2, style: AppTypography.sans(size: 14)),
                    const Spacer(),
                    const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
