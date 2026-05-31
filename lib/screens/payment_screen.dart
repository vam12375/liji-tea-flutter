import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';

/// 支付方式 — payment method selection.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.total});

  final int total;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _method = 0;

  static const _methods = <(IconData, String, String?)>[
    (Icons.wechat, '微信支付', null),
    (Icons.account_balance_wallet_outlined, '支付宝支付', null),
    (Icons.credit_card_outlined, '银联支付', null),
    (Icons.apple, 'Apple Pay', null),
    (Icons.calendar_month_outlined, '花呗分期', '可分 3/6/12 期'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('支付方式', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.lg, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('¥', style: AppTypography.serif(size: 22, weight: FontWeight.w700, color: AppColors.inkGreen)),
                      Text('${widget.total}.00',
                          style: AppTypography.serif(size: 40, weight: FontWeight.w700, color: AppColors.inkGreen)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text('订单提交成功,请在 29:52 内完成支付', style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('选择支付方式', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < _methods.length; i++)
                    InkWell(
                      onTap: () => setState(() => _method = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md, vertical: AppSpacing.md),
                        decoration: BoxDecoration(
                          border: i == _methods.length - 1
                              ? null
                              : const Border(bottom: BorderSide(color: AppColors.divider)),
                        ),
                        child: Row(
                          children: [
                            Icon(_methods[i].$1, color: AppColors.pineGreen),
                            const SizedBox(width: AppSpacing.sm),
                            Text(_methods[i].$2, style: AppTypography.sans(size: 15)),
                            if (_methods[i].$3 != null) ...[
                              const SizedBox(width: AppSpacing.xs),
                              Text(_methods[i].$3!, style: AppTypography.caption),
                            ],
                            const Spacer(),
                            _Radio(selected: _method == i),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, size: 14, color: AppColors.textTertiary),
                  const SizedBox(width: AppSpacing.xxs),
                  Text('安全加密支付,保障资金安全', style: AppTypography.caption),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.sm,
            AppSpacing.screenMargin, AppSpacing.sm + MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
          color: AppColors.riceWhite,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: PrimaryButton(
          label: '确认支付 ¥${widget.total}',
          expand: true,
          onPressed: () => context.goNamed(
            AppRoutes.paymentSuccess,
            pathParameters: {'total': '${widget.total}'},
          ),
        ),
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? AppColors.inkGreen : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: selected ? AppColors.inkGreen : AppColors.textTertiary),
      ),
      child: selected ? const Icon(Icons.check, size: 12, color: AppColors.riceWhite) : null,
    );
  }
}
