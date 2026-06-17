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
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              child: SegmentControl(
                segments: ['可用 (${usable.length})', '不可用 (${unusable.length})', '已使用 (6)'],
                selected: _tab,
                onSelected: (i) => setState(() => _tab = i),
              ),
            ),
            Expanded(
              child: list.isEmpty
                  ? Center(child: Text('暂无优惠券', style: AppTypography.body))
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.xl),
                      children: [for (final c in list) _CouponCard(coupon: c)],
                    ),
            ),
          ],
        ),
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
      child: Row(
        children: [
          Container(
            width: 110,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('¥', style: AppTypography.serif(size: 16, weight: FontWeight.w600, color: accent)),
                    Text('${coupon.amount}',
                        style: AppTypography.serif(size: 34, weight: FontWeight.w700, color: accent)),
                  ],
                ),
                Text('满 ¥${coupon.threshold} 可用', style: AppTypography.caption),
              ],
            ),
          ),
          Container(width: 1, height: 64, color: AppColors.divider),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(coupon.scope, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.xxs),
                  Text('有效期至 ${coupon.expiry}', style: AppTypography.caption),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: coupon.usable
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.inkGreen,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                    child: Text('去使用',
                        style: AppTypography.sans(size: 12, color: AppColors.riceWhite)),
                  )
                : Text('不可用', style: AppTypography.caption),
          ),
        ],
      ),
    );
  }
}
