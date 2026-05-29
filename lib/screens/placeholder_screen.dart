import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// A graceful "coming soon" placeholder for tabs not yet implemented.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.pineGreen.withValues(alpha: 0.5)),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: AppTypography.h2),
            const SizedBox(height: AppSpacing.xs),
            Text('敬请期待', style: AppTypography.body),
          ],
        ),
      ),
    );
  }
}
