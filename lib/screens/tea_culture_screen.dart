import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/section_header.dart';
import 'brand_story_screen.dart';
import 'brewing_guide_screen.dart';
import 'search_screen.dart';
import 'solar_term_screen.dart';
import 'tea_aesthetics_screen.dart';
import 'tea_region_screen.dart';

/// 茶文化 — editorial content page with top tabs
/// (茶道美学 / 茶器之美 / 节气茶事 / 茶人故事).
class TeaCultureScreen extends StatefulWidget {
  const TeaCultureScreen({super.key});

  @override
  State<TeaCultureScreen> createState() => _TeaCultureScreenState();
}

class _TeaCultureScreenState extends State<TeaCultureScreen> {
  static const _tabs = ['茶道美学', '茶器之美', '节气茶事', '茶人故事'];
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            _tabBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(AppSpacing.screenMargin,
                    AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
                children: _body(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------- header
  Widget _header(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xs, AppSpacing.xs, AppSpacing.xs, 0),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: canPop
                ? IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.charcoalBlack, size: 22),
                    splashRadius: 20,
                  )
                : null,
          ),
          Expanded(
            child: Center(
              child: Text('茶文化', style: AppTypography.h3),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SearchScreen())),
            icon: const Icon(Icons.search_rounded,
                color: AppColors.charcoalBlack, size: 22),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------- tab bar
  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
      child: Row(
        children: [
          for (var i = 0; i < _tabs.length; i++)
            GestureDetector(
              onTap: () => setState(() => _tab = i),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: AppSpacing.lg, top: AppSpacing.xs, bottom: AppSpacing.xs),
                child: Column(
                  children: [
                    Text(
                      _tabs[i],
                      style: AppTypography.sans(
                        size: 15,
                        weight: i == _tab ? FontWeight.w700 : FontWeight.w400,
                        color: i == _tab
                            ? AppColors.inkGreen
                            : AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 20,
                      height: 2,
                      decoration: BoxDecoration(
                        color: i == _tab ? AppColors.inkGreen : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------- body
  List<Widget> _body(BuildContext context) {
    switch (_tab) {
      case 1:
        return _craft(context);
      case 2:
        return _seasons(context);
      case 3:
        return _people(context);
      default:
        return _aesthetics(context);
    }
  }

  // ---- 茶道美学 ------------------------------------------------------
  List<Widget> _aesthetics(BuildContext context) {
    return [
      const _FeaturedHero(),
      const SizedBox(height: AppSpacing.lg),
      SectionHeader(
        title: '茶道美学',
        actionLabel: '更多',
        onAction: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TeaAestheticsScreen())),
      ),
      const SizedBox(height: AppSpacing.sm),
      GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.62,
        children: [
          for (final a in ContentData.cultureAesthetics)
            _AestheticTile(word: a['word']!, title: a['title']!, desc: a['desc']!),
        ],
      ),
      const SizedBox(height: AppSpacing.lg),
      const _QuoteCard(),
    ];
  }

  // ---- 茶器之美 ------------------------------------------------------
  List<Widget> _craft(BuildContext context) {
    return [
      Text('器以载道', style: AppTypography.h3),
      const SizedBox(height: AppSpacing.xs),
      Text('一壶一盏皆有性情,于器物之间见生活美学。', style: AppTypography.body),
      const SizedBox(height: AppSpacing.lg),
      _EntryTile(
        icon: Icons.water_drop_outlined,
        title: '冲泡指南',
        subtitle: '不同茶类的水温 · 投茶 · 时间',
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const BrewingGuideScreen())),
      ),
      _EntryTile(
        icon: Icons.terrain_outlined,
        title: '茶叶产区',
        subtitle: '循着山川,探寻茶香源头',
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TeaRegionScreen())),
      ),
      _EntryTile(
        icon: Icons.local_cafe_outlined,
        title: '茶道美学',
        subtitle: '和敬清寂 · 四重境界',
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TeaAestheticsScreen())),
      ),
    ];
  }

  // ---- 节气茶事 ------------------------------------------------------
  List<Widget> _seasons(BuildContext context) {
    return [
      SectionHeader(
        title: '二十四节气',
        actionLabel: '全部',
        onAction: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SolarTermScreen())),
      ),
      const SizedBox(height: AppSpacing.xs),
      Text('顺时而饮,应季而食,在节气流转中品味茶香。', style: AppTypography.body),
      const SizedBox(height: AppSpacing.md),
      Row(
        children: [
          for (var i = 0; i < ContentData.solarTerms.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SolarTermScreen(initialIndex: i))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.image),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: ContentData.solarTerms[i].gradient,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(ContentData.solarTerms[i].name,
                            style: AppTypography.serif(
                                size: 18,
                                weight: FontWeight.w700,
                                color: AppColors.inkGreen)),
                        const SizedBox(height: 2),
                        Text(ContentData.solarTerms[i].pinyin,
                            style: AppTypography.latin(
                                size: 9, color: AppColors.pineGreen)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ];
  }

  // ---- 茶人故事 ------------------------------------------------------
  List<Widget> _people(BuildContext context) {
    return [
      Text('一脉茶香', style: AppTypography.h3),
      const SizedBox(height: AppSpacing.xs),
      Text('每一片茶叶背后,都有一群与时间为伴的茶人。', style: AppTypography.body),
      const SizedBox(height: AppSpacing.lg),
      _EntryTile(
        icon: Icons.menu_book_outlined,
        title: '品牌故事',
        subtitle: '李记·TEA 的一脉茶香',
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const BrandStoryScreen())),
      ),
      const SizedBox(height: AppSpacing.xs),
      const _QuoteCard(
        text: '从一片山场到一杯茶汤,\n李记·TEA 始终以古法手作,\n只为还原茶叶最本真的滋味。',
      ),
    ];
  }
}

