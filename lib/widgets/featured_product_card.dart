import 'package:flutter/material.dart';

import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'add_button.dart';
import 'tea_image.dart';

/// Horizontal product card (image left, details right) used in 今日推荐.
class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAdd,
  });

  final TeaProduct product;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.productCard),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 96,
              height: 96,
              child: TeaImage(swatch: product.swatch, assetPath: product.thumbAsset),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.name, style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(product.origin, style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xs),
                  Text(product.tagline, style: AppTypography.body),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _PriceTag(price: product.price, unit: product.unit),
                      const Spacer(),
                      AddButton(onPressed: onAdd),
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

class _PriceTag extends StatelessWidget {
  const _PriceTag({required this.price, required this.unit});

  final int price;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('¥$price', style: AppTypography.serif(size: 20, weight: FontWeight.w600, color: AppColors.inkGreen)),
        const SizedBox(width: 2),
        Text('/ $unit', style: AppTypography.caption),
      ],
    );
  }
}
