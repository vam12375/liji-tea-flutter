import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/cart_snack.dart';
import 'category_screen.dart';
import 'product_detail_screen.dart';
import 'search_screen.dart';

/// 绿茶 — a single category's product list with the shared rail and a sort bar.
class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key, required this.category});

  final String category;

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late int _selected = SampleData.categories.indexOf(widget.category).clamp(0, 8);
  int _sort = 0; // 0 综合 · 1 销量 · 2 价格

  List<TeaProduct> get _products {
    final list = SampleData.productsByCategory(SampleData.categories[_selected]);
    if (_sort == 2) {
      final sorted = [...list]..sort((a, b) => a.price.compareTo(b.price));
      return sorted;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final category = SampleData.categories[_selected];
    final products = _products;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text(category, style: AppTypography.h3),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SearchScreen())),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryRail(
              categories: SampleData.categories,
              selected: _selected,
              onSelected: (i) => setState(() => _selected = i),
            ),
            Expanded(
              child: Column(
                children: [
                  _SortBar(selected: _sort, onSelected: (i) => setState(() => _sort = i)),
                  Expanded(
                    child: products.isEmpty
                        ? Center(child: Text('敬请期待', style: AppTypography.body))
                        : ListView(
                            padding: const EdgeInsets.fromLTRB(
                                AppSpacing.md, 0, AppSpacing.md, AppSpacing.xl),
                            children: [
                              for (final p in products)
                                _Row(
                                  product: p,
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(product: p))),
                                  onAdd: () => showCartSnack(context, p.name),
                                ),
                            ],
                          ),
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

class _SortBar extends StatelessWidget {
  const _SortBar({required this.selected, required this.onSelected});
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    Widget tab(int i, String label, {Widget? trailing}) {
      final active = i == selected;
      return GestureDetector(
        onTap: () => onSelected(i),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label,
                style: AppTypography.sans(
                  size: 14,
                  weight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? AppColors.inkGreen : AppColors.textSecondary,
                )),
            ?trailing,
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          tab(0, '综合',
              trailing: const Icon(Icons.arrow_drop_down, size: 18, color: AppColors.textSecondary)),
          const SizedBox(width: AppSpacing.lg),
          tab(1, '销量'),
          const SizedBox(width: AppSpacing.lg),
          tab(2, '价格',
              trailing: const Icon(Icons.unfold_more, size: 14, color: AppColors.textSecondary)),
          const Spacer(),
          const Icon(Icons.tune, size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.product, required this.onTap, required this.onAdd});

  final TeaProduct product;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.image),
              child: product.thumbAsset != null
                  ? Image.asset(product.thumbAsset!, width: 84, height: 84, fit: BoxFit.cover)
                  : Container(width: 84, height: 84, color: product.swatch),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: AppTypography.serif(size: 16, weight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text('${product.origin} | ${product.unit}', style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(product.tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.sans(size: 12, color: AppColors.textTertiary)),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Text('¥${product.price}',
                          style: AppTypography.serif(
                              size: 17, weight: FontWeight.w700, color: AppColors.inkGreen)),
                      const Spacer(),
                      GestureDetector(
                        onTap: onAdd,
                        child: const Icon(Icons.shopping_cart_outlined,
                            size: 22, color: AppColors.inkGreen),
                      ),
                    ],
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
