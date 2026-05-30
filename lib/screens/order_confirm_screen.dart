import 'package:flutter/material.dart';

import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';
import 'payment_screen.dart';

/// 订单确认 — order confirmation before payment.
class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key, required this.lines, required this.total});

  final List<CartItem> lines;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('订单确认', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.xs, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            SoftCard(
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: AppColors.inkGreen),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('林小茶', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                          const SizedBox(width: AppSpacing.sm),
                          Text('188 8888 8888', style: AppTypography.body),
                        ]),
                        const SizedBox(height: AppSpacing.xxs),
                        Text('浙江省杭州市西湖区龙井路 88 号', style: AppTypography.body),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              child: Column(
                children: [
                  _row('配送方式', '快递配送  免运费'),
                  const Divider(height: AppSpacing.lg),
                  _row('送达时间', '预计 5 月 25 日(周六)09:00-18:00'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('商品清单', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.sm),
                  for (final l in lines)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('${l.product.name}  ${l.spec}',
                                style: AppTypography.sans(size: 14))),
                          Text('¥${l.product.price}', style: AppTypography.sans(size: 14)),
                          Text('  ×${l.quantity}', style: AppTypography.caption),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              child: Row(
                children: [
                  Text('订单备注', style: AppTypography.sans(size: 14)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text('选填:给商家留言(如配送要求等)',
                        style: AppTypography.sans(size: 13, color: AppColors.textTertiary)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomBar(
        total: total,
        onSubmit: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PaymentScreen(total: total)),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.sans(size: 14)),
        Text(value, style: AppTypography.body),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.total, required this.onSubmit});
  final int total;
  final VoidCallback onSubmit;

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
          const Spacer(),
          PrimaryButton(label: '提交订单', onPressed: onSubmit),
        ],
      ),
    );
  }
}
