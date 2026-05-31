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
import '../widgets/status_view.dart';

/// 我的收藏 — favorites list with an empty state.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  static const _repository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('我的收藏', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: AsyncValueView(
          future: _repository.allProducts(),
          isEmpty: (products) =>
              products.where((p) => appState.favoriteIds.contains(p.id)).isEmpty,
          empty: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Center(
              child: StatusView(
                icon: Icons.favorite_border,
                title: '还没有收藏',
                subtitle: '把喜欢的茶收藏起来,方便随时回看',
                actionLabel: '去逛逛',
                onAction: () => context.goNamed(AppRoutes.category),
              ),
            ),
          ),
          builder: (context, products) {
            final items = products.where((p) => appState.favoriteIds.contains(p.id)).toList();
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              children: [
                for (final p in items)
                  ProductListTile(
                    product: p,
                    onTap: () => context.pushNamed(
                      AppRoutes.product,
                      pathParameters: {'id': p.id},
                      extra: p,
                    ),
                    trailing: IconButton(
                      tooltip: '取消收藏',
                      icon: const Icon(Icons.favorite, color: AppColors.inkGreen),
                      onPressed: () => appState.removeFavorite(p.id),
                    ),
                    onAdd: () {
                      appState.addToCart(p, p.specs.isNotEmpty ? p.specs.first : p.unit);
                      _toast(context, '已将「${p.name}」加入购物车');
                    },
                  ),
              ],
            );
          },
        ),
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
