import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/quantity_stepper.dart';
import '../widgets/status_view.dart';
import '../widgets/tea_image.dart';
import 'coupon_screen.dart';
import 'order_confirm_screen.dart';
import 'product_detail_screen.dart';

/// 购物车 — full cart with selection, quantity steppers, and an empty state.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<_Line> _lines = [
    for (final c in SampleData.cart)
      _Line(product: c.product, spec: c.spec, quantity: c.quantity, selected: true),
  ];

  int get _total {
    var sum = 0;
    for (final l in _lines) {
      if (l.selected) sum += l.product.price * l.quantity;
    }
    return sum;
  }

  bool get _allSelected => _lines.isNotEmpty && _lines.every((l) => l.selected);

  void _clear() => setState(() => _lines = []);

  @override
  Widget build(BuildContext context) {
    if (_lines.isEmpty) return const _EmptyCart();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin, AppSpacing.sm, AppSpacing.screenMargin, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('购物车 (${_lines.length})', style: AppTypography.h2),
                TextButton(onPressed: _clear, child: Text('清空', style: AppTypography.body)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Text(
                _total >= 299 ? '已满 ¥299,享免运费' : '满 ¥299 可享免运费,还差 ¥${299 - _total}',
                style: AppTypography.sans(size: 12, color: AppColors.pineGreen),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.md),
              children: [
                for (var i = 0; i < _lines.length; i++)
                  _CartRow(
                    line: _lines[i],
                    onToggle: () => setState(() => _lines[i].selected = !_lines[i].selected),
                    onQty: (q) => setState(() => _lines[i].quantity = q),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: _lines[i].product))),
                  ),
                const SizedBox(height: AppSpacing.md),
                _CouponRow(onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CouponScreen()));
                }),
              ],
            ),
          ),
          _CartBottomBar(
            allSelected: _allSelected,
            total: _total,
            onToggleAll: () {
              final next = !_allSelected;
              setState(() {
                for (final l in _lines) {
                  l.selected = next;
                }
              });
            },
            onCheckout: _total == 0
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OrderConfirmScreen(
                          lines: [
                            for (final l in _lines)
                              if (l.selected)
                                CartItem(product: l.product, spec: l.spec, quantity: l.quantity),
                          ],
                          total: _total,
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

class _Line {
  _Line({required this.product, required this.spec, required this.quantity, required this.selected});
  final TeaProduct product;
  final String spec;
  int quantity;
  bool selected;
}

class _CartRow extends StatelessWidget {
  const _CartRow({required this.line, required this.onToggle, required this.onQty, required this.onTap});

  final _Line line;
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
            onAction: () {},
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
            ],
          ),
        ],
      ),
    );
  }
}
