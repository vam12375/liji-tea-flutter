import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/account_models.dart';
import '../navigation/app_router.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';

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
    final appState = AppStateScope.of(context);
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
                Text(appState.isLoggedIn ? '林小茶' : '未登录', style: AppTypography.h3),
                const SizedBox(width: AppSpacing.xs),
                if (appState.isLoggedIn)
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
              Text(
                appState.isLoggedIn ? '茶龄 365 天 · ${appState.phone}' : '登录后同步收藏、订单与优惠券',
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              tooltip: '消息通知',
              icon: const Icon(Icons.notifications_none, color: AppColors.textSecondary),
              onPressed: () => context.pushNamed(AppRoutes.notifications),
            ),
            IconButton(
              tooltip: '设置',
              icon: const Icon(Icons.settings_outlined, color: AppColors.textSecondary),
              onPressed: () => context.pushNamed(AppRoutes.settings),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statsRow(BuildContext context) {
    final appState = AppStateScope.of(context);
    final items = <(String, String, VoidCallback)>[
      ('128', '积分', () => context.pushNamed(AppRoutes.points)),
      ('5', '优惠券', () => context.pushNamed(AppRoutes.coupons)),
      ('${appState.favoriteIds.length}', '收藏', () => context.pushNamed(AppRoutes.favorites)),
      ('3', '足迹', () => context.pushNamed(AppRoutes.footprint)),
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
          () => _openOrders(context, OrderStatus.pendingPay)),
      (Icons.inventory_2_outlined, '待发货',
          () => _openOrders(context, OrderStatus.pendingShip)),
      (Icons.local_shipping_outlined, '待收货',
          () => _openOrders(context, OrderStatus.pendingReceive)),
      (Icons.rate_review_outlined, '待评价',
          () => _openOrders(context, OrderStatus.pendingReview)),
      (Icons.support_agent_outlined, '退款/售后', () => context.pushNamed(AppRoutes.afterSale)),
    ];
    return SoftCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('我的订单', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
              GestureDetector(
                onTap: () => context.pushNamed(AppRoutes.orders),
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
    final items = <(IconData, String, VoidCallback)>[
      (Icons.favorite_border, '我的收藏', () => context.pushNamed(AppRoutes.favorites)),
      (Icons.confirmation_number_outlined, '我的优惠券', () => context.pushNamed(AppRoutes.coupons)),
      (Icons.location_on_outlined, '收货地址', () => context.pushNamed(AppRoutes.address)),
      (Icons.history_outlined, '浏览足迹', () => context.pushNamed(AppRoutes.footprint)),
      (Icons.feedback_outlined, '意见反馈', () => context.pushNamed(AppRoutes.feedback)),
      (Icons.headset_mic_outlined, '联系客服', () => context.pushNamed(AppRoutes.service)),
      (Icons.settings_outlined, '设置', () => context.pushNamed(AppRoutes.settings)),
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

  void _openOrders(BuildContext context, OrderStatus status) {
    context.pushNamed(
      AppRoutes.orders,
      queryParameters: {'status': status.name},
    );
  }
}
