import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// 品牌故事 — editorial brand narrative.
class BrandStoryScreen extends StatelessWidget {
  const BrandStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: AppColors.inkGreen,
            iconTheme: const IconThemeData(color: AppColors.riceWhite),
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.pineGreen, AppColors.inkGreen],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('李记·TEA',
                          style: AppTypography.latin(size: 34, weight: FontWeight.w600, color: AppColors.gold)),
                      const SizedBox(height: AppSpacing.xs),
                      Text('一叶一世界,一茶一人生',
                          style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin, AppSpacing.lg, AppSpacing.screenMargin, AppSpacing.xl),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _section('源起·一脉茶香',
                    '李记·TEA 始于对一杯好茶的执着。自祖辈起,我们便扎根茶山,'
                        '春采明前,秋藏陈香,以匠心守候每一片叶子的生长。'),
                _section('匠心·古法新生',
                    '我们坚持传统手工炒制,辅以现代标准化品控,'
                        '让每一道工序都有迹可循,只为还原茶叶最本真的滋味。'),
                _section('理念·东方茶生活',
                    '茶不仅是饮品,更是一种生活美学。我们希望以一杯茶,'
                        '为忙碌的当代人留一处静心之地,在和敬清寂中,回归本真。'),
                const SizedBox(height: AppSpacing.lg),
                _quote(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 3, height: 16, color: AppColors.gold),
            const SizedBox(width: AppSpacing.xs),
            Text(title, style: AppTypography.h3),
          ]),
          const SizedBox(height: AppSpacing.sm),
          Text(body, style: AppTypography.sans(size: 14, height: 1.9)),
        ],
      ),
    );
  }

  Widget _quote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.ricePaperGray.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        children: [
          Text('"茶之为饮,发乎神农氏。"',
              style: AppTypography.serif(size: 18, weight: FontWeight.w600, color: AppColors.inkGreen)),
          const SizedBox(height: AppSpacing.xs),
          Text('—— 陆羽《茶经》', style: AppTypography.caption),
        ],
      ),
    );
  }
}
