import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/cart_snack.dart';
import 'category_list_screen.dart';
import 'product_detail_screen.dart';
import 'search_screen.dart';

/// 分类 — left category rail + a promo banner and a card-based product list.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final category = SampleData.categories[_selected];
    final products = SampleData.productsByCategory(category);
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
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  ),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryRail(
                  categories: SampleData.categories,
                  selected: _selected,
                  onSelected: (i) => setState(() => _selected = i),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.sm, AppSpacing.xs, AppSpacing.md, AppSpacing.xl),
                    children: [
                      _Banner(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CategoryListScreen(category: category))),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (products.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xxl),
                          child: Center(child: Text('敬请期待', style: AppTypography.body)),
                        )
                      else
                        for (final p in products)
                          Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: _ProductCard(
                              product: p,
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(product: p))),
                              onAdd: () => showCartSnack(context, p.name),
                            ),
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
}

/// Shared left rail of tea categories used by 分类 and the category list.
class CategoryRail extends StatelessWidget {
  const CategoryRail({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  final List<String> categories;
  final int selected;
  final ValueChanged<int> onSelected;

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
    return Container(
      width: 80,
      color: AppColors.ricePaperGray.withValues(alpha: 0.30),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          for (var i = 0; i < categories.length; i++)
            GestureDetector(
              onTap: () => onSelected(i),
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 64,
                color: selected == i ? AppColors.riceWhite : Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      width: 3,
                      height: 64,
                      color: selected == i ? AppColors.inkGreen : Colors.transparent,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _icons[i % _icons.length],
                            size: 18,
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

class _Banner extends StatelessWidget {
  const _Banner({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96,
        decoration: BoxDecoration(
          color: AppColors.ricePaperGray.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('一叶知春',
                      style: AppTypography.serif(
                          size: 19, weight: FontWeight.w600, color: AppColors.inkGreen)),
                  const SizedBox(height: AppSpacing.xxs),
                  Text('鲜爽甘醇,山川之味', style: AppTypography.caption),
                ],
              ),
            ),
            const Spacer(),
            Image.asset('assets/images/fenlei_banner.png',
                height: 96, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap, required this.onAdd});

  final TeaProduct product;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.productCard),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.image),
              child: product.thumbAsset != null
                  ? Image.asset(product.thumbAsset!, width: 76, height: 76, fit: BoxFit.cover)
                  : Container(width: 76, height: 76, color: product.swatch),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: AppTypography.serif(size: 16, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.xxs),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('¥${product.price}',
                          style: AppTypography.serif(
                              size: 17, weight: FontWeight.w700, color: AppColors.inkGreen)),
                      const SizedBox(width: 4),
                      Text('/ ${product.unit}', style: AppTypography.caption),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(product.tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.sans(size: 12, color: AppColors.textTertiary)),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            _AddButton(onTap: onAdd),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
        child: const Icon(Icons.add, size: 18, color: AppColors.riceWhite),
      ),
    );
  }
}
