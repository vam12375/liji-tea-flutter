import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../navigation/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../state/app_state.dart';
import '../widgets/featured_product_card.dart';
import '../widgets/section_header.dart';

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
    context.pushNamed(
      AppRoutes.product,
      pathParameters: {'id': product.id},
      extra: product,
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
          _TopBar(
            onSearch: () => context.pushNamed(AppRoutes.search),
          ),
          const SizedBox(height: AppSpacing.lg),
          _GreetingBlock(greeting: _greeting()),
          const SizedBox(height: AppSpacing.lg),
          _SearchBar(
            onTap: () => context.pushNamed(AppRoutes.search),
          ),
          const SizedBox(height: AppSpacing.lg),
          _QuickEntries(
            onBrewing: () => context.pushNamed(AppRoutes.brewing),
          ),
          const SizedBox(height: AppSpacing.xl),
          _FeatureRow(
            onAi: () => context.pushNamed(AppRoutes.aiRecommend),
            onGift: () => context.pushNamed(AppRoutes.giftCustomize),
            onSolar: () => context.pushNamed(AppRoutes.solarTerms),
          ),
          const SizedBox(height: AppSpacing.xl),
          SectionHeader(
            title: '今日推荐',
            actionLabel: '更多',
            onAction: () => context.goNamed(AppRoutes.category),
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
    AppStateScope.of(context).addToCart(
      product,
      product.specs.isNotEmpty ? product.specs.first : product.unit,
    );
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
  const _TopBar({required this.onSearch});

  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'LIJI·TEA',
          style: AppTypography.latin(size: 26, weight: FontWeight.w600, letterSpacing: 3, color: AppColors.inkGreen),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onSearch,
              tooltip: '搜索',
              icon: const Icon(Icons.search, color: AppColors.charcoalBlack),
            ),
            IconButton(
              onPressed: () => context.pushNamed(AppRoutes.notifications),
              tooltip: '消息通知',
              icon: const Icon(Icons.notifications_none_rounded, color: AppColors.charcoalBlack),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.ricePaperGray.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, size: 18, color: AppColors.textTertiary),
            const SizedBox(width: AppSpacing.xs),
            Text('搜索茶叶 / 茶具 / 文章',
                style: AppTypography.sans(size: 14, color: AppColors.textTertiary)),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.onAi, required this.onGift, required this.onSolar});

  final VoidCallback onAi;
  final VoidCallback onGift;
  final VoidCallback onSolar;

  @override
  Widget build(BuildContext context) {
    final items = <(IconData, String, String, VoidCallback)>[
      (Icons.auto_awesome, 'AI 茶推荐', '找到适合你的茶', onAi),
      (Icons.card_giftcard_outlined, '茶礼定制', '心意,亲手定制', onGift),
      (Icons.calendar_month_outlined, '节气茶单', '应时而饮', onSolar),
    ];
    return Row(
      children: [
        for (final it in items)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              child: GestureDetector(
                onTap: it.$4,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    children: [
                      Icon(it.$1, color: AppColors.pineGreen),
                      const SizedBox(height: AppSpacing.xs),
                      Text(it.$2, style: AppTypography.sans(size: 13, weight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(it.$3, style: AppTypography.caption, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
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


class _QuickEntries extends StatelessWidget {
  const _QuickEntries({required this.onBrewing});

  final VoidCallback onBrewing;

  @override
  Widget build(BuildContext context) {
    final entries = SampleData.quickEntries;
    final actions = <VoidCallback>[
      () => context.goNamed(AppRoutes.category), // 精选茶品 → 分类
      () => context.goNamed(AppRoutes.category), // 茶具器物 → 分类
      onBrewing, // 茶艺课程 → 冲泡指南
      () => context.goNamed(AppRoutes.culture), // 茶生活 → 茶文化
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < entries.length; i++)
          GestureDetector(
            onTap: actions[i],
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AppColors.ricePaperGray,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(entries[i].icon, color: AppColors.inkGreen, size: 24),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(entries[i].label, style: AppTypography.sans(size: 12, color: AppColors.textSecondary)),
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
