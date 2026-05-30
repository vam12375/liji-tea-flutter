import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';
import 'logistics_screen.dart';

/// 支付成功 — payment success confirmation.
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        TextButton(
          onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
          child: Text('完成', style: AppTypography.sans(size: 15, color: AppColors.inkGreen)),
        ),
      ]),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.inkGreen, width: 2),
                    ),
                    child: const Icon(Icons.check, size: 40, color: AppColors.inkGreen),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('支付成功', style: AppTypography.h2),
                  const SizedBox(height: AppSpacing.xs),
                  Text('感谢您的支持,茶香在路上', style: AppTypography.body),
                  const SizedBox(height: AppSpacing.xxs),
                  Text('订单号:20240520123456789', style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('预计送达时间', style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xxs),
                  Text('5 月 25 日(周六)09:00-18:00',
                      style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const Divider(height: AppSpacing.lg),
                  _action(context, Icons.receipt_long_outlined, '查看订单', () {}),
                  _action(context, Icons.local_shipping_outlined, '物流跟踪', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LogisticsScreen()));
                  }),
                  _action(context, Icons.headset_mic_outlined, '联系客服', () {}),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: '继续选购',
              expand: true,
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            ),
            const SizedBox(height: AppSpacing.sm),
            SecondaryButton(
              label: '回到首页',
              expand: true,
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            ),
          ],
        ),
      ),
    );
  }

  Widget _action(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.pineGreen),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: AppTypography.sans(size: 14)),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
