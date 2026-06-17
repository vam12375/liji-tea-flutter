import 'package:flutter/material.dart';

import '../data/account_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';

/// 退款 / 售后 — after-sale application form (static demo).
class AfterSaleScreen extends StatefulWidget {
  const AfterSaleScreen({super.key});

  @override
  State<AfterSaleScreen> createState() => _AfterSaleScreenState();
}

class _AfterSaleScreenState extends State<AfterSaleScreen> {
  int _type = 0;
  int? _reason;
  final TextEditingController _desc = TextEditingController();

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  void _submit() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: Text('申请已提交', style: AppTypography.h3),
        content: Text('我们将在 24 小时内处理您的售后申请,请留意消息通知。',
            style: AppTypography.body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('好的', style: AppTypography.sans(size: 14, color: AppColors.inkGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('退款 / 售后', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('售后类型', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (var i = 0; i < AccountData.afterSaleTypes.length; i++)
                        _Chip(
                          label: AccountData.afterSaleTypes[i],
                          selected: _type == i,
                          onTap: () => setState(() => _type = i),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (var i = 0; i < AccountData.afterSaleReasons.length; i++)
                    InkWell(
                      onTap: () => setState(() => _reason = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md, vertical: AppSpacing.md),
                        decoration: BoxDecoration(
                          border: i == AccountData.afterSaleReasons.length - 1
                              ? null
                              : const Border(bottom: BorderSide(color: AppColors.divider)),
                        ),
                        child: Row(
                          children: [
                            Text(AccountData.afterSaleReasons[i], style: AppTypography.sans(size: 14)),
                            const Spacer(),
                            Icon(
                              _reason == i ? Icons.radio_button_checked : Icons.radio_button_off,
                              size: 20,
                              color: _reason == i ? AppColors.inkGreen : AppColors.textTertiary,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('问题描述', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.xs),
                  TextField(
                    controller: _desc,
                    maxLines: 4,
                    style: AppTypography.sans(size: 14),
                    decoration: InputDecoration(
                      hintText: '请描述您遇到的问题(选填)',
                      hintStyle: AppTypography.sans(size: 14, color: AppColors.textTertiary),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: '提交申请', expand: true, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: selected ? AppColors.inkGreen.withValues(alpha: 0.06) : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(color: selected ? AppColors.inkGreen : AppColors.divider),
        ),
        child: Text(
          label,
          style: AppTypography.sans(
            size: 13,
            weight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? AppColors.inkGreen : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
