import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Primary filled button (主按钮) from the Components System board.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.inkGreen,
        foregroundColor: AppColors.riceWhite,
        disabledBackgroundColor: AppColors.inkGreen.withValues(alpha: 0.35),
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
      child: Text(label, style: AppTypography.sans(size: 15, weight: FontWeight.w500, color: AppColors.riceWhite)),
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Secondary outlined button (次按钮).
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.inkGreen,
        side: const BorderSide(color: AppColors.inkGreen),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
      child: Text(label, style: AppTypography.sans(size: 15, weight: FontWeight.w500, color: AppColors.inkGreen)),
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
