import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../data/sample_data.dart';
import '../models/content_models.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';
import '../widgets/tea_image.dart';

/// 茶礼定制 — a 4-step gift customization wizard.
class GiftCustomizeScreen extends StatefulWidget {
  const GiftCustomizeScreen({super.key});

  @override
  State<GiftCustomizeScreen> createState() => _GiftCustomizeScreenState();
}

class _GiftCustomizeScreenState extends State<GiftCustomizeScreen> {
  int _step = 0;
  int _box = 0;
  final Set<String> _teas = {};
  final _blessingController = TextEditingController(text: '愿君常饮一杯春,岁岁年年皆安宁。');

  @override
  void dispose() {
    _blessingController.dispose();
    super.dispose();
  }

  bool get _canNext {
    return switch (_step) {
      1 => _teas.isNotEmpty,
      _ => true,
    };
  }

  void _next() {
    if (_step < ContentData.giftSteps.length - 1) {
      setState(() => _step++);
    } else {
      _showDone();
    }
  }

  void _showDone() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: Text('定制已提交', style: AppTypography.h3),
        content: Text('我们已收到你的茶礼定制需求,稍后将有茶艺顾问与你联系。',
            style: AppTypography.body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('好的', style: AppTypography.sans(size: 15, color: AppColors.inkGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('茶礼定制', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              child: _StepIndicator(steps: ContentData.giftSteps, current: _step),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                child: switch (_step) {
                  0 => _boxStep(),
                  1 => _teaStep(),
                  2 => _designStep(),
                  _ => _confirmStep(),
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.sm,
                  AppSpacing.screenMargin, AppSpacing.sm + MediaQuery.of(context).padding.bottom),
              decoration: const BoxDecoration(
                color: AppColors.riceWhite,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: SecondaryButton(
                        label: '上一步',
                        expand: true,
                        onPressed: () => setState(() => _step--),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: PrimaryButton(
                      label: _step == ContentData.giftSteps.length - 1 ? '提交定制' : '下一步',
                      expand: true,
                      onPressed: _canNext ? _next : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxStep() {
    return ListView(
      children: [
        Text('选择礼盒包装', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < ContentData.giftBoxes.length; i++)
          _BoxOption(
            box: ContentData.giftBoxes[i],
            selected: _box == i,
            onTap: () => setState(() => _box = i),
          ),
      ],
    );
  }

  Widget _teaStep() {
    final teas = SampleData.allProducts.where((p) => p.category != '茶具' && p.category != '礼盒').toList();
    return ListView(
      children: [
        Text('选择茶品 (已选 ${_teas.length})', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.md),
        for (final p in teas) _TeaPick(product: p, selected: _teas.contains(p.id), onTap: () {
          setState(() {
            if (_teas.contains(p.id)) {
              _teas.remove(p.id);
            } else {
              _teas.add(p.id);
            }
          });
        }),
      ],
    );
  }

  Widget _designStep() {
    return ListView(
      children: [
        Text('定制设计', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.md),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('贺卡寄语', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _blessingController,
                maxLines: 3,
                style: AppTypography.sans(size: 14, height: 1.6),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.ricePaperGray.withValues(alpha: 0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.image),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SoftCard(
          child: Row(
            children: [
              const Icon(Icons.brush_outlined, color: AppColors.pineGreen),
              const SizedBox(width: AppSpacing.sm),
              Text('丝带颜色', style: AppTypography.sans(size: 14)),
              const Spacer(),
              for (final c in const [AppColors.inkGreen, AppColors.gold, Color(0xFF9B2D2D)])
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(left: AppSpacing.xs),
                  decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirmStep() {
    final box = ContentData.giftBoxes[_box];
    final teas = SampleData.allProducts.where((p) => _teas.contains(p.id)).toList();
    return ListView(
      children: [
        Text('确认定制信息', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.md),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _row('礼盒包装', box.name),
              const Divider(height: AppSpacing.lg),
              _row('茶品数量', '${teas.length} 款'),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final p in teas)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.ricePaperGray.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(p.name, style: AppTypography.caption),
                    ),
                ],
              ),
              const Divider(height: AppSpacing.lg),
              _row('贺卡寄语', ''),
              const SizedBox(height: AppSpacing.xxs),
              Text(_blessingController.text, style: AppTypography.body),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SoftCard(
          color: AppColors.inkGreen,
          child: Row(
            children: [
              Text('预估价格', style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
              const Spacer(),
              Text('¥${box.priceFrom + teas.length * 60}',
                  style: AppTypography.serif(size: 22, weight: FontWeight.w700, color: AppColors.gold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.sans(size: 14)),
        Text(value, style: AppTypography.body),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.steps, required this.current});
  final List<String> steps;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: i <= current ? AppColors.inkGreen : AppColors.ricePaperGray,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: i < current
                      ? const Icon(Icons.check, size: 16, color: AppColors.riceWhite)
                      : Text('${i + 1}',
                          style: AppTypography.sans(
                              size: 13,
                              weight: FontWeight.w600,
                              color: i == current ? AppColors.riceWhite : AppColors.textTertiary)),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(steps[i],
                  style: AppTypography.sans(
                      size: 11,
                      color: i <= current ? AppColors.inkGreen : AppColors.textTertiary)),
            ],
          ),
          if (i != steps.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                color: i < current ? AppColors.inkGreen : AppColors.divider,
              ),
            ),
        ],
      ],
    );
  }
}

class _BoxOption extends StatelessWidget {
  const _BoxOption({required this.box, required this.selected, required this.onTap});
  final GiftBox box;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: selected ? AppColors.inkGreen : AppColors.divider,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: TeaImage(swatch: box.swatch, radius: AppRadius.image, icon: Icons.card_giftcard, iconSize: 30),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(box.name, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(box.desc, style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xs),
                  Text('¥${box.priceFrom} 起',
                      style: AppTypography.serif(size: 15, weight: FontWeight.w700, color: AppColors.inkGreen)),
                ],
              ),
            ),
            if (selected) const Icon(Icons.check_circle, color: AppColors.inkGreen),
          ],
        ),
      ),
    );
  }
}

class _TeaPick extends StatelessWidget {
  const _TeaPick({required this.product, required this.selected, required this.onTap});
  final TeaProduct product;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.image),
          border: Border.all(color: selected ? AppColors.inkGreen : AppColors.divider),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: TeaImage(swatch: product.swatch, radius: AppRadius.image, iconSize: 22),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                  Text('¥${product.price} / ${product.unit}', style: AppTypography.caption),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? AppColors.inkGreen : AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
