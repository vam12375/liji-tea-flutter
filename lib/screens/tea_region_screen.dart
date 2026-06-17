import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../models/content_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// 茶叶产区 — map-style intro plus region cards.
class TeaRegionScreen extends StatelessWidget {
  const TeaRegionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('茶叶产区', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.card),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.inkGreen, AppColors.pineGreen],
                ),
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('寻茶地图', style: AppTypography.serif(size: 22, weight: FontWeight.w600, color: AppColors.riceWhite)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('一方水土养一方茶,循着山川探寻茶香源头',
                      style: AppTypography.sans(size: 13, color: AppColors.riceWhite)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('核心产区', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.md),
            for (final r in ContentData.regions) _RegionCard(region: r),
          ],
        ),
      ),
    );
  }
}

class _RegionCard extends StatelessWidget {
  const _RegionCard({required this.region});
  final TeaRegion region;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.card),
                bottomLeft: Radius.circular(AppRadius.card),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(region.swatch, Colors.white, 0.3)!,
                  region.swatch,
                ],
              ),
            ),
            child: Center(
              child: Text(region.province,
                  style: AppTypography.serif(size: 22, weight: FontWeight.w700, color: AppColors.riceWhite)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(region.title, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(region.desc, style: AppTypography.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
