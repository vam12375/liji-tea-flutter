import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../models/content_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/segment_control.dart';
import '../widgets/tea_image.dart';

/// 商品评价 — reviews list with rating summary and filters.
class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productName});

  final String productName;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品评价', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            _summary(),
            const SizedBox(height: AppSpacing.lg),
            SegmentControl(
              segments: const ['全部', '好评 (98%)', '有图', '追评'],
              selected: _filter,
              onSelected: (i) => setState(() => _filter = i),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final r in ContentData.reviews) _ReviewCard(review: r),
          ],
        ),
      ),
    );
  }

  Widget _summary() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('4.9',
                style: AppTypography.serif(size: 40, weight: FontWeight.w700, color: AppColors.inkGreen)),
            Row(children: [
              for (var i = 0; i < 5; i++)
                const Icon(Icons.star, size: 14, color: AppColors.gold),
            ]),
            const SizedBox(height: AppSpacing.xxs),
            Text('共 1286 条评价', style: AppTypography.caption),
          ],
        ),
        const SizedBox(width: AppSpacing.xl),
        Expanded(
          child: Column(
            children: [
              for (final row in const [('5 星', 0.92), ('4 星', 0.06), ('3 星', 0.02), ('2 星', 0.0)])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text(row.$1, style: AppTypography.caption),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                          child: LinearProgressIndicator(
                            value: row.$2,
                            minHeight: 6,
                            backgroundColor: AppColors.ricePaperGray,
                            valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.ricePaperGray,
                child: Text(review.author.substring(0, 1),
                    style: AppTypography.sans(size: 13, color: AppColors.inkGreen)),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.author, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                    Row(children: [
                      for (var i = 0; i < 5; i++)
                        Icon(Icons.star,
                            size: 12,
                            color: i < review.rating ? AppColors.gold : AppColors.divider),
                    ]),
                  ],
                ),
              ),
              Text(review.date, style: AppTypography.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(review.content, style: AppTypography.sans(size: 14, height: 1.6)),
          if (review.photos.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                for (final photo in review.photos)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xs),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.image),
                      child: Image.asset(photo, width: 72, height: 72, fit: BoxFit.cover),
                    ),
                  ),
              ],
            ),
          ] else if (review.images > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                for (var i = 0; i < review.images; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xs),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: TeaImage(
                        swatch: const Color(0xFFA9B89A),
                        radius: AppRadius.image,
                        iconSize: 22,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          if (review.repurchase > 0) ...[
            const SizedBox(height: AppSpacing.xs),
            Text('第 ${review.repurchase + 1} 次回购', style: AppTypography.caption),
          ],
        ],
      ),
    );
  }
}
