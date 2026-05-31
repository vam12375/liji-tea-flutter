import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../models/content_models.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';

/// 节气 — solar-term editorial pages (清明 / 谷雨 / 白露 / 冬至)
/// with a scenic hero and four content tabs.
class SolarTermScreen extends StatefulWidget {
  const SolarTermScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<SolarTermScreen> createState() => _SolarTermScreenState();
}

class _SolarTermScreenState extends State<SolarTermScreen> {
  late int _index = widget.initialIndex;
  int _tab = 1;

  static const _images = [
    'assets/images/season_qingming.png',
    'assets/images/season_guyu.png',
    'assets/images/season_bailu.png',
    'assets/images/season_dongzhi.png',
  ];

  static const _tabs = [
    ('节气故事', Icons.menu_book_outlined),
    ('茶推荐', Icons.local_cafe_outlined),
    ('茶食搭配', Icons.rice_bowl_outlined),
    ('茶席灵感', Icons.spa_outlined),
  ];

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
        child: Column(
          children: [
            _Hero(term: term, image: _images[_index]),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 34,
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.lg,
                    AppSpacing.screenMargin, AppSpacing.xl),
                children: [
                  switch (_tab) {
                    0 => _story(term),
                    1 => _recommend(term),
                    2 => _food(term),
                    _ => _aesthetics(term),
                  },
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.riceWhite,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            for (var i = 0; i < _tabs.length; i++)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _tab = i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_tabs[i].$2,
                            size: 22,
                            color: _tab == i ? AppColors.inkGreen : AppColors.textTertiary),
                        const SizedBox(height: 3),
                        Text(_tabs[i].$1,
                            style: AppTypography.sans(
                                size: 11,
                                weight: _tab == i ? FontWeight.w600 : FontWeight.w400,
                                color: _tab == i ? AppColors.inkGreen : AppColors.textTertiary)),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------- 节气故事
  Widget _story(SolarTerm term) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('节气故事', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('“${term.poem}”',
                  style: AppTypography.serif(
                      size: 17, height: 1.9, color: AppColors.inkGreen)),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${term.name},是二十四节气流转中的一处停顿。'
                '此时草木有信、风物含情,${term.recommendDesc},'
                '正适合为自己沏一壶${term.recommendName},于盏中静观四时更替。',
                style: AppTypography.sans(size: 14, height: 1.9, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final t in term.recommendTags) _Tag(t),
          ],
        ),
      ],
    );
  }

  // -------------------------------------------------------------- 茶推荐
  Widget _recommend(SolarTerm term) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('节气茶推荐', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        _Recommend(term: term),
        const SizedBox(height: AppSpacing.lg),
        _food(term),
      ],
    );
  }

  // -------------------------------------------------------------- 茶食搭配
  Widget _food(SolarTerm term) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('节气茶食搭配', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
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
    );
  }

  // -------------------------------------------------------------- 茶席灵感
  Widget _aesthetics(SolarTerm term) {
    const ideas = [
      ('插一枝时令', '取窗前一枝花木,置于茶席一隅,以候时令。', Icons.local_florist_outlined),
      ('焚一炉清香', '燃一缕沉香,让茶室安宁,心绪随烟舒展。', Icons.air_outlined),
      ('听一段古音', '佐一曲古琴或流水之声,与茶汤同饮此刻。', Icons.music_note_outlined),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${term.name}·茶席灵感', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        for (final (title, desc, icon) in ideas)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: SoftCard(
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.ricePaperGray.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppRadius.image),
                    ),
                    child: Icon(icon, color: AppColors.pineGreen, size: 22),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(desc,
                            style: AppTypography.sans(
                                size: 12, height: 1.6, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.term, required this.image});
  final SolarTerm term;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: term.gradient,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Image.asset(image, height: 200, fit: BoxFit.cover, alignment: Alignment.bottomCenter),
          ),
          Positioned(
            left: AppSpacing.screenMargin,
            top: AppSpacing.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(term.name,
                        style: AppTypography.serif(
                            size: 46, weight: FontWeight.w700, color: AppColors.inkGreen)),
                    const SizedBox(width: AppSpacing.xs),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9B2D2D),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('节\n气',
                          textAlign: TextAlign.center,
                          style: AppTypography.serif(
                              size: 10, height: 1.1, color: AppColors.riceWhite)),
                    ),
                  ],
                ),
                Text(term.pinyin,
                    style: AppTypography.latin(
                        size: 13, color: AppColors.pineGreen, letterSpacing: 3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(label, style: AppTypography.sans(size: 12, color: AppColors.pineGreen)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.ricePaperGray.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppRadius.image),
            ),
            child: const Icon(Icons.local_cafe, color: AppColors.pineGreen, size: 30),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(term.recommendName, style: AppTypography.sans(size: 16, weight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(term.recommendDesc, style: AppTypography.body),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  children: [for (final t in term.recommendTags) _Tag(t)],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('¥${term.recommendPrice}',
                        style: AppTypography.serif(
                            size: 20, weight: FontWeight.w700, color: AppColors.inkGreen)),
                    const SizedBox(width: 2),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text('起', style: AppTypography.caption),
                    ),
                    const Spacer(),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: AppColors.inkGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: AppColors.riceWhite, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
