import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/app_router.dart';
import '../repositories/product_repository.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/async_value_view.dart';
import '../widgets/product_list_tile.dart';

/// 分类 — left category rail + product list.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  static const _repository = ProductRepository();

  int _selected = 0;

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
    final appState = AppStateScope.of(context);
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
                  tooltip: '搜索',
                  onPressed: () => context.pushNamed(AppRoutes.search),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: AsyncValueView(
              future: _repository.categories(),
              builder: (context, categories) {
                final selected = _selected.clamp(0, categories.length - 1);
                final category = categories[selected];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryRail(
                      categories: categories,
                      icons: _icons,
                      selected: selected,
                      onSelected: (i) => setState(() => _selected = i),
                    ),
                    Expanded(
                      child: AsyncValueView(
                        future: _repository.productsByCategory(category),
                        isEmpty: (products) => products.isEmpty,
                        empty: Center(child: Text('敬请期待', style: AppTypography.body)),
                        builder: (context, products) {
                          return ListView(
                            padding: const EdgeInsets.fromLTRB(
                                AppSpacing.md, 0, AppSpacing.md, AppSpacing.xl),
                            children: [
                              for (final p in products)
                                ProductListTile(
                                  product: p,
                                  onTap: () => context.pushNamed(
                                    AppRoutes.product,
                                    pathParameters: {'id': p.id},
                                    extra: p,
                                  ),
                                  onAdd: () {
                                    appState.addToCart(
                                      p,
                                      p.specs.isNotEmpty ? p.specs.first : p.unit,
                                    );
                                    _toast(context, '已将「${p.name}」加入购物车');
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
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
