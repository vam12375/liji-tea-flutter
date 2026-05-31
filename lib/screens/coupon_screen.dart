import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../models/content_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/segment_control.dart';

/// 优惠券 — coupon list with usable / unusable / used tabs.
class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  int _tab = 0;

  static const _notes = [
    '优惠券仅可在 LIJI·TEA 官方商城使用;',
    '每笔订单仅可使用一张优惠券;',
    '优惠券不可兑换现金、不找零;',
    '如发生退款,优惠券将按规则返还。',
  ];

  @override
  Widget build(BuildContext context) {
    final usable = ContentData.coupons.where((c) => c.usable).toList();
    final unusable = ContentData.coupons.where((c) => !c.usable).toList();
    final list = switch (_tab) {
      0 => usable,
      1 => unusable,
      _ => const <Coupon>[],
    };
    return Scaffold(
      appBar: AppBar(title: Text('优惠券', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenMargin, AppSpacing.xs, AppSpacing.screenMargin, AppSpacing.sm),
              child: TextTabs(
                tabs: [
                  '可用优惠券 (${usable.length})',
                  '不可用优惠券 (${unusable.length})',
                  '已使用/已过期 (6)',
                ],
                selected: _tab,
                onSelected: (i) => setState(() => _tab = i),
              ),
            ),
            const _RedeemRow(),
            Expanded(
              child: list.isEmpty
                  ? Center(child: Text('暂无优惠券', style: AppTypography.body))
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin,
                          AppSpacing.sm, AppSpacing.screenMargin, AppSpacing.xl),
                      children: [
                        for (final c in list) _CouponCard(coupon: c),
                        const SizedBox(height: AppSpacing.lg),
                        Text('使用说明', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                        const SizedBox(height: AppSpacing.sm),
                        for (var i = 0; i < _notes.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                            child: Text('${i + 1}. ${_notes[i]}', style: AppTypography.caption),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RedeemRow extends StatelessWidget {
  const _RedeemRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.xs),
      child: Row(
        children: [
          Text('优惠券兑换', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
          const SizedBox(width: AppSpacing.xs),
          const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.image),
                border: Border.all(color: AppColors.divider),
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                style: AppTypography.sans(size: 13),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: '输入兑换码',
                  hintStyle: AppTypography.sans(size: 13, color: AppColors.textTertiary),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.inkGreen,
                borderRadius: BorderRadius.circular(AppRadius.image),
              ),
              alignment: Alignment.center,
              child: Text('兑换', style: AppTypography.sans(size: 13, color: AppColors.riceWhite)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CouponCard extends StatelessWidget {
  const _CouponCard({required this.coupon});
  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    final accent = coupon.usable ? AppColors.inkGreen : AppColors.textTertiary;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.image),
        border: Border.all(color: AppColors.divider),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('¥',
                          style: AppTypography.serif(
                              size: 18, weight: FontWeight.w600, color: accent)),
                      Text('${coupon.amount}',
                          style: AppTypography.serif(
                              size: 40, weight: FontWeight.w700, color: accent)),
                    ],
                  ),
                ),
              ),
              Container(width: 1, height: 72, color: AppColors.divider),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('满 ¥${coupon.threshold} 可用',
                          style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(coupon.scope, style: AppTypography.caption),
                      const SizedBox(height: AppSpacing.xxs),
                      Text('有效期至 ${coupon.expiry}', style: AppTypography.caption),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: coupon.usable
                ? SizedBox(
                    width: 44,
                    height: 44,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: const Size(44, 44),
                          painter: _CornerPainter(AppColors.inkGreen),
                        ),
                        const Positioned(
                          top: 4,
                          right: 4,
                          child: Icon(Icons.check, size: 14, color: AppColors.riceWhite),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.ricePaperGray,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(AppRadius.image),
                        bottomLeft: Radius.circular(AppRadius.image),
                      ),
                    ),
                    child: Text('不可用',
                        style: AppTypography.sans(size: 11, color: AppColors.textSecondary)),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Folded triangular corner ribbon.
class _CornerPainter extends CustomPainter {
  const _CornerPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CornerPainter oldDelegate) => oldDelegate.color != color;
}
