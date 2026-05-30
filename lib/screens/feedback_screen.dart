import 'package:flutter/material.dart';

import '../data/account_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';

/// 意见反馈 — feedback form (static demo).
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _type = 0;
  final TextEditingController _content = TextEditingController();
  final TextEditingController _contact = TextEditingController();

  @override
  void dispose() {
    _content.dispose();
    _contact.dispose();
    super.dispose();
  }

  void _submit() {
    if (_content.text.trim().isEmpty) {
      _toast('请先填写反馈内容');
      return;
    }
    Navigator.of(context).pop();
    _toast('感谢您的反馈,我们会认真倾听');
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(msg, style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('意见反馈', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            Text('反馈类型', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (var i = 0; i < AccountData.feedbackTypes.length; i++)
                  GestureDetector(
                    onTap: () => setState(() => _type = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: _type == i ? AppColors.inkGreen.withValues(alpha: 0.06) : AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: _type == i ? AppColors.inkGreen : AppColors.divider),
                      ),
                      child: Text(
                        AccountData.feedbackTypes[i],
                        style: AppTypography.sans(
                          size: 13,
                          weight: _type == i ? FontWeight.w600 : FontWeight.w400,
                          color: _type == i ? AppColors.inkGreen : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SoftCard(
              child: TextField(
                controller: _content,
                maxLines: 5,
                style: AppTypography.sans(size: 14),
                decoration: InputDecoration(
                  hintText: '请描述您的意见或建议,帮助我们做得更好…',
                  hintStyle: AppTypography.sans(size: 14, color: AppColors.textTertiary),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('联系方式(选填)', style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
            const SizedBox(height: AppSpacing.xs),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.image),
                border: Border.all(color: AppColors.divider),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: TextField(
                controller: _contact,
                style: AppTypography.sans(size: 15),
                decoration: InputDecoration(
                  hintText: '手机号或微信,方便我们回复您',
                  hintStyle: AppTypography.sans(size: 15, color: AppColors.textTertiary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: '提交反馈', expand: true, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
