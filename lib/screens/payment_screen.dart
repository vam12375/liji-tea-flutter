import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';
import 'payment_success_screen.dart';

/// 支付方式 — payment method selection.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.total});

  final int total;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _method = 0;

  static const _methods = <_PayMethod>[
    _PayMethod(Color(0xFF07C160), Icons.wechat, '微信支付', null),
    _PayMethod(Color(0xFF1677FF), Icons.account_balance_wallet, '支付宝支付', null),
    _PayMethod(Color(0xFFE60012), Icons.credit_card, '银联支付', null),
    _PayMethod(Color(0xFF000000), Icons.apple, 'Apple Pay', null),
    _PayMethod(Color(0xFF1296DB), Icons.calendar_month, '花呗分期', '可分 3/6/12 期'),
  ];

  void _pay() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PaymentSuccessScreen(total: widget.total)),
      );

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
                      Text('¥',
                          style: AppTypography.serif(
                              size: 22, weight: FontWeight.w700, color: AppColors.inkGreen)),
                      Text('${widget.total}',
                          style: AppTypography.serif(
                              size: 44, weight: FontWeight.w700, color: AppColors.inkGreen)),
                      Text('.00',
                          style: AppTypography.serif(
                              size: 22, weight: FontWeight.w700, color: AppColors.inkGreen)),
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
            for (var i = 0; i < _methods.length; i++) ...[
              _MethodTile(
                method: _methods[i],
                selected: _method == i,
                onTap: () {
                  setState(() => _method = i);
                  _pay();
                },
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.lg),
            Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/splash_mountains.png',
                  height: 140, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md, top: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_outlined, size: 14, color: AppColors.textTertiary),
              const SizedBox(width: AppSpacing.xxs),
              Text('安全加密支付,保障资金安全', style: AppTypography.caption),
            ],
          ),
        ),
      ),
    );
  }
}

class _PayMethod {
  const _PayMethod(this.color, this.icon, this.label, this.sub);
  final Color color;
  final IconData icon;
  final String label;
  final String? sub;
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({required this.method, required this.selected, required this.onTap});
  final _PayMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SoftCard(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: method.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(method.icon, size: 20, color: Colors.white),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(method.label, style: AppTypography.sans(size: 15)),
            if (method.sub != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Text(method.sub!, style: AppTypography.caption),
            ],
            const Spacer(),
            _Radio(selected: selected),
          ],
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
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: selected ? AppColors.inkGreen : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: selected ? AppColors.inkGreen : AppColors.textTertiary),
      ),
      child: selected ? const Icon(Icons.check, size: 14, color: AppColors.riceWhite) : null,
    );
  }
}
