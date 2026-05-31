import 'package:flutter/material.dart';

import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/tea_image.dart';

/// 商品详情 — product detail screen, mirroring the 明前龙井 / 山水茶壶 design.
class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final TeaProduct product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedSpec = 0;
  bool _favorite = false;

  /// Tea-ware (茶具) detail uses the teapot layout: carousel dots + intro text,
  /// while teas use the attribute strip.
  bool get _isWare => widget.product.category == '茶具';

  String get _secondaryTag {
    for (final a in widget.product.attributes) {
      if (a.label == '材质') return a.value;
    }
    return widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () => setState(() => _favorite = !_favorite),
            icon: Icon(_favorite ? Icons.favorite : Icons.favorite_border,
                color: _favorite ? AppColors.pineGreen : AppColors.charcoalBlack),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share_outlined)),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            Text(product.name,
                style: AppTypography.serif(size: 28, weight: FontWeight.w600, color: AppColors.inkGreen)),
            const SizedBox(height: AppSpacing.sm),
            Text('${product.origin}  |  $_secondaryTag', style: AppTypography.body),
            const SizedBox(height: AppSpacing.sm),
            Text(product.tagline, style: AppTypography.sans(size: 14, color: AppColors.pineGreen)),
            const SizedBox(height: AppSpacing.lg),
            _ProductImage(product: product),
            if (_isWare) ...[
              const SizedBox(height: AppSpacing.md),
              const _CarouselDots(count: 3, active: 0),
              const SizedBox(height: AppSpacing.lg),
              if (product.description != null)
                Text(product.description!,
                    style: AppTypography.sans(size: 14, height: 1.9, color: AppColors.textSecondary)),
              const SizedBox(height: AppSpacing.xl),
            ] else ...[
              const SizedBox(height: AppSpacing.lg),
              if (product.attributes.isNotEmpty) _AttributeRow(attributes: product.attributes),
              const SizedBox(height: AppSpacing.xl),
            ],
            Text('选择规格', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.md),
            _SpecSelector(
              specs: product.specs,
              selected: _selectedSpec,
              onSelected: (i) => setState(() => _selectedSpec = i),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomBar(
        price: product.price,
        unit: _isWare ? null : (product.specs.isNotEmpty ? product.specs[_selectedSpec] : product.unit),
        onAdd: () => _showAdded(context),
      ),
    );
  }

  void _showAdded(BuildContext context) {
    final product = widget.product;
    final spec = product.specs.isNotEmpty ? product.specs[_selectedSpec] : product.unit;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('已将「${product.name}」($spec) 加入购物车',
              style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final TeaProduct product;

  @override
  Widget build(BuildContext context) {
    if (product.imageAsset != null) {
      return Image.asset(product.imageAsset!, width: double.infinity, fit: BoxFit.fitWidth);
    }
    return AspectRatio(
      aspectRatio: 1.2,
      child: TeaImage(swatch: product.swatch, radius: AppRadius.card, iconSize: 72),
    );
  }
}

class _CarouselDots extends StatelessWidget {
  const _CarouselDots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == active ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == active ? AppColors.inkGreen : AppColors.divider,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}

class _AttributeRow extends StatelessWidget {
  const _AttributeRow({required this.attributes});

  final List<ProductAttribute> attributes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final attr in attributes)
          Expanded(
            child: Column(
              children: [
                Icon(attr.icon, size: 20, color: AppColors.inkGreen),
                const SizedBox(height: AppSpacing.xs),
                Text(attr.label, style: AppTypography.caption),
                const SizedBox(height: 2),
                Text(attr.value, style: AppTypography.sans(size: 13, weight: FontWeight.w500)),
              ],
            ),
          ),
      ],
    );
  }
}

class _SpecSelector extends StatelessWidget {
  const _SpecSelector({required this.specs, required this.selected, required this.onSelected});

  final List<String> specs;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < specs.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == specs.length - 1 ? 0 : AppSpacing.sm),
              child: GestureDetector(
                onTap: () => onSelected(i),
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected == i ? AppColors.cardSurface : AppColors.ricePaperGray.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected == i ? AppColors.inkGreen : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    specs[i],
                    style: AppTypography.sans(
                      size: 14,
                      weight: selected == i ? FontWeight.w600 : FontWeight.w400,
                      color: selected == i ? AppColors.inkGreen : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.price, required this.unit, required this.onAdd});

  final int price;
  final String? unit;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.riceWhite,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('¥$price',
                  style: AppTypography.serif(size: 28, weight: FontWeight.w700, color: AppColors.inkGreen)),
              if (unit != null) ...[
                const SizedBox(width: 4),
                Text('/ $unit', style: AppTypography.caption),
              ],
            ],
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(child: PrimaryButton(label: '加入购物车', expand: true, onPressed: onAdd)),
        ],
      ),
    );
  }
}
