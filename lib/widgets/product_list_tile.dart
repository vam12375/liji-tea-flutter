import 'package:flutter/material.dart';

import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'tea_image.dart';

/// A horizontal product row (image · name/tagline · price · cart icon),
/// used in 分类 / 我的收藏 / 搜索 推荐 lists.
class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
    this.onTap,
    this.onAdd,
    this.trailing,
    this.showDivider = true,
  });

  final TeaProduct product;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;
  final Widget? trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: showDivider
            ? const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.divider)),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: TeaImage(swatch: product.swatch, radius: AppRadius.image, iconSize: 30),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.name, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(
                    '${product.category} | ${product.unit}',
                    style: AppTypography.caption,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    product.tagline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.sans(size: 12, color: AppColors.textTertiary),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '¥${product.price}',
                    style: AppTypography.serif(size: 17, weight: FontWeight.w700, color: AppColors.inkGreen),
                  ),
                ],
              ),
            ),
            trailing ??
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.inkGreen),
                ),
          ],
        ),
      ),
    );
  }
}
