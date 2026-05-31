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
import 'gift_customize_screen.dart';
import 'notification_screen.dart';
import 'order_list_screen.dart';
import 'points_screen.dart';
import 'settings_screen.dart';

/// 我的 — light profile header with a stats grid (积分 / 优惠券 / 收藏 / 足迹),
/// three feature entries (我的茶席 / 我的拼团 / 推荐有礼), order shortcuts and a menu list.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.onSelectTab});

  /// Switches the root bottom-nav tab (e.g. jump to 茶席). Index 2 = 茶席.
  final ValueChanged<int>? onSelectTab;

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  void _comingSoon(BuildContext context, String name) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('「$name」敬请期待')));
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.riceWhite,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _header(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: _statsCard(context),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: _quickEntries(context),
          ),
          const SizedBox(height: AppSpacing.lg),
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
    );
  }

  Widget _header(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          AppSpacing.lg, topInset + AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _circleIcon(Icons.notifications_none_rounded,
                  () => _push(context, const NotificationScreen())),
              const SizedBox(width: AppSpacing.sm),
              _circleIcon(Icons.settings_outlined,
                  () => _push(context, const SettingsScreen())),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.ricePaperGray.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/images/logo_mark.png'),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('茶人小李',
                            style: AppTypography.serif(
                                size: 22,
                                weight: FontWeight.w600,
                                color: AppColors.charcoalBlack)),
                        const SizedBox(width: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                          ),
                          child: Text('黄金茶友',
                              style: AppTypography.sans(
                                  size: 11, weight: FontWeight.w600, color: AppColors.gold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text('欢迎来到 LIJI · TEA',
                        style: AppTypography.latin(size: 13, color: AppColors.textTertiary)),
                  ],
                ),
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
          color: AppColors.ricePaperGray.withValues(alpha: 0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: AppColors.charcoalBlack),
      ),
    );
  }

  Widget _statsCard(BuildContext context) {
    final stats = <(String, String, VoidCallback)>[
      ('860', '积分', () => _push(context, const PointsScreen())),
      ('3', '优惠券', () => _push(context, const CouponScreen())),
      ('12', '收藏', () => _push(context, const FavoritesScreen())),
      ('24', '足迹', () => _push(context, const FootprintScreen())),
    ];
    return SoftCard(
      child: Row(
        children: [
          for (final s in stats)
            Expanded(
              child: GestureDetector(
                onTap: s.$3,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    Text(s.$1,
                        style: AppTypography.serif(
                            size: 22, weight: FontWeight.w700, color: AppColors.inkGreen)),
                    const SizedBox(height: 2),
                    Text(s.$2, style: AppTypography.caption),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _quickEntries(BuildContext context) {
    final entries = <(IconData, String, VoidCallback)>[
      (Icons.local_cafe_outlined, '我的茶席',
          () => onSelectTab?.call(2)),
      (Icons.groups_outlined, '我的拼团', () => _comingSoon(context, '我的拼团')),
      (Icons.card_giftcard_outlined, '推荐有礼', () => _comingSoon(context, '推荐有礼')),
    ];
    return Row(
      children: [
        for (var i = 0; i < entries.length; i++) ...[
          Expanded(
            child: GestureDetector(
              onTap: entries[i].$3,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Icon(entries[i].$1, size: 24, color: AppColors.pineGreen),
                    const SizedBox(height: AppSpacing.xs),
                    Text(entries[i].$2, style: AppTypography.sans(size: 12)),
                  ],
                ),
              ),
            ),
          ),
          if (i != entries.length - 1) const SizedBox(width: AppSpacing.sm),
        ],
      ],
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
      (Icons.card_giftcard_outlined, '茶礼定制', () => _push(context, const GiftLandingScreen())),
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
