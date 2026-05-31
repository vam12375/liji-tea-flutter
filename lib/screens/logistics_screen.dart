import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';

/// 物流追踪 — shipment status card, timeline, and a route map.
class LogisticsScreen extends StatelessWidget {
  const LogisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = ContentData.logistics;
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(
        title: Text('物流追踪', style: AppTypography.h3),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.headset_mic_outlined, color: AppColors.charcoalBlack),
            splashRadius: 22,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.xs, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            _StatusCard(),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            const SizedBox(height: AppSpacing.md),
            _MapCard(),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('运输中',
                    style: AppTypography.serif(size: 19, weight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.xs),
                Text('预计 5 月 25 日(周六)送达', style: AppTypography.body),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Text('顺丰速运  SF1234567890123',
                        style: AppTypography.sans(size: 13, color: AppColors.textSecondary)),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(Icons.copy_outlined, size: 14, color: AppColors.inkGreen),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.pineGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.image),
            ),
            child: const Icon(Icons.local_shipping_outlined, color: AppColors.pineGreen, size: 30),
          ),
        ],
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Stack(
            children: [
              Image.asset('assets/images/logistics_map.png',
                  width: double.infinity, height: 160, fit: BoxFit.cover),
              const Positioned(left: 28, bottom: 22, child: _Pin(label: '发', place: '杭州仓')),
              const Positioned(right: 36, top: 44, child: _Pin(label: '收', place: '上海')),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('查看物流详情',
                    style: AppTypography.sans(size: 14, color: AppColors.textSecondary)),
                const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Pin extends StatelessWidget {
  const _Pin({required this.label, required this.place});
  final String label;
  final String place;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(label,
              style: AppTypography.sans(size: 12, weight: FontWeight.w600, color: AppColors.riceWhite)),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: AppColors.riceWhite,
            borderRadius: BorderRadius.circular(AppRadius.chip),
          ),
          child: Text(place, style: AppTypography.sans(size: 11, weight: FontWeight.w600)),
        ),
      ],
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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: active ? AppColors.inkGreen : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: active ? AppColors.inkGreen : AppColors.textTertiary, width: 1.5),
                ),
                child: Icon(Icons.check,
                    size: 12, color: active ? AppColors.riceWhite : AppColors.textTertiary),
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
