import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';

/// 物流追踪 — shipment timeline.
class LogisticsScreen extends StatelessWidget {
  const LogisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = ContentData.logistics;
    return Scaffold(
      appBar: AppBar(title: Text('物流追踪', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.xs, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            SoftCard(
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.inkGreen,
                      borderRadius: BorderRadius.circular(AppRadius.image),
                    ),
                    child: const Icon(Icons.local_shipping_outlined, color: AppColors.riceWhite),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('顺丰速运  SF1234567890',
                            style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                        const SizedBox(height: AppSpacing.xxs),
                        Text('预计 5 月 25 日送达', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Text('复制', style: AppTypography.sans(size: 13, color: AppColors.inkGreen)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('物流详情', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.md),
                  for (var i = 0; i < steps.length; i++)
                    _TimelineRow(
                      title: steps[i]['title']!,
                      desc: steps[i]['desc']!,
                      time: steps[i]['time']!,
                      active: i == 0,
                      isLast: i == steps.length - 1,
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

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.desc,
    required this.time,
    required this.active,
    required this.isLast,
  });

  final String title;
  final String desc;
  final String time;
  final bool active;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.inkGreen : AppColors.textTertiary;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: active ? AppColors.inkGreen : AppColors.riceWhite,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(child: Container(width: 2, color: AppColors.divider)),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                          style: AppTypography.sans(
                              size: 14,
                              weight: active ? FontWeight.w600 : FontWeight.w400,
                              color: active ? AppColors.charcoalBlack : AppColors.textSecondary)),
                      Text(time, style: AppTypography.caption),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(desc, style: AppTypography.body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
