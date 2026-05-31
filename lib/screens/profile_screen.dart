import 'package:flutter/material.dart';

import '../models/account_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';
import 'address_screen.dart';
import 'after_sale_screen.dart';
import 'coupon_screen.dart';
import 'customer_service_screen.dart';
import 'favorites_screen.dart';
import 'footprint_screen.dart';
import 'order_list_screen.dart';
import 'settings_screen.dart';

/// 我的 — dark-green profile header, order shortcuts card, and a menu list.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.riceWhite,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _header(context),
          Transform.translate(
            offset: const Offset(0, -24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                  child: _orderCard(context),
                ),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                  child: _menuList(context),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      color: AppColors.inkGreen,
      padding: EdgeInsets.fromLTRB(
          AppSpacing.lg, topInset + AppSpacing.sm, AppSpacing.lg, AppSpacing.xl + AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _circleIcon(Icons.settings_outlined,
                  () => _push(context, const SettingsScreen())),
              const SizedBox(width: AppSpacing.sm),
              _circleIcon(Icons.chat_bubble_outline,
                  () => _push(context, const CustomerServiceScreen())),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(color: AppColors.riceWhite, shape: BoxShape.circle),
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/images/logo_mark.png'),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('茶人小李',
                      style: AppTypography.serif(
                          size: 22, weight: FontWeight.w600, color: AppColors.riceWhite)),
                  const SizedBox(height: AppSpacing.xxs),
                  Text('欢迎来到 LIJI · TEA',
                      style: AppTypography.latin(size: 13, color: AppColors.riceGray)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.riceWhite.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: AppColors.riceWhite),
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
      (Icons.check_box_outlined, '已完成',
          () => _push(context, const OrderListScreen(initialStatus: OrderStatus.completed))),
      (Icons.headset_mic_outlined, '售后', () => _push(context, const AfterSaleScreen())),
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
          const SizedBox(height: AppSpacing.lg),
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
                        Text(o.$2, style: AppTypography.sans(size: 12)),
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

  Widget _menuList(BuildContext context) {
    final items = <(IconData, String, VoidCallback)>[
      (Icons.star_border, '收藏夹', () => _push(context, const FavoritesScreen())),
      (Icons.history, '浏览记录', () => _push(context, const FootprintScreen())),
      (Icons.confirmation_number_outlined, '优惠券', () => _push(context, const CouponScreen())),
      (Icons.location_on_outlined, '收货地址', () => _push(context, const AddressScreen())),
      (Icons.headset_mic_outlined, '帮助与客服', () => _push(context, const CustomerServiceScreen())),
      (Icons.info_outline, '关于我们', () => _push(context, const SettingsScreen())),
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
                    horizontal: AppSpacing.md, vertical: AppSpacing.md + 2),
                decoration: BoxDecoration(
                  border: i == items.length - 1
                      ? null
                      : const Border(bottom: BorderSide(color: AppColors.divider)),
                ),
                child: Row(
                  children: [
                    Icon(items[i].$1, size: 20, color: AppColors.pineGreen),
                    const SizedBox(width: AppSpacing.md),
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
