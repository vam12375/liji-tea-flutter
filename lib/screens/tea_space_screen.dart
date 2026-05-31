import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/section_header.dart';
import 'tea_culture_screen.dart';

/// 茶席 — editorial home of the tea-aesthetics tab: a featured tea setting,
/// the 茶席美学 gallery, and a 茶文精选 article feed.
class TeaSpaceScreen extends StatefulWidget {
  const TeaSpaceScreen({super.key});

  @override
  State<TeaSpaceScreen> createState() => _TeaSpaceScreenState();
}

class _TeaSpaceScreenState extends State<TeaSpaceScreen> {
  static const _tabs = ['推荐', '茶道', '茶器', '茶文', '茶·生活'];
  int _tab = 0;

  static const _gallery = [
    ('assets/images/chaxi_g1.png', '山居茶事', '在山野间,煮一壶春色'),
    ('assets/images/chaxi_g2.png', '静心一席', '器物有形,茶意无境'),
    ('assets/images/chaxi_g3.png', '雨后清欢', '听雨煮茶,清寂自持'),
  ];

  void _openCulture() => Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const TeaCultureScreen()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenMargin, AppSpacing.sm, AppSpacing.screenMargin, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('茶席', style: AppTypography.h2),
                Icon(Icons.calendar_today_outlined,
                    size: 22, color: AppColors.charcoalBlack),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _TabBar(
            tabs: _tabs,
            selected: _tab,
            onSelected: (i) => setState(() => _tab = i),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.xl),
              children: [
                _Featured(onTap: _openCulture),
                const SizedBox(height: AppSpacing.lg),
                SectionHeader(title: '茶席美学', actionLabel: '更多', onAction: _openCulture),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < _gallery.length; i++)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: i == _gallery.length - 1 ? 0 : AppSpacing.xs),
                          child: _GalleryCard(
                            asset: _gallery[i].$1,
                            title: _gallery[i].$2,
                            subtitle: _gallery[i].$3,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                SectionHeader(title: '茶文精选', actionLabel: '更多', onAction: _openCulture),
                const SizedBox(height: AppSpacing.sm),
                _ArticleCard(
                  title: '如何选一款适合自己的绿茶?',
                  subtitle: '从产地、工艺、口感找到你的山头之味',
                  asset: 'assets/images/tea_thumb.png',
                  onTap: _openCulture,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.tabs, required this.selected, required this.onSelected});

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, i) {
          final active = i == selected;
          return GestureDetector(
            onTap: () => onSelected(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tabs[i],
                  style: AppTypography.sans(
                    size: 15,
                    weight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? AppColors.inkGreen : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 2,
                  width: 18,
                  decoration: BoxDecoration(
                    color: active ? AppColors.inkGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Featured extends StatelessWidget {
  const _Featured({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Image.asset(
          'assets/images/chaxi_featured.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.asset, required this.title, required this.subtitle});

  final String asset;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.image),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(asset, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(title, style: AppTypography.sans(size: 13, weight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sans(size: 11, height: 1.4, color: AppColors.textTertiary)),
      ],
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    required this.title,
    required this.subtitle,
    required this.asset,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTypography.sans(size: 15, weight: FontWeight.w600, height: 1.4)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(subtitle,
                      style: AppTypography.sans(size: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.image),
              child: Image.asset(asset, width: 84, height: 64, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
