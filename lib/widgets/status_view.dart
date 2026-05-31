import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'primary_button.dart';

/// A centred empty / error state (购物车空 / 暂无收藏 / 网络异常 / 无结果).
class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    this.icon,
    this.image,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  }) : assert(icon != null || image != null, 'provide an icon or image');

  final IconData? icon;
  final String? image;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (image != null)
          Image.asset(image!, width: 200, height: 158, fit: BoxFit.contain)
        else
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.ricePaperGray.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 52, color: AppColors.pineGreen.withValues(alpha: 0.6)),
          ),
        const SizedBox(height: AppSpacing.lg),
        Text(title, style: AppTypography.h3),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle!, style: AppTypography.body, textAlign: TextAlign.center),
        ],
        if (actionLabel != null) ...[
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: actionLabel!, onPressed: onAction),
        ],
      ],
    );
  }
}
