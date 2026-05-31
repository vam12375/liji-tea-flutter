import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/section_header.dart';
import 'brand_story_screen.dart';
import 'brewing_guide_screen.dart';
import 'solar_term_screen.dart';
import 'tea_aesthetics_screen.dart';
import 'tea_region_screen.dart';

/// 茶文化 — culture hub linking to aesthetics, solar terms, brewing,
/// regions and the brand story.
class TeaCultureScreen extends StatelessWidget {
  const TeaCultureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.sm, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
          if (Navigator.of(context).canPop())
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                behavior: HitTestBehavior.opaque,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.arrow_back, color: AppColors.charcoalBlack, size: 22),
                ),
              ),
            ),
          Text('茶文化', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.xs),
          Text('一盏茶汤,半卷诗书,在茶香中体味东方生活美学。', style: AppTypography.body),
          const SizedBox(height: AppSpacing.lg),
          _Banner(
            title: '茶道美学',
            subtitle: '和敬清寂 · 四重境界',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TeaAestheticsScreen())),
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(
            title: '二十四节气',
            actionLabel: '全部',
            onAction: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SolarTermScreen())),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (var i = 0; i < ContentData.solarTerms.length; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SolarTermScreen(initialIndex: i))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.image),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ContentData.solarTerms[i].gradient,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(ContentData.solarTerms[i].name,
                                style: AppTypography.serif(
                                    size: 18, weight: FontWeight.w700, color: AppColors.inkGreen)),
                            const SizedBox(height: 2),
                            Text(ContentData.solarTerms[i].pinyin,
                                style: AppTypography.latin(size: 9, color: AppColors.pineGreen)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _EntryTile(
            icon: Icons.water_drop_outlined,
            title: '冲泡指南',
            subtitle: '不同茶类的水温 · 投茶 · 时间',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BrewingGuideScreen())),
          ),
          _EntryTile(
            icon: Icons.terrain_outlined,
            title: '茶叶产区',
            subtitle: '循着山川,探寻茶香源头',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TeaRegionScreen())),
          ),
          _EntryTile(
            icon: Icons.menu_book_outlined,
            title: '品牌故事',
            subtitle: '李记·TEA 的一脉茶香',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BrandStoryScreen())),
          ),
          ],
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.title, required this.subtitle, required this.onTap});
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 176,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.pineGreen, AppColors.inkGreen],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('和', style: AppTypography.serif(size: 40, weight: FontWeight.w700, color: AppColors.gold)),
            const Spacer(),
            Text(title, style: AppTypography.serif(size: 20, weight: FontWeight.w600, color: AppColors.riceWhite)),
            const SizedBox(height: 2),
            Text(subtitle, style: AppTypography.sans(size: 13, color: AppColors.riceGray)),
          ],
        ),
      ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.ricePaperGray.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppRadius.image),
              ),
              child: Icon(icon, color: AppColors.pineGreen),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
