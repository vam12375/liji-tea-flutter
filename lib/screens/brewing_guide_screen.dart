import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../models/content_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';

/// 冲泡指南 — product-specific brewing guide (params + step timeline).
class BrewingGuideScreen extends StatelessWidget {
  const BrewingGuideScreen({super.key});

  static const _params = [
    (Icons.grass_outlined, '投茶量', '3g'),
    (Icons.thermostat_outlined, '水温', '80-85℃'),
    (Icons.water_drop_outlined, '水质', '山泉水'),
    (Icons.coffee_outlined, '冲泡器具', '玻璃杯/盖碗'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(
        title: Text('冲泡指南', style: AppTypography.h3),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: AppColors.charcoalBlack, size: 20),
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share_outlined, color: AppColors.charcoalBlack, size: 20),
            splashRadius: 20,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.xs, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            // product header
            Row(
              children: [
                Text('明前龙井', style: AppTypography.h2),
                const SizedBox(width: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.pineGreen.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Text('绿茶',
                      style: AppTypography.sans(size: 11, color: AppColors.pineGreen)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text('鲜爽回甘 · 豆香清雅', style: AppTypography.body),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: Image.asset('assets/images/brew_hero.png',
                  width: double.infinity, height: 180, fit: BoxFit.cover),
            ),
            const SizedBox(height: AppSpacing.md),
            // param row
            SoftCard(
              child: Row(
                children: [
                  for (var i = 0; i < _params.length; i++) ...[
                    Expanded(
                      child: Column(
                        children: [
                          Icon(_params[i].$1, size: 22, color: AppColors.pineGreen),
                          const SizedBox(height: AppSpacing.xs),
                          Text(_params[i].$2, style: AppTypography.caption),
                          const SizedBox(height: 2),
                          Text(_params[i].$3,
                              style: AppTypography.sans(size: 13, weight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    if (i != _params.length - 1)
                      Container(width: 1, height: 44, color: AppColors.divider),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // steps
            for (var i = 0; i < ContentData.brewSteps.length; i++)
              _StepRow(
                index: i + 1,
                step: ContentData.brewSteps[i],
                isLast: i == ContentData.brewSteps.length - 1,
              ),
            const SizedBox(height: AppSpacing.sm),
            // tip
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.ricePaperGray.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline, size: 18, color: AppColors.gold),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text('小贴士:可根据个人口味调整投茶量与浸泡时间。',
                        style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
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

class _StepRow extends StatelessWidget {
  const _StepRow({required this.index, required this.step, required this.isLast});
  final int index;
  final BrewStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(index.toString().padLeft(2, '0'),
                    style: AppTypography.sans(
                        size: 12, weight: FontWeight.w600, color: AppColors.gold)),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: AppColors.divider)),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(step.icon, size: 26, color: AppColors.pineGreen),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step.title,
                            style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(step.desc, style: AppTypography.body),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
