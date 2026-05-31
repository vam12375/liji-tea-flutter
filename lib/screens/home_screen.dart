import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/featured_product_card.dart';
import '../widgets/section_header.dart';
import 'brewing_guide_screen.dart';
import 'notification_screen.dart';
import 'product_detail_screen.dart';

/// 首页 — the home screen, mirroring the LIJI·TEA home design.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onSelectTab});

  /// Switches the bottom-nav tab (e.g. jump to 分类) from the shell.
  final ValueChanged<int>? onSelectTab;

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
          AppSpacing.lg,
          AppSpacing.xs,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          const _TopBar(),
          const SizedBox(height: AppSpacing.md),
          _GreetingBlock(greeting: _greeting()),
          const SizedBox(height: AppSpacing.xl),
          _QuickEntries(
            onSelectTab: onSelectTab,
            onCourse: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BrewingGuideScreen())),
          ),
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(
            title: '今日推荐',
            actionLabel: '更多',
            onAction: () => onSelectTab?.call(1),
          ),
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
          content: Text('已将「${product.name}」加入购物车',
              style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'LIJI·TEA',
          style: AppTypography.latin(
              size: 26, weight: FontWeight.w600, letterSpacing: 3, color: AppColors.inkGreen),
        ),
        IconButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const NotificationScreen())),
          icon: const Icon(Icons.notifications_none_rounded, color: AppColors.charcoalBlack),
          splashRadius: 22,
        ),
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
              const SizedBox(height: AppSpacing.xs),
              Text(greeting, style: AppTypography.serif(size: 28, weight: FontWeight.w600)),
              const SizedBox(height: AppSpacing.sm),
              Text('愿一杯好茶,陪你度过美好时光。', style: AppTypography.body),
              const SizedBox(height: AppSpacing.md),
              Container(width: 28, height: 1, color: AppColors.gold),
            ],
          ),
        ),
        Image.asset('assets/images/bamboo.png', width: 116, fit: BoxFit.contain),
      ],
    );
  }
}

class _QuickEntries extends StatelessWidget {
  const _QuickEntries({this.onSelectTab, required this.onCourse});

  final ValueChanged<int>? onSelectTab;
  final VoidCallback onCourse;

  @override
  Widget build(BuildContext context) {
    final entries = <(String, String, VoidCallback)>[
      ('assets/images/entry_tea.png', '精选茶品', () => onSelectTab?.call(1)),
      ('assets/images/entry_ware.png', '茶具器物', () => onSelectTab?.call(1)),
      ('assets/images/entry_course.png', '茶艺课程', onCourse),
      ('assets/images/entry_life.png', '茶生活', () => onSelectTab?.call(2)),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final e in entries)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: e.$3,
            child: Column(
              children: [
                Image.asset(e.$1, width: 48, height: 48),
                const SizedBox(height: AppSpacing.xs),
                Text(e.$2, style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
              ],
            ),
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
          style: AppTypography.serif(
              size: 16, weight: FontWeight.w400, height: 1.8, color: AppColors.textSecondary),
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
