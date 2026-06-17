import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../models/content_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';

/// 节气 — solar-term editorial pages (清明 / 谷雨 / 白露 / 冬至).
class SolarTermScreen extends StatefulWidget {
  const SolarTermScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<SolarTermScreen> createState() => _SolarTermScreenState();
}

class _SolarTermScreenState extends State<SolarTermScreen> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    final term = ContentData.solarTerms[_index];
    return Scaffold(
      backgroundColor: term.gradient.last,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('二十四节气', style: AppTypography.sans(size: 16, weight: FontWeight.w600)),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _Hero(term: term),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                itemCount: ContentData.solarTerms.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
                itemBuilder: (_, i) {
                  final selected = i == _index;
                  return GestureDetector(
                    onTap: () => setState(() => _index = i),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.inkGreen : AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(ContentData.solarTerms[i].name,
                          style: AppTypography.sans(
                              size: 13,
                              color: selected ? AppColors.riceWhite : AppColors.textSecondary)),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenMargin, AppSpacing.lg, AppSpacing.screenMargin, AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Recommend(term: term),
                  const SizedBox(height: AppSpacing.lg),
                  Text('节气茶食', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      for (final f in term.foods)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                            child: SoftCard(
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                              child: Column(
                                children: [
                                  Text(f.name, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                                  const SizedBox(height: 2),
                                  Text(f.desc, style: AppTypography.caption, textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('节气养生', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.sm),
                  SoftCard(
                    child: Row(
                      children: [
                        for (final w in term.wellness)
                          Expanded(
                            child: Column(
                              children: [
                                Icon(w.icon, size: 24, color: AppColors.pineGreen),
                                const SizedBox(height: AppSpacing.xs),
                                Text(w.label, style: AppTypography.sans(size: 12), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.term});
  final SolarTerm term;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenMargin, AppSpacing.lg, AppSpacing.screenMargin, AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: term.gradient,
        ),
      ),
      child: Column(
        children: [
          Text(term.name,
              style: AppTypography.serif(size: 44, weight: FontWeight.w700, color: AppColors.inkGreen)),
          const SizedBox(height: AppSpacing.xxs),
          Text(term.pinyin,
              style: AppTypography.latin(size: 14, color: AppColors.pineGreen, letterSpacing: 3)),
          const SizedBox(height: AppSpacing.md),
          Text(term.poem,
              style: AppTypography.serif(size: 15, height: 1.8, color: AppColors.charcoalBlack),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _Recommend extends StatelessWidget {
  const _Recommend({required this.term});
  final SolarTerm term;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.inkGreen,
              borderRadius: BorderRadius.circular(AppRadius.image),
            ),
            child: const Icon(Icons.local_cafe, color: AppColors.gold),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('节气茶推荐', style: AppTypography.caption),
                const SizedBox(height: 2),
                Text(term.recommendName, style: AppTypography.sans(size: 16, weight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(term.recommendDesc, style: AppTypography.body),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('¥${term.recommendPrice}',
                  style: AppTypography.serif(size: 18, weight: FontWeight.w700, color: AppColors.inkGreen)),
              const SizedBox(height: AppSpacing.xs),
              PrimaryButton(label: '查看', onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
