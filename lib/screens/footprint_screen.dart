import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/account_data.dart';
import '../models/tea_product.dart';
import '../navigation/app_router.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/product_list_tile.dart';
import '../widgets/status_view.dart';

/// 浏览足迹 — recently viewed products grouped by time.
class FootprintScreen extends StatefulWidget {
  const FootprintScreen({super.key});

  @override
  State<FootprintScreen> createState() => _FootprintScreenState();
}

class _FootprintScreenState extends State<FootprintScreen> {
  late final List<TeaProduct> _today = [...AccountData.footprintsToday];
  late final List<TeaProduct> _earlier = [...AccountData.footprintsEarlier];

  @override
  Widget build(BuildContext context) {
    final empty = _today.isEmpty && _earlier.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text('浏览足迹', style: AppTypography.h3),
        actions: [
          if (!empty)
            TextButton(
              onPressed: () => setState(() {
                _today.clear();
                _earlier.clear();
              }),
              child: Text('清空', style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: empty
            ? Center(
                child: StatusView(
                  icon: Icons.history_outlined,
                  title: '暂无浏览记录',
                  subtitle: '看过的好茶都会留在这里',
                  actionLabel: '去逛逛',
                  onAction: () => context.goNamed(AppRoutes.category),
                ),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                children: [
                  if (_today.isNotEmpty) ...[
                    _groupTitle('今天'),
                    for (final p in _today) _tile(p),
                  ],
                  if (_earlier.isNotEmpty) ...[
                    _groupTitle('更早'),
                    for (final p in _earlier) _tile(p),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
      ),
    );
  }

  Widget _groupTitle(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.xxs),
      child: Text(label, style: AppTypography.sans(size: 13, weight: FontWeight.w600, color: AppColors.textSecondary)),
    );
  }

  Widget _tile(TeaProduct p) {
    return ProductListTile(
      product: p,
      onTap: () => context.pushNamed(
        AppRoutes.product,
        pathParameters: {'id': p.id},
        extra: p,
      ),
      onAdd: () {
        AppStateScope.of(context).addToCart(p, p.specs.isNotEmpty ? p.specs.first : p.unit);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('已将「${p.name}」加入购物车',
                  style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
              backgroundColor: AppColors.inkGreen,
              behavior: SnackBarBehavior.floating,
            ),
          );
      },
    );
  }
}
