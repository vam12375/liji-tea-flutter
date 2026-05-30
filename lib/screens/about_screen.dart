import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';

/// 关于我们 — brand intro, version, and legal links.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关于我们', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.xl, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.inkGreen,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                    ),
                    child: Center(
                      child: Text('茶',
                          style: AppTypography.serif(size: 36, weight: FontWeight.w600, color: AppColors.gold)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('LIJI·TEA', style: AppTypography.latin(size: 24, weight: FontWeight.w600, letterSpacing: 2)),
                  const SizedBox(height: AppSpacing.xxs),
                  Text('李记 · 茶', style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.xs),
                  Text('版本 1.0.0', style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('品牌故事', style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '李记·TEA 始于一份对东方茶道的热爱。我们走遍名山产区,甄选时令好茶,'
                    '以「和、静、雅、清」为本,愿每一杯茶都成为你忙碌生活里的一处留白。',
                    style: AppTypography.sans(size: 14, height: 1.8, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: const [
                  _LinkRow(label: '官方网站', value: 'www.lijitea.com'),
                  _LinkRow(label: '客服电话', value: '400-888-8888'),
                  _LinkRow(label: '商务合作', value: 'hi@lijitea.com', last: true),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: Text('© 2024 李记·TEA  保留所有权利', style: AppTypography.caption),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.label, required this.value, this.last = false});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Text(label, style: AppTypography.sans(size: 14)),
          const Spacer(),
          Text(value, style: AppTypography.sans(size: 14, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
