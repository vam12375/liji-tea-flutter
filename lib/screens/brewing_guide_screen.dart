import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../models/content_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/segment_control.dart';
import '../widgets/soft_card.dart';

/// 冲泡指南 — step-by-step brewing guide with parameter presets.
class BrewingGuideScreen extends StatefulWidget {
  const BrewingGuideScreen({super.key});

  @override
  State<BrewingGuideScreen> createState() => _BrewingGuideScreenState();
}

class _BrewingGuideScreenState extends State<BrewingGuideScreen> {
  int _tea = 0;

  static const _teas = ['绿茶', '白茶', '乌龙茶', '红茶'];
  static const _params = [
    ('80-85℃', '3g', '15s', '玻璃杯 / 盖碗'),
    ('90℃', '5g', '30s', '盖碗 / 壶'),
    ('95-100℃', '7g', '20s', '紫砂壶 / 盖碗'),
    ('90-95℃', '4g', '10s', '盖碗 / 瓷壶'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = _params[_tea];
    return Scaffold(
      appBar: AppBar(title: Text('冲泡指南', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            SegmentControl(
              segments: _teas,
              selected: _tea,
              onSelected: (i) => setState(() => _tea = i),
            ),
            const SizedBox(height: AppSpacing.lg),
            SoftCard(
              child: Row(
                children: [
                  _Param(icon: Icons.thermostat_outlined, label: '水温', value: p.$1),
                  _Param(icon: Icons.scale_outlined, label: '投茶', value: p.$2),
                  _Param(icon: Icons.timer_outlined, label: '出汤', value: p.$3),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            SoftCard(
              child: Row(
                children: [
                  const Icon(Icons.emoji_food_beverage_outlined, size: 18, color: AppColors.pineGreen),
                  const SizedBox(width: AppSpacing.xs),
                  Text('推荐器具', style: AppTypography.sans(size: 13)),
                  const Spacer(),
                  Text(p.$4, style: AppTypography.sans(size: 13, weight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('冲泡步骤', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < ContentData.brewSteps.length; i++)
              _StepRow(
                index: i + 1,
                step: ContentData.brewSteps[i],
                isLast: i == ContentData.brewSteps.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

class _Param extends StatelessWidget {
  const _Param({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.pineGreen),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: AppTypography.serif(size: 16, weight: FontWeight.w700, color: AppColors.inkGreen)),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.index, required this.step, required this.isLast});
  final int index;
  final BrewStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
                child: Center(
                  child: Text('$index',
                      style: AppTypography.serif(
                          size: 15, weight: FontWeight.w600, color: AppColors.gold)),
                ),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: AppColors.divider)),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(step.icon, size: 18, color: AppColors.pineGreen),
                    const SizedBox(width: AppSpacing.xs),
                    Text(step.title,
                        style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  ]),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(step.desc, style: AppTypography.body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