// =====================================================================
// Featured hero with a vertical 《茶经》 quote overlay.
class _FeaturedHero extends StatelessWidget {
  const _FeaturedHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Stack(
            children: [
              Image.asset('assets/images/culture_hero.png',
                  width: double.infinity, height: 230, fit: BoxFit.cover),
              Positioned(
                left: AppSpacing.lg,
                top: AppSpacing.lg,
                bottom: AppSpacing.lg,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _VerticalText('茶之为饮,'),
                    SizedBox(width: AppSpacing.xs),
                    _VerticalText('发乎神农氏,'),
                    SizedBox(width: AppSpacing.xs),
                    _VerticalText('闻于鲁周公。'),
                    SizedBox(width: AppSpacing.sm),
                    _VerticalText('—— 陆羽《茶经》', muted: true),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              Container(
                width: i == 0 ? 16 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: i == 0 ? AppColors.inkGreen : AppColors.divider,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Renders a string vertically (one glyph per line), evoking classical
/// Chinese typesetting.
class _VerticalText extends StatelessWidget {
  const _VerticalText(this.text, {this.muted = false});
  final String text;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final ch in text.split(''))
          Text(
            ch,
            style: AppTypography.serif(
              size: muted ? 11 : 14,
              weight: muted ? FontWeight.w400 : FontWeight.w600,
              color: muted ? AppColors.textSecondary : AppColors.charcoalBlack,
            ),
          ),
      ],
    );
  }
}

class _AestheticTile extends StatelessWidget {
  const _AestheticTile({required this.word, required this.title, required this.desc});
  final String word;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.image),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.pineGreen, AppColors.inkGreen],
              ),
            ),
            alignment: Alignment.center,
            child: Text(word,
                style: AppTypography.serif(
                    size: 34, weight: FontWeight.w700, color: AppColors.gold)),
          ),
        ),
        const SizedBox(height: 6),
        Text(title,
            textAlign: TextAlign.center,
            style: AppTypography.sans(size: 12, weight: FontWeight.w600)),
        const SizedBox(height: 1),
        Text(desc,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sans(size: 10, color: AppColors.textTertiary)),
      ],
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({this.text = '茶中见山水,心中见天地。\n一盏之间,便是一方安静的宇宙。'});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.ricePaperGray.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Text(
        text,
        style: AppTypography.serif(
            size: 15, weight: FontWeight.w600, color: AppColors.inkGreen, height: 1.7),
      ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.ricePaperGray.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppRadius.image),
              ),
              child: Icon(icon, color: AppColors.pineGreen),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
