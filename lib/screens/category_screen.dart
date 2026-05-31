import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/app_icon.dart';
import '../widgets/cart_snack.dart';
import '../widgets/product_list_tile.dart';
import 'product_detail_screen.dart';
import 'search_screen.dart';

/// 分类 — left category rail + product list.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selected = 0;
  int _sort = 0; // 0 综合 · 1 价格升序 · 2 价格降序

  static const _sortLabels = ['综合排序', '价格从低到高', '价格从高到低'];

  static const _icons = <IconData>[
    Icons.eco_outlined,
    Icons.local_florist_outlined,
    Icons.spa_outlined,
    Icons.local_cafe_outlined,
    Icons.coffee_outlined,
    Icons.filter_vintage_outlined,
    Icons.emoji_food_beverage_outlined,
    Icons.bakery_dining_outlined,
    Icons.card_giftcard_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final category = SampleData.categories[_selected];
    final products = [...SampleData.productsByCategory(category)];
    if (_sort == 1) {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sort == 2) {
      products.sort((a, b) => b.price.compareTo(a.price));
    }
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin, AppSpacing.sm, AppSpacing.screenMargin, AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('分类', style: AppTypography.h2),
                Row(
                  children: [
                    IconButton(
                      onPressed: _openFilterSheet,
                      icon: AppIcon(AppIcon.filter,
                          color: _sort == 0 ? AppColors.charcoalBlack : AppColors.inkGreen),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      ),
                      icon: const AppIcon(AppIcon.search, color: AppColors.charcoalBlack),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategoryRail(
                  categories: SampleData.categories,
                  icons: _icons,
                  selected: _selected,
                  onSelected: (i) => setState(() => _selected = i),
                ),
                Expanded(
                  child: products.isEmpty
                      ? Center(child: Text('敬请期待', style: AppTypography.body))
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(
                              AppSpacing.md, 0, AppSpacing.md, AppSpacing.xl),
                          children: [
                            for (final p in products)
                              ProductListTile(
                                product: p,
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(product: p)),
                                ),
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
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.riceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xs),
                child: Row(
                  children: [
                    const AppIcon(AppIcon.filter, size: 18, color: AppColors.inkGreen),
                    const SizedBox(width: AppSpacing.xs),
                    Text('筛选排序', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  ],
                ),
              ),
              for (var i = 0; i < _sortLabels.length; i++)
                ListTile(
                  title: Text(_sortLabels[i], style: AppTypography.body),
                  trailing: _sort == i
                      ? const Icon(Icons.check, size: 18, color: AppColors.inkGreen)
                      : null,
                  onTap: () {
                    setState(() => _sort = i);
                    Navigator.of(sheetContext).pop();
                  },
                ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryRail extends StatelessWidget {
  const _CategoryRail({
    required this.categories,
    required this.icons,
    required this.selected,
    required this.onSelected,
  });

  final List<String> categories;
  final List<IconData> icons;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      color: AppColors.ricePaperGray.withValues(alpha: 0.35),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          for (var i = 0; i < categories.length; i++)
            GestureDetector(
              onTap: () => onSelected(i),
              child: Container(
                height: 72,
                color: selected == i ? AppColors.riceWhite : Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      width: 3,
                      height: 72,
                      color: selected == i ? AppColors.inkGreen : Colors.transparent,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[i],
                            size: 20,
                            color: selected == i ? AppColors.inkGreen : AppColors.textTertiary,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            categories[i],
                            style: AppTypography.sans(
                              size: 13,
                              weight: selected == i ? FontWeight.w600 : FontWeight.w400,
                              color: selected == i ? AppColors.inkGreen : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
