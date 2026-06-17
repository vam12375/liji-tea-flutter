import 'package:flutter/material.dart';

import '../data/account_data.dart';
import '../models/account_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';

/// 积分中心 — points balance and ledger.
class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('积分中心', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.inkGreen, AppColors.pineGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('我的积分', style: AppTypography.sans(size: 13, color: AppColors.riceGray)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('${AccountData.pointsBalance}',
                      style: AppTypography.serif(size: 40, weight: FontWeight.w700, color: AppColors.gold)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('积分可在下单时抵扣,或兑换优惠券与好礼',
                      style: AppTypography.sans(size: 12, color: AppColors.riceGray)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(child: _ActionTile(icon: Icons.redeem_outlined, label: '积分兑换')),
                SizedBox(width: AppSpacing.md),
                Expanded(child: _ActionTile(icon: Icons.event_available_outlined, label: '每日签到')),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('积分明细', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.sm),
            SoftCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < AccountData.pointRecords.length; i++)
                    _RecordRow(
                      record: AccountData.pointRecords[i],
                      last: i == AccountData.pointRecords.length - 1,
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

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: AppColors.inkGreen),
          const SizedBox(width: AppSpacing.xs),
          Text(label, style: AppTypography.sans(size: 14, weight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _RecordRow extends StatelessWidget {
  const _RecordRow({required this.record, required this.last});

  final PointRecord record;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final positive = record.delta >= 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.title, style: AppTypography.sans(size: 14)),
                const SizedBox(height: 2),
                Text(record.date, style: AppTypography.caption),
              ],
            ),
          ),
          Text(
            '${positive ? '+' : ''}${record.delta}',
            style: AppTypography.serif(
              size: 18,
              weight: FontWeight.w700,
              color: positive ? AppColors.inkGreen : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
