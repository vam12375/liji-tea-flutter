import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';
import 'coupon_screen.dart';
import 'favorites_screen.dart';
import 'logistics_screen.dart';

/// 我的 — profile, order shortcuts, and a menu list.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
        children: [
          _header(),
          const SizedBox(height: AppSpacing.md),
          _statsRow(),
          const SizedBox(height: AppSpacing.md),
          _orderCard(context),
          const SizedBox(height: AppSpacing.md),
          _menuCard(context),
        ],
      ),
    );
  }

  Widget _header() {
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
        const Icon(Icons.settings_outlined, color: AppColors.textSecondary),
      ],
    );
  }

  Widget _statsRow() {
    const items = [('128', '积分'), ('5', '优惠券'), ('12', '收藏'), ('3', '足迹')];
    return SoftCard(
      child: Row(
        children: [
          for (final it in items)
            Expanded(
              child: Column(
                children: [
                  Text(it.$1, style: AppTypography.serif(size: 20, weight: FontWeight.w700, color: AppColors.inkGreen)),
                  const SizedBox(height: 2),
                  Text(it.$2, style: AppTypography.caption),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _orderCard(BuildContext context) {
    const orders = [
      (Icons.account_balance_wallet_outlined, '待付款'),
      (Icons.inventory_2_outlined, '待发货'),
      (Icons.local_shipping_outlined, '待收货'),
      (Icons.rate_review_outlined, '待评价'),
      (Icons.support_agent_outlined, '退款/售后'),
    ];
    return SoftCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('我的订单', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
              GestureDetector(
                onTap: () {},
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
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LogisticsScreen())),
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
    final items = <(IconData, String, VoidCallback)>[
      (Icons.favorite_border, '我的收藏', () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const FavoritesScreen()))),
      (Icons.confirmation_number_outlined, '我的优惠券', () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CouponScreen()))),
      (Icons.location_on_outlined, '收货地址', () {}),
      (Icons.history_outlined, '浏览足迹', () {}),
      (Icons.feedback_outlined, '意见反馈', () {}),
      (Icons.headset_mic_outlined, '联系客服', () {}),
      (Icons.settings_outlined, '设置', () {}),
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
                    Icon(items[i].$1, size: 20, color: AppColors.pineGreen),
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
