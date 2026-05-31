import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/cart_snack.dart';
import '../widgets/product_list_tile.dart';
import '../widgets/section_header.dart';
import '../widgets/status_view.dart';
import 'product_detail_screen.dart';

const _wareCategories = {'茶具', '礼盒'};

/// 我的收藏 — favorites list grouped into 茶叶 / 茶具 / 茶文化 tabs.
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _tab = 0;

  final List<String> _ids = [
    SampleData.longjing.id,
    SampleData.dahongpao.id,
    SampleData.baihaoYinzhen.id,
    SampleData.shanshuiPot.id,
  ];

  List<TeaProduct> get _all =>
      SampleData.allProducts.where((p) => _ids.contains(p.id)).toList();

  List<TeaProduct> get _teas =>
      _all.where((p) => !_wareCategories.contains(p.category)).toList();
  List<TeaProduct> get _wares =>
      _all.where((p) => _wareCategories.contains(p.category)).toList();

  List<TeaProduct> get _current => _tab == 1 ? _wares : (_tab == 2 ? const [] : _teas);

  @override
  Widget build(BuildContext context) {
    // Counts mirror the design's sample figures.
    final tabs = ['茶叶 (12)', '茶具 (8)', '茶文化 (5)'];
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(
        title: Text('我的收藏', style: AppTypography.h3),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('编辑', style: AppTypography.sans(size: 14, color: AppColors.textSecondary)),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // tabs
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.xs,
                  AppSpacing.screenMargin, 0),
              child: Row(
                children: [
                  for (var i = 0; i < tabs.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.lg),
                      child: GestureDetector(
                        onTap: () => setState(() => _tab = i),
                        child: Column(
                          children: [
                            Text(tabs[i],
                                style: AppTypography.sans(
                                    size: 15,
                                    weight: _tab == i ? FontWeight.w600 : FontWeight.w400,
                                    color: _tab == i
                                        ? AppColors.charcoalBlack
                                        : AppColors.textSecondary)),
                            const SizedBox(height: 4),
                            Container(
                              height: 2,
                              width: 20,
                              color: _tab == i ? AppColors.inkGreen : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Expanded(child: _body(context)),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final items = _current;
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: StatusView(
            image: 'assets/images/empty_favorites.png',
            title: '暂无收藏内容',
            subtitle: '收藏喜欢的茶叶和器物,方便下次查找',
            actionLabel: '去发现好茶',
            onAction: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      children: [
        for (final p in items)
          ProductListTile(
            product: p,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
            onAdd: () => showCartSnack(context, p.name),
          ),
        const SizedBox(height: AppSpacing.lg),
        SectionHeader(title: '为你推荐', actionLabel: '换一换', onAction: () {}),
        const SizedBox(height: AppSpacing.xs),
        for (final p in SampleData.recommended)
          ProductListTile(
            product: p,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
            onAdd: () => showCartSnack(context, p.name),
          ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
