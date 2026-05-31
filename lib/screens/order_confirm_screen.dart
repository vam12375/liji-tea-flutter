import 'package:flutter/material.dart';

import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';
import '../widgets/tea_image.dart';
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
            _label('收货地址'),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('林小茶', style: AppTypography.sans(size: 16, weight: FontWeight.w600)),
                          const SizedBox(width: AppSpacing.sm),
                          Text('188 8888 8888',
                              style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                        ]),
                        const SizedBox(height: AppSpacing.xs),
                        Text('浙江省杭州市西湖区龙井路 88 号', style: AppTypography.body),
                        const SizedBox(height: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xs, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.ricePaperGray,
                            borderRadius: BorderRadius.circular(AppRadius.image),
                          ),
                          child: Text('默认',
                              style: AppTypography.sans(size: 11, color: AppColors.textSecondary)),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _label('配送方式'),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('快递配送', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                          const SizedBox(width: AppSpacing.sm),
                          Text('免运费',
                              style: AppTypography.sans(
                                  size: 14, weight: FontWeight.w600, color: AppColors.pineGreen)),
                        ]),
                        const SizedBox(height: AppSpacing.xxs),
                        Text('预计 2-3 天送达', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  const _GreenCheck(),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _label('送达时间'),
            SoftCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('工作日、双休日与节假日均可送货',
                            style: AppTypography.sans(size: 15)),
                        const SizedBox(height: AppSpacing.xxs),
                        Text('预计 5 月 25 日(周六)09:00-18:00', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _label('商品清单'),
            SoftCard(
              child: Column(
                children: [
                  for (var i = 0; i < lines.length; i++) ...[
                    if (i > 0) const Divider(height: AppSpacing.lg),
                    _ItemRow(item: lines[i]),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _label('订单备注'),
            SoftCard(
              child: TextField(
                maxLength: 100,
                maxLines: 2,
                style: AppTypography.sans(size: 14),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  counterStyle: AppTypography.caption,
                  hintText: '选填:给商家留言(如配送要求等)',
                  hintStyle: AppTypography.sans(size: 13, color: AppColors.textTertiary),
                ),
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

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(text, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
      );
}

class _GreenCheck extends StatelessWidget {
  const _GreenCheck();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
      child: const Icon(Icons.check, size: 14, color: AppColors.riceWhite),
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.image),
          child: p.thumbAsset != null
              ? Image.asset(p.thumbAsset!, width: 56, height: 56, fit: BoxFit.cover)
              : SizedBox(
                  width: 56,
                  height: 56,
                  child: TeaImage(swatch: p.swatch, radius: AppRadius.image, iconSize: 22),
                ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(p.name, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: Text(item.spec, style: AppTypography.caption)),
            ],
          ),
        ),
        Text('¥${p.price}',
            style: AppTypography.serif(size: 15, weight: FontWeight.w600, color: AppColors.charcoalBlack)),
        const SizedBox(width: AppSpacing.xs),
        Text('×${item.quantity}', style: AppTypography.caption),
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
              Text('合计: ', style: AppTypography.sans(size: 14)),
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
