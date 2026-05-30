import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Pill segmented control (分段控制器) from the Components System board.
class SegmentControl extends StatelessWidget {
  const SegmentControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelected,
  });

  final List<String> segments;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.ricePaperGray,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        children: [
          for (var i = 0; i < segments.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(i),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: selected == i ? AppColors.inkGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Text(
                    segments[i],
                    style: AppTypography.sans(
                      size: 13,
                      weight: FontWeight.w500,
                      color: selected == i ? AppColors.riceWhite : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Horizontal scrollable text tabs with an underline indicator.
class TextTabs extends StatelessWidget {
  const TextTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onSelected,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            GestureDetector(
              onTap: () => onSelected(i),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tabs[i],
                      style: AppTypography.sans(
                        size: 15,
                        weight: selected == i ? FontWeight.w600 : FontWeight.w400,
                        color: selected == i ? AppColors.charcoalBlack : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      width: 20,
                      height: 2,
                      color: selected == i ? AppColors.inkGreen : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
