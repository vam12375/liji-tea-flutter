import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';
import '../widgets/tea_image.dart';
import 'product_detail_screen.dart';

/// AI 茶推荐 — recommends a tea for the user's current state.
class AiRecommendScreen extends StatelessWidget {
  const AiRecommendScreen({super.key});

  TeaProduct _byName(String name) =>
      SampleData.allProducts.firstWhere((p) => p.name == name, orElse: () => SampleData.featured);

  static const _states = [
    (Icons.wb_sunny_outlined, '天气', '晴 22°C'),
    (Icons.sentiment_satisfied_outlined, '心情', '平静'),
    (Icons.schedule, '时间', '上午'),
    (Icons.nightlight_outlined, '睡眠', '良好'),
  ];

  static const _more = [
    ('白毫银针', '安神宁静'),
    ('陈年普洱熟茶', '暖胃助消化'),
    ('桂花乌龙', '舒缓放松'),
  ];

  @override
  Widget build(BuildContext context) {
    final hero = _byName('明前龙井');
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('AI 茶推荐', style: AppTypography.h3),
            const SizedBox(width: 4),
            const Icon(Icons.eco_outlined, color: AppColors.pineGreen, size: 18),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.history, size: 18, color: AppColors.textSecondary),
            label: Text('我的记录', style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.xs, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Text('为你推荐最适合此刻的茶', style: AppTypography.body),
            const SizedBox(height: AppSpacing.lg),
            Text('此刻,适合一杯清润的绿茶', style: AppTypography.h2),
            const SizedBox(height: AppSpacing.xxs),
            Text('根据你的状态推荐', style: AppTypography.caption),
            const SizedBox(height: AppSpacing.md),
            // featured recommendation
            SoftCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: TeaImage(swatch: hero.swatch, radius: AppRadius.image, iconSize: 36),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hero.name, style: AppTypography.sans(size: 17, weight: FontWeight.w600)),
                        const SizedBox(height: AppSpacing.xxs),
                        _Tag(hero.category),
                        const SizedBox(height: AppSpacing.xs),
                        Text('鲜爽回甘,清新明朗',
                            style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
                        Text('适合此刻的你',
                            style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
                        const SizedBox(height: AppSpacing.sm),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(product: hero))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('查看详情',
                                  style: AppTypography.sans(
                                      size: 13, weight: FontWeight.w600, color: AppColors.inkGreen)),
                              const Icon(Icons.chevron_right, size: 16, color: AppColors.inkGreen),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // current state
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('你当前的状态', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                Text('编辑', style: AppTypography.caption),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            SoftCard(
              child: Row(
                children: [
                  for (final s in _states)
                    Expanded(
                      child: Column(
                        children: [
                          Icon(s.$1, color: AppColors.pineGreen, size: 24),
                          const SizedBox(height: AppSpacing.xs),
                          Text(s.$2, style: AppTypography.caption),
                          const SizedBox(height: 2),
                          Text(s.$3, style: AppTypography.sans(size: 12, weight: FontWeight.w600)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('更多推荐', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < _more.length; i++) ...[
                  Expanded(child: _MoreCard(product: _byName(_more[i].$1), effect: _more[i].$2)),
                  if (i != _more.length - 1) const SizedBox(width: AppSpacing.sm),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.pineGreen.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(label, style: AppTypography.sans(size: 11, color: AppColors.pineGreen)),
    );
  }
}

class _MoreCard extends StatelessWidget {
  const _MoreCard({required this.product, required this.effect});
  final TeaProduct product;
  final String effect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: TeaImage(swatch: product.swatch, radius: AppRadius.image, iconSize: 28),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(product.name,
                style: AppTypography.sans(size: 13, weight: FontWeight.w600),
                maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(product.category, style: AppTypography.caption),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: Text(effect,
                      style: AppTypography.sans(size: 11, color: AppColors.textSecondary),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: AppColors.riceWhite, size: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
