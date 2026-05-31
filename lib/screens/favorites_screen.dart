import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/cart_snack.dart';
import '../widgets/product_list_tile.dart';
import '../widgets/status_view.dart';
import 'product_detail_screen.dart';

/// 我的收藏 — favorites list with an empty state.
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<String> _ids = [
    SampleData.longjing.id,
    SampleData.dahongpao.id,
    SampleData.baihaoYinzhen.id,
    SampleData.shanshuiPot.id,
  ];

  @override
  Widget build(BuildContext context) {
    final items =
        SampleData.allProducts.where((p) => _ids.contains(p.id)).toList();
    return Scaffold(
      appBar: AppBar(title: Text('我的收藏', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: items.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Center(
                  child: StatusView(
                    image: 'assets/images/empty_favorites.png',
                    title: '暂无收藏内容',
                    subtitle: '收藏喜欢的茶叶和器物,方便下次查找',
                    actionLabel: '去发现好茶',
                    onAction: () => Navigator.of(context).pop(),
                  ),
                ),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                children: [
                  for (final p in items)
                    ProductListTile(
                      product: p,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: AppColors.inkGreen),
                        onPressed: () => setState(() => _ids.remove(p.id)),
                      ),
                      onAdd: () => showCartSnack(context, p.name),
                    ),
                ],
              ),
      ),
    );
  }
}
