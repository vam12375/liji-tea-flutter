import 'package:flutter/material.dart';

import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/tea_image.dart';
import 'reviews_screen.dart';

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
            AppSpacing.screenMargin,
            0,
            AppSpacing.screenMargin,
            AppSpacing.xl,
          ),
          children: [
            Text(product.name, style: AppTypography.serif(size: 28, weight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Text(product.origin, style: AppTypography.body),
                Text('  |  ${product.category}', style: AppTypography.body),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('春日限定,鲜爽如初', style: AppTypography.sans(size: 14, color: AppColors.pineGreen)),
            const SizedBox(height: AppSpacing.lg),
            AspectRatio(
              aspectRatio: 1.1,
              child: TeaImage(swatch: product.swatch, radius: AppRadius.card, iconSize: 72),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (product.attributes.isNotEmpty) _AttributeRow(attributes: product.attributes),
            const SizedBox(height: AppSpacing.lg),
            if (product.description != null) ...[
              Text('产品介绍', style: AppTypography.h3),
              const SizedBox(height: AppSpacing.sm),
              Text(product.description!, style: AppTypography.sans(size: 14, height: 1.8, color: AppColors.textSecondary)),
              const SizedBox(height: AppSpacing.lg),
            ],
            Text('选择规格', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.md),
            _SpecSelector(
              specs: product.specs,
              selected: _selectedSpec,
              onSelected: (i) => setState(() => _selectedSpec = i),
            ),
            const SizedBox(height: AppSpacing.lg),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReviewsScreen(productName: product.name),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.divider)),
                ),
                child: Row(
                  children: [
                    Text('商品评价', style: AppTypography.h3),
                    const SizedBox(width: AppSpacing.xs),
                    Text('(1286)', style: AppTypography.caption),
                    const Spacer(),
                    const Icon(Icons.star, size: 14, color: AppColors.gold),
                    Text(' 4.9 好评', style: AppTypography.caption),
                    const Icon(Icons.chevron_right, size: 18, color: AppColors.textTertiary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomBar(
        price: product.price,
        unit: product.unit,
        onAdd: () => _showAdded(context),
      ),
    );
  }

  void _showAdded(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('已将「${widget.product.name}」加入购物车',
              style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
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
                Icon(attr.icon, size: 22, color: AppColors.inkGreen),
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
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (var i = 0; i < specs.length; i++)
          GestureDetector(
            onTap: () => onSelected(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: selected == i ? AppColors.inkGreen.withValues(alpha: 0.06) : AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.image),
                border: Border.all(
                  color: selected == i ? AppColors.inkGreen : AppColors.divider,
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
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.price, required this.unit, required this.onAdd});

  final int price;
  final String unit;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenMargin,
        AppSpacing.md,
        AppSpacing.screenMargin,
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
              Text('¥$price', style: AppTypography.serif(size: 26, weight: FontWeight.w700, color: AppColors.inkGreen)),
              const SizedBox(width: 2),
              Text('/ $unit', style: AppTypography.caption),
            ],
          ),
          const Spacer(),
          PrimaryButton(label: '加入购物车', onPressed: onAdd),
        ],
      ),
    );
  }
}
