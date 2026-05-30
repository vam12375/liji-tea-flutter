import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/product_list_tile.dart';
import '../widgets/soft_card.dart';
import 'product_detail_screen.dart';

/// AI 茶推荐 — a short questionnaire that yields tea recommendations.
class AiRecommendScreen extends StatefulWidget {
  const AiRecommendScreen({super.key});

  @override
  State<AiRecommendScreen> createState() => _AiRecommendScreenState();
}

class _AiRecommendScreenState extends State<AiRecommendScreen> {
  final _questions = const [
    ('你偏好的口感?', ['清淡鲜爽', '醇厚回甘', '香高馥郁', '甘甜柔和']),
    ('常在什么时候喝茶?', ['清晨提神', '午后小憩', '夜晚静饮', '餐后解腻']),
    ('你的体质偏向?', ['偏寒怕冷', '易上火', '肠胃敏感', '均衡平和']),
  ];
  final List<int> _answers = [-1, -1, -1];
  bool _done = false;

  bool get _ready => !_answers.contains(-1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI 茶推荐', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: _done ? _result() : _quiz(),
      ),
    );
  }

  Widget _quiz() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
            children: [
              SoftCard(
                color: AppColors.inkGreen,
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.gold),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text('回答几个小问题,茶博士为你推荐合适的茶',
                          style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              for (var q = 0; q < _questions.length; q++) ...[
                Text('${q + 1}. ${_questions[q].$1}',
                    style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (var o = 0; o < _questions[q].$2.length; o++)
                      GestureDetector(
                        onTap: () => setState(() => _answers[q] = o),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: _answers[q] == o ? AppColors.inkGreen : AppColors.cardSurface,
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                            border: Border.all(
                                color: _answers[q] == o ? AppColors.inkGreen : AppColors.divider),
                          ),
                          child: Text(_questions[q].$2[o],
                              style: AppTypography.sans(
                                  size: 13,
                                  color: _answers[q] == o
                                      ? AppColors.riceWhite
                                      : AppColors.textSecondary)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.sm,
              AppSpacing.screenMargin, AppSpacing.sm + MediaQuery.of(context).padding.bottom),
          child: PrimaryButton(
            label: '生成专属推荐',
            expand: true,
            onPressed: _ready ? () => setState(() => _done = true) : null,
          ),
        ),
      ],
    );
  }

  Widget _result() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
      children: [
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.auto_awesome, color: AppColors.gold, size: 20),
                const SizedBox(width: AppSpacing.xs),
                Text('茶博士的建议', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
              ]),
              const SizedBox(height: AppSpacing.sm),
              Text('根据你的偏好,推荐口感鲜爽、温润养胃的绿茶与白茶。'
                  '清晨可饮龙井提神,午后以白毫银针静心,皆宜温润冲泡。',
                  style: AppTypography.sans(size: 14, height: 1.7)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('为你甄选', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        for (final p in SampleData.recommended)
          ProductListTile(
            product: p,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
            ),
            onAdd: () {},
          ),
        const SizedBox(height: AppSpacing.lg),
        SecondaryButton(
          label: '重新测一次',
          expand: true,
          onPressed: () => setState(() {
            _done = false;
            for (var i = 0; i < _answers.length; i++) {
              _answers[i] = -1;
            }
          }),
        ),
      ],
    );
  }
}
