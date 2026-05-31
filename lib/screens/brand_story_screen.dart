import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// 品牌故事 — editorial brand narrative with a scenic hero.
class BrandStoryScreen extends StatelessWidget {
  const BrandStoryScreen({super.key});

  static const _values = [
    (Icons.landscape_outlined, '高山原产', '核心产区'),
    (Icons.handyman_outlined, '匠心工艺', '传统制茶'),
    (Icons.eco_outlined, '自然之味', '纯粹本真'),
    (Icons.spa_outlined, '东方美学', '生活方式'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share_outlined, color: AppColors.charcoalBlack, size: 20),
            splashRadius: 22,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // title + seal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Column(
                children: [
                  Text('品牌故事',
                      style: AppTypography.serif(size: 28, weight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text('OUR STORY',
                      style: AppTypography.latin(
                          size: 12, letterSpacing: 4, color: AppColors.textTertiary)),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9B2D2D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.spa, size: 14, color: AppColors.riceWhite),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // intro quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('一杯好茶,\n源于自然的馈赠,\n也源于对时间的敬畏。',
                        style: AppTypography.serif(size: 18, weight: FontWeight.w500, height: 1.9)),
                  ),
                  Text('LIJI · TEA',
                      style: AppTypography.latin(
                          size: 12, letterSpacing: 2, color: AppColors.pineGreen)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // scenic hero
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/brand_hero.png',
                    width: double.infinity, height: 240, fit: BoxFit.cover),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.32),
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.play_circle_outline, color: AppColors.riceWhite, size: 18),
                      const SizedBox(width: AppSpacing.xs),
                      Text('看品牌短片',
                          style: AppTypography.sans(size: 13, color: AppColors.riceWhite)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('关于我们', style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'LIJI·TEA 立于山水之间,以东方美学为底色,甄选核心产区好茶,'
                    '传递自然、纯粹、平和的生活方式。我们坚持古法手作,辅以现代品控,'
                    '只为还原茶叶最本真的滋味,让每一杯茶都成为静心之所。',
                    style: AppTypography.sans(size: 14, height: 1.9, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // value entries
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    for (final v in _values)
                      Expanded(
                        child: Column(
                          children: [
                            Icon(v.$1, color: AppColors.pineGreen, size: 26),
                            const SizedBox(height: AppSpacing.xs),
                            Text(v.$2,
                                style: AppTypography.sans(size: 13, weight: FontWeight.w600)),
                            const SizedBox(height: 2),
                            Text(v.$3, style: AppTypography.caption),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
