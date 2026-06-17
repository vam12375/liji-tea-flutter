import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/sample_data.dart';
import '../navigation/app_router.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/quantity_stepper.dart';
import '../widgets/status_view.dart';
import '../widgets/tea_image.dart';

/// 购物车 — full cart with selection, quantity steppers, and an empty state.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final lines = appState.cart;
    final total = appState.cartTotal;
    if (lines.isEmpty) return const _EmptyCart();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin, AppSpacing.sm, AppSpacing.screenMargin, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('购物车 (${lines.length})', style: AppTypography.h2),
                TextButton(
                  onPressed: appState.clearCart,
                  child: Text('清空', style: AppTypography.body),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Text(
                total >= 299 ? '已满 ¥299,享免运费' : '满 ¥299 可享免运费,还差 ¥${299 - total}',
                style: AppTypography.sans(size: 12, color: AppColors.pineGreen),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                              AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.md),
              children: [
                for (final line in lines)
                  _CartRow(
                    line: line,
                    onToggle: () => appState.setCartLineSelected(
                      line.product.id,
                      line.spec,
                      !line.selected,
                    ),
                    onQty: (q) => appState.setCartQuantity(line.product.id, line.spec, q),
                    onTap: () => context.pushNamed(
                      AppRoutes.product,
                      pathParameters: {'id': line.product.id},
                      extra: line.product,
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                _CouponRow(onTap: () {
                  context.pushNamed(AppRoutes.coupons);
                }),
              ],
            ),
          ),
          _CartBottomBar(
            allSelected: appState.allCartSelected,
            total: total,
            onToggleAll: () {
              appState.setAllCartSelected(!appState.allCartSelected);
            },
            onCheckout: total == 0
                ? null
                : () => context.pushNamed(
                      AppRoutes.orderConfirm,
                      extra: OrderConfirmPayload(
                        lines: appState.selectedCartItems,
                        total: total,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({required this.line, required this.onToggle, required this.onQty, required this.onTap});

  final CartLine line;
  final VoidCallback onToggle;
  final ValueChanged<int> onQty;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Check(selected: line.selected, onTap: onToggle),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: 72,
              height: 72,
              child: TeaImage(swatch: line.product.swatch, radius: AppRadius.image, iconSize: 28),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(line.product.name, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(line.spec, style: AppTypography.caption),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Text('¥${line.product.price}',
                        style: AppTypography.serif(
                            size: 17, weight: FontWeight.w700, color: AppColors.inkGreen)),
                    const Spacer(),
                    QuantityStepper(value: line.quantity, onChanged: onQty),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Check extends StatelessWidget {
  const _Check({required this.selected, required this.onTap});
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: selected ? AppColors.inkGreen : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: selected ? AppColors.inkGreen : AppColors.textTertiary),
        ),
        child: selected
            ? const Icon(Icons.check, size: 14, color: AppColors.riceWhite)
            : null,
      ),
    );
  }
}

class _CouponRow extends StatelessWidget {
  const _CouponRow({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            const Icon(Icons.confirmation_number_outlined, size: 18, color: AppColors.inkGreen),
            const SizedBox(width: AppSpacing.xs),
            Text('优惠券', style: AppTypography.sans(size: 14)),
            const Spacer(),
            Text('2 张可用', style: AppTypography.caption),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _CartBottomBar extends StatelessWidget {
  const _CartBottomBar({
    required this.allSelected,
    required this.total,
    required this.onToggleAll,
    required this.onCheckout,
  });

  final bool allSelected;
  final int total;
  final VoidCallback onToggleAll;
  final VoidCallback? onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.sm,
          AppSpacing.screenMargin, AppSpacing.sm + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: AppColors.riceWhite,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          _Check(selected: allSelected, onTap: onToggleAll),
          const SizedBox(width: AppSpacing.xs),
          Text('全选', style: AppTypography.sans(size: 14)),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('合计: ', style: AppTypography.caption),
                  Text('¥$total',
                      style: AppTypography.serif(
                          size: 22, weight: FontWeight.w700, color: AppColors.inkGreen)),
                ],
              ),
              Text('已优惠 ¥30', style: AppTypography.caption),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          PrimaryButton(label: '去结算', onPressed: onCheckout),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenMargin, AppSpacing.sm, AppSpacing.screenMargin, AppSpacing.xl),
        children: [
          Text('购物车', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.xxl),
          StatusView(
            icon: Icons.shopping_basket_outlined,
            title: '购物车还是空的',
            subtitle: '去挑选心仪的茶叶,开启一段茶香之旅吧',
            actionLabel: '去逛逛',
            onAction: () => context.goNamed(AppRoutes.category),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Center(child: Text('— 为你推荐 —', style: AppTypography.caption)),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              for (final p in SampleData.recommended.take(3))
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                    child: GestureDetector(
                      onTap: () => context.pushNamed(
                        AppRoutes.product,
                        pathParameters: {'id': p.id},
                        extra: p,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: TeaImage(swatch: p.swatch, radius: AppRadius.image, iconSize: 28),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(p.name, style: AppTypography.sans(size: 13, weight: FontWeight.w600)),
                          Text('¥${p.price}',
                              style: AppTypography.serif(
                                  size: 14, weight: FontWeight.w600, color: AppColors.inkGreen)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
