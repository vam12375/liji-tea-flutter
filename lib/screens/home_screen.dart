import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/featured_product_card.dart';
import '../widgets/section_header.dart';
import 'product_detail_screen.dart';

/// 首页 — the home screen, mirroring the LIJI·TEA home design.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return '上午好';
    if (hour < 13) return '中午好';
    if (hour < 18) return '下午好';
    return '晚上好';
  }

  void _openDetail(BuildContext context, TeaProduct product) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin,
          AppSpacing.xs,
          AppSpacing.screenMargin,
          AppSpacing.xl,
        ),
        children: [
          _TopBar(),
          const SizedBox(height: AppSpacing.lg),
          _GreetingBlock(greeting: _greeting()),
          const SizedBox(height: AppSpacing.lg),
          const _Divider(),
          const SizedBox(height: AppSpacing.lg),
          _QuickEntries(),
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(title: '今日推荐', actionLabel: '更多', onAction: () {}),
          const SizedBox(height: AppSpacing.md),
          FeaturedProductCard(
            product: SampleData.featured,
            onTap: () => _openDetail(context, SampleData.featured),
            onAdd: () => _showAdded(context, SampleData.featured),
          ),
          const SizedBox(height: AppSpacing.xl),
          const _TeaQuote(),
        ],
      ),
    );
  }

  void _showAdded(BuildContext context, TeaProduct product) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('已将「${product.name}」加入购物车', style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'LIJI·TEA',
          style: AppTypography.latin(size: 26, weight: FontWeight.w600, letterSpacing: 3, color: AppColors.inkGreen),
        ),
        const Icon(Icons.notifications_none_rounded, color: AppColors.charcoalBlack),
      ],
    );
  }
}

class _GreetingBlock extends StatelessWidget {
  const _GreetingBlock({required this.greeting});

  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: AppTypography.serif(size: 26, weight: FontWeight.w600)),
              const SizedBox(height: AppSpacing.xs),
              Text('愿一杯好茶,陪你度过美好时光。', style: AppTypography.body),
            ],
          ),
        ),
        Icon(Icons.spa_outlined, size: 40, color: AppColors.pineGreen.withValues(alpha: 0.7)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 40, height: 1.5, color: AppColors.charcoalBlack);
  }
}

class _QuickEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final entry in SampleData.quickEntries)
          Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.ricePaperGray,
                  shape: BoxShape.circle,
                ),
                child: Icon(entry.icon, color: AppColors.inkGreen, size: 24),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(entry.label, style: AppTypography.sans(size: 12, color: AppColors.textSecondary)),
            ],
          ),
      ],
    );
  }
}

class _TeaQuote extends StatelessWidget {
  const _TeaQuote();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('茶语', style: AppTypography.h3),
        const SizedBox(height: AppSpacing.md),
        Text(
          SampleData.teaQuote,
          style: AppTypography.serif(size: 16, weight: FontWeight.w400, height: 1.8, color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.xs),
        Align(
          alignment: Alignment.centerRight,
          child: Text(SampleData.teaQuoteAuthor, style: AppTypography.caption),
        ),
      ],
    );
  }
}
