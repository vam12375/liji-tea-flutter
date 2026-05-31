import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/app_icon.dart';
import '../widgets/cart_snack.dart';
import '../widgets/product_list_tile.dart';
import '../widgets/section_header.dart';
import 'product_detail_screen.dart';

/// 搜索 — hot keywords, history, trending, and a no-result state.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String? _submitted; // null = not searched yet

  static const _trending = [
    ('明前龙井', '12867'),
    ('春茶上市', '8421'),
    ('茶具套装推荐', '6793'),
    ('母亲节送茶推荐', '5342'),
    ('冷泡茶怎么泡', '4721'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<TeaProduct> get _results {
    final q = _submitted!;
    return SampleData.allProducts
        .where((p) => p.name.contains(q) || p.category.contains(q) || p.tagline.contains(q))
        .toList();
  }

  void _search(String q) {
    if (q.trim().isEmpty) return;
    setState(() => _submitted = q.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _SearchField(
          controller: _controller,
          onSubmitted: _search,
        ),
        actions: [
          TextButton(
            onPressed: () => _search(_controller.text),
            child: Text('搜索', style: AppTypography.sans(size: 15, color: AppColors.inkGreen)),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: _submitted == null
            ? _DiscoverView(onTapKeyword: (k) {
                _controller.text = k;
                _search(k);
              }, trending: _trending)
            : (_results.isEmpty ? _noResult() : _resultList()),
      ),
    );
  }

  Widget _resultList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      children: [
        for (final p in _results)
          ProductListTile(
            product: p,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
            ),
            onAdd: () => showCartSnack(context, p.name),
          ),
      ],
    );
  }

  Widget _noResult() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin, AppSpacing.xl, AppSpacing.screenMargin, AppSpacing.xl),
      children: [
        Center(
          child: Column(
            children: [
              Icon(Icons.emoji_food_beverage_outlined,
                  size: 56, color: AppColors.pineGreen.withValues(alpha: 0.5)),
              const SizedBox(height: AppSpacing.md),
              Text('未找到相关内容', style: AppTypography.h3),
              const SizedBox(height: AppSpacing.xs),
              Text('换个关键词试试,或去看看推荐内容', style: AppTypography.body),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('搜索建议', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.md),
        _ChipWrap(
          labels: const ['普洱生茶', '普洱熟茶', '古树普洱', '普洱茶饼', '普洱茶砖', '普洱茶礼盒'],
          onTap: (_) {},
        ),
        const SizedBox(height: AppSpacing.xl),
        SectionHeader(title: '为你推荐'),
        const SizedBox(height: AppSpacing.xs),
        for (final p in SampleData.recommended)
          ProductListTile(
            product: p,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
            ),
            onAdd: () => showCartSnack(context, p.name),
          ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onSubmitted});

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(right: AppSpacing.xs),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.ricePaperGray.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        children: [
          const AppIcon(AppIcon.search, size: 18, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              style: AppTypography.sans(size: 14),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: '搜索茶叶 / 茶具 / 文章',
                hintStyle: AppTypography.sans(size: 14, color: AppColors.textTertiary),
              ),
            ),
          ),
          const Icon(Icons.camera_alt_outlined, size: 18, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}

class _DiscoverView extends StatelessWidget {
  const _DiscoverView({required this.onTapKeyword, required this.trending});

  final ValueChanged<String> onTapKeyword;
  final List<(String, String)> trending;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('热门搜索', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
            Row(children: [
              const Icon(Icons.refresh, size: 14, color: AppColors.textTertiary),
              const SizedBox(width: 2),
              Text('换一换', style: AppTypography.caption),
            ]),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _ChipWrap(labels: SampleData.hotSearch, onTap: onTapKeyword),
        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('搜索历史', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
            Text('清空', style: AppTypography.caption),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _ChipWrap(labels: SampleData.searchHistory, onTap: onTapKeyword),
        const SizedBox(height: AppSpacing.xl),
        Text('大家都在搜', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.xs),
        for (var i = 0; i < trending.length; i++)
          InkWell(
            onTap: () => onTapKeyword(trending[i].$1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    child: Text('${i + 1}',
                        style: AppTypography.serif(
                            size: 16,
                            weight: FontWeight.w600,
                            color: i < 3 ? AppColors.gold : AppColors.textTertiary)),
                  ),
                  Expanded(child: Text(trending[i].$1, style: AppTypography.sans(size: 14))),
                  Text(trending[i].$2, style: AppTypography.caption),
                  const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.labels, required this.onTap});

  final List<String> labels;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final l in labels)
          GestureDetector(
            onTap: () => onTap(l),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.ricePaperGray.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(l, style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
            ),
          ),
      ],
    );
  }
}
