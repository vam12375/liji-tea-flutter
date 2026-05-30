import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// 茶席 / 茶道美学 — editorial gallery of aesthetic concepts.
class TeaSpaceScreen extends StatelessWidget {
  const TeaSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('茶道美学', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Text('和敬清寂', style: AppTypography.h2),
            const SizedBox(height: AppSpacing.xs),
            Text('于一席茶间,体味东方生活美学的四重境界。',
                style: AppTypography.body),
            const SizedBox(height: AppSpacing.lg),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.82,
              children: [
                for (final a in ContentData.cultureAesthetics)
                  _AestheticCard(
                    word: a['word']!,
                    title: a['title']!,
                    desc: a['desc']!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AestheticCard extends StatelessWidget {
  const _AestheticCard({required this.word, required this.title, required this.desc});
  final String word;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.pineGreen, AppColors.inkGreen],
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(word,
              style: AppTypography.serif(size: 48, weight: FontWeight.w700, color: AppColors.gold)),
          const Spacer(),
          Text(title, style: AppTypography.sans(size: 15, weight: FontWeight.w600, color: AppColors.riceWhite)),
          const SizedBox(height: 2),
          Text(desc, style: AppTypography.sans(size: 12, color: AppColors.riceGray)),
        ],
      ),
    );
  }
}
