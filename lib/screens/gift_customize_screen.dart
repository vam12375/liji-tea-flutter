import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../data/sample_data.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';
import '../widgets/soft_card.dart';
import '../widgets/tea_image.dart';

// --------------------------------------------------------------------------
// Static customization options (kept local to the gift flow).
// --------------------------------------------------------------------------
const _boxStyles = [
  ('山水礼盒', Color(0xFF3C5246)),
  ('竹韵礼盒', Color(0xFF6E8A6E)),
  ('月映礼盒', Color(0xFFE3E7DF)),
  ('如意礼盒', Color(0xFFC2A878)),
];

const _packagingColors = [
  ('黛绿', Color(0xFF3C5246)),
  ('山黛', Color(0xFF8A968C)),
  ('月白', Color(0xFFF0EBDD)),
  ('玄果', Color(0xFF2B2B2B)),
  ('绯红', Color(0xFF9B2D2D)),
];

const _teaTabs = ['经典茶品', '春茶精选', '名茶系列', '茶具搭配'];

const _foilCrafts = [
  ('默认烫金', Icons.workspace_premium_outlined),
  ('篆金山水', Icons.landscape_outlined),
  ('烫金竹叶', Icons.eco_outlined),
  ('烫金云纹', Icons.cloud_outlined),
];

const _fonts = ['雅宋体', '行楷体', '隶书体'];

const _foilColors = [
  ('鎏金', Color(0xFFC9A86A)),
  ('玫瑰金', Color(0xFFC98B7A)),
  ('银灰', Color(0xFFB9C0BC)),
  ('暗金', Color(0xFF8A6D3B)),
];

const _usages = ['企业送礼', '节日礼盒', '个人礼赠'];

/// 茶礼定制首页 — landing hub linking to the customization wizard.
class GiftLandingScreen extends StatelessWidget {
  const GiftLandingScreen({super.key});

  static const _entries = [
    (Icons.business_center_outlined, '企业送礼'),
    (Icons.card_giftcard_outlined, '节日礼盒'),
    (Icons.handshake_outlined, '客户答谢'),
    (Icons.favorite_border, '个人收藏'),
  ];

  void _start(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GiftCustomizeScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('茶礼定制', style: AppTypography.h3),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // hero
            Container(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenMargin, 0, AppSpacing.screenMargin, AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('心意之礼 · 茶香传情', style: AppTypography.body),
                  const SizedBox(height: AppSpacing.sm),
                  GestureDetector(
                    onTap: () => _start(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: AppColors.gold),
                      ),
                      child: Text('定制属于你的专属好礼',
                          style: AppTypography.sans(size: 13, color: AppColors.inkGreen)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.pineGreen, AppColors.inkGreen],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('礼',
                              style: AppTypography.serif(
                                  size: 52, weight: FontWeight.w700, color: AppColors.gold)),
                          const SizedBox(height: AppSpacing.xs),
                          Text('LIJI · TEA',
                              style: AppTypography.latin(
                                  size: 12, color: AppColors.gold, letterSpacing: 3)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 4 quick entries
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: SoftCard(
                child: Row(
                  children: [
                    for (final e in _entries)
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _start(context),
                          child: Column(
                            children: [
                              Icon(e.$1, color: AppColors.pineGreen, size: 26),
                              const SizedBox(height: AppSpacing.xs),
                              Text(e.$2, style: AppTypography.caption),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // 礼盒推荐
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('礼盒推荐', style: AppTypography.sans(size: 16, weight: FontWeight.w600)),
                  Text('更多 ›', style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                itemCount: ContentData.giftBoxes.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (_, i) {
                  final box = ContentData.giftBoxes[i];
                  return GestureDetector(
                    onTap: () => _start(context),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: TeaImage(
                                swatch: box.swatch,
                                radius: AppRadius.card,
                                icon: Icons.card_giftcard,
                                iconSize: 38),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(box.name,
                              style: AppTypography.sans(size: 14, weight: FontWeight.w600),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(box.desc, style: AppTypography.caption, maxLines: 1),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('¥${box.priceFrom}',
                                  style: AppTypography.serif(
                                      size: 16, weight: FontWeight.w700, color: AppColors.inkGreen)),
                              Text(' 起', style: AppTypography.caption),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
              child: PrimaryButton(label: '开始定制', expand: true, onPressed: () => _start(context)),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

/// 茶礼定制 — a 4-step gift customization wizard.
class GiftCustomizeScreen extends StatefulWidget {
  const GiftCustomizeScreen({super.key});

  @override
  State<GiftCustomizeScreen> createState() => _GiftCustomizeScreenState();
}

class _GiftCustomizeScreenState extends State<GiftCustomizeScreen> {
  int _step = 0;
  int _style = 0;
  int _size = 1;
  int _color = 0;
  int _foil = 0;
  int _font = 0;
  int _foilColor = 0;
  int _usage = 0;
  int _qty = 1;
  int _teaTab = 0;
  final Set<String> _teas = {};
  final _inscription = TextEditingController(text: '茶香礼心');

  @override
  void initState() {
    super.initState();
    // Preselect a couple of teas so the flow has content.
    final preset = SampleData.allProducts
        .where((p) => p.category != '茶具' && p.category != '礼盒')
        .take(3)
        .map((p) => p.id);
    _teas.addAll(preset);
  }

  @override
  void dispose() {
    _inscription.dispose();
    super.dispose();
  }

  List<TeaProduct> get _teaList =>
      SampleData.allProducts.where((p) => p.category != '茶具' && p.category != '礼盒').toList();

  List<TeaProduct> get _selectedTeas =>
      SampleData.allProducts.where((p) => _teas.contains(p.id)).toList();

  int get _boxPrice => ContentData.giftBoxes[_style.clamp(0, ContentData.giftBoxes.length - 1)].priceFrom;
  int get _teaSum => _selectedTeas.fold(0, (s, p) => s + p.price);
  int get _subtotal => _boxPrice * _qty;

  bool get _canNext => _step == 1 ? _teas.isNotEmpty : true;

  void _next() {
    if (_step < ContentData.giftSteps.length - 1) {
      setState(() => _step++);
    } else {
      _showDone();
    }
  }

  void _showDone() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: Text('已加入购物车', style: AppTypography.h3),
        content: Text('你的茶礼定制已加入购物车,可在结算时选择开票与配送方式。',
            style: AppTypography.body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('好的', style: AppTypography.sans(size: 15, color: AppColors.inkGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(
        title: Text(ContentData.giftSteps[_step] == '选择包装'
            ? '选择礼盒包装'
            : _step == 1
                ? '选择礼盒组合'
                : _step == 2
                    ? '定制专属设计'
                    : '确认定制信息',
            style: AppTypography.h3),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenMargin),
              child: _StepIndicator(steps: ContentData.giftSteps, current: _step),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenMargin),
                child: switch (_step) {
                  0 => _boxStep(),
                  1 => _teaStep(),
                  2 => _designStep(),
                  _ => _confirmStep(),
                },
              ),
            ),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _bottomBar() {
    final label = _step == ContentData.giftSteps.length - 1 ? '加入购物车' : '下一步';
    final hint = switch (_step) {
      0 => ('礼盒价格', '¥$_boxPrice 起'),
      1 => ('已选 ${_teas.length} 款茶品', '¥$_teaSum'),
      3 => ('合计 ¥$_subtotal', '可开具发票 · 支持批量定制'),
      _ => null,
    };
    return Container(
      padding: EdgeInsets.fromLTRB(AppSpacing.screenMargin, AppSpacing.sm,
          AppSpacing.screenMargin, AppSpacing.sm + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: AppColors.riceWhite,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          if (hint != null) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_step == 3) ...[
                    Text(hint.$1,
                        style: AppTypography.serif(
                            size: 20, weight: FontWeight.w700, color: AppColors.inkGreen)),
                    Text(hint.$2, style: AppTypography.caption),
                  ] else ...[
                    Text(hint.$1, style: AppTypography.caption),
                    Text(hint.$2,
                        style: AppTypography.serif(
                            size: 20, weight: FontWeight.w700, color: AppColors.inkGreen)),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          if (_step > 0) ...[
            SecondaryButton(label: '上一步', onPressed: () => setState(() => _step--)),
            const SizedBox(width: AppSpacing.sm),
          ],
          if (hint == null) const Spacer(),
          SizedBox(
            width: hint != null ? 150 : null,
            child: PrimaryButton(
              label: label,
              expand: hint != null,
              onPressed: _canNext ? _next : null,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------- step 0 包装
  Widget _boxStep() {
    return ListView(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_boxStyles[_style].$2, AppColors.inkGreen],
            ),
          ),
          child: Center(
            child: Text('礼',
                style: AppTypography.serif(size: 56, weight: FontWeight.w700, color: AppColors.gold)),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('礼盒款式', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < _boxStyles.length; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                  child: GestureDetector(
                    onTap: () => setState(() => _style = i),
                    child: Column(
                      children: [
                        Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: _boxStyles[i].$2,
                            borderRadius: BorderRadius.circular(AppRadius.image),
                            border: Border.all(
                              color: _style == i ? AppColors.inkGreen : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text('礼',
                                style: AppTypography.serif(
                                    size: 22,
                                    weight: FontWeight.w700,
                                    color: AppColors.gold)),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(_boxStyles[i].$1,
                            style: AppTypography.sans(
                                size: 11,
                                color: _style == i ? AppColors.inkGreen : AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('礼盒尺寸', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < ContentData.giftBoxSizes.length; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                  child: GestureDetector(
                    onTap: () => setState(() => _size = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(AppRadius.image),
                        border: Border.all(
                          color: _size == i ? AppColors.inkGreen : AppColors.divider,
                          width: _size == i ? 2 : 1,
                        ),
                      ),
                      child: _SizeLabel(ContentData.giftBoxSizes[i]),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('包装颜色', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < _packagingColors.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () => setState(() => _color = i),
                  child: Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _packagingColors[i].$2,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _color == i ? AppColors.inkGreen : AppColors.divider,
                            width: _color == i ? 2 : 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(_packagingColors[i].$1, style: AppTypography.caption),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  // -------------------------------------------------------------- step 1 茶品
  Widget _teaStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _teaTabs.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
            itemBuilder: (_, i) {
              final selected = i == _teaTab;
              return GestureDetector(
                onTap: () => setState(() => _teaTab = i),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_teaTabs[i],
                        style: AppTypography.sans(
                            size: 14,
                            weight: selected ? FontWeight.w600 : FontWeight.w400,
                            color: selected ? AppColors.inkGreen : AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Container(
                        height: 2,
                        width: 24,
                        color: selected ? AppColors.inkGreen : Colors.transparent),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: ListView(
            children: [
              for (final p in _teaList)
                _TeaPick(
                  product: p,
                  selected: _teas.contains(p.id),
                  onTap: () => setState(() {
                    if (_teas.contains(p.id)) {
                      _teas.remove(p.id);
                    } else {
                      _teas.add(p.id);
                    }
                  }),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------- step 2 设计
  Widget _designStep() {
    return ListView(
      children: [
        _label('烫金工艺'),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < _foilCrafts.length; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                  child: GestureDetector(
                    onTap: () => setState(() => _foil = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(AppRadius.image),
                        border: Border.all(
                          color: _foil == i ? AppColors.inkGreen : AppColors.divider,
                          width: _foil == i ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(_foilCrafts[i].$2, color: AppColors.gold, size: 22),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(_foilCrafts[i].$1,
                              style: AppTypography.sans(size: 10), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _label('题字定制'),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _inscription,
          maxLength: 8,
          style: AppTypography.sans(size: 14),
          decoration: InputDecoration(
            hintText: '请输入文字(限8字以内)',
            counterText: '',
            filled: true,
            fillColor: AppColors.cardSurface,
            suffixIcon: TextButton(
              onPressed: () => setState(() => _inscription.text = '茶香礼心'),
              child: Text('推荐文案',
                  style: AppTypography.sans(size: 13, color: AppColors.pineGreen)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.image),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.image),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _label('字体选择'),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < _fonts.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => setState(() => _font = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: _font == i ? AppColors.inkGreen : AppColors.cardSurface,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                      border: Border.all(
                          color: _font == i ? AppColors.inkGreen : AppColors.divider),
                    ),
                    child: Text(_fonts[i],
                        style: AppTypography.sans(
                            size: 13,
                            color: _font == i ? AppColors.riceWhite : AppColors.textSecondary)),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _label('烫金颜色'),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < _foilColors.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () => setState(() => _foilColor = i),
                  child: Column(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _foilColors[i].$2,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _foilColor == i ? AppColors.inkGreen : AppColors.divider,
                            width: _foilColor == i ? 2 : 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(_foilColors[i].$1, style: AppTypography.caption),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _label('祝福卡片'),
        const SizedBox(height: AppSpacing.sm),
        SoftCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.local_florist_outlined, color: AppColors.pineGreen, size: 28),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_inscription.text.isEmpty ? '茶香礼心' : _inscription.text,
                        style: AppTypography.sans(size: 14, weight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text('静心以对,方得茶真味;以茶为礼,愿君常安康。',
                        style: AppTypography.sans(
                            size: 12, height: 1.7, color: AppColors.textSecondary)),
                    const SizedBox(height: 2),
                    Text('—— 李记茶', style: AppTypography.caption),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _label('预览效果'),
        const SizedBox(height: AppSpacing.sm),
        Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.pineGreen, AppColors.inkGreen],
            ),
          ),
          child: Center(
            child: Text(_inscription.text.isEmpty ? '茶香礼心' : _inscription.text,
                style: AppTypography.serif(
                    size: 26, weight: FontWeight.w700, color: _foilColors[_foilColor].$2)),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  // -------------------------------------------------------------- step 3 确认
  Widget _confirmStep() {
    final teas = _selectedTeas;
    return ListView(
      children: [
        SoftCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: TeaImage(
                    swatch: _boxStyles[_style].$2,
                    radius: AppRadius.image,
                    icon: Icons.card_giftcard,
                    iconSize: 30),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_boxStyles[_style].$1} (${_sizeName(_size)})',
                        style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text('${_packagingColors[_color].$1} · ${_sizeDim(_size)}',
                        style: AppTypography.caption),
                    const SizedBox(height: AppSpacing.xs),
                    Text('¥$_boxPrice',
                        style: AppTypography.serif(
                            size: 18, weight: FontWeight.w700, color: AppColors.inkGreen)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _sectionTitle('茶品组合 (${teas.length})'),
        SoftCard(
          child: Column(
            children: [
              for (final p in teas)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: TeaImage(swatch: p.swatch, radius: 6, iconSize: 14),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: Text(p.name, style: AppTypography.body)),
                      Text('${p.unit}  ', style: AppTypography.caption),
                      Text('¥${p.price}', style: AppTypography.body),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _sectionTitle('定制设计'),
        SoftCard(
          child: Column(
            children: [
              _row('烫金工艺', _foilCrafts[_foil].$1),
              const SizedBox(height: AppSpacing.xs),
              _row('题字内容', _inscription.text.isEmpty ? '未填写' : _inscription.text),
              const SizedBox(height: AppSpacing.xs),
              _row('烫金颜色', _foilColors[_foilColor].$1),
              const SizedBox(height: AppSpacing.xs),
              _row('祝福卡片', '已添加'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _sectionTitle('购买信息'),
        SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('用途类型', style: AppTypography.body),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  for (var i = 0; i < _usages.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: GestureDetector(
                        onTap: () => setState(() => _usage = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm, vertical: 6),
                          decoration: BoxDecoration(
                            color: _usage == i ? AppColors.inkGreen : AppColors.cardSurface,
                            borderRadius: BorderRadius.circular(AppRadius.chip),
                            border: Border.all(
                                color: _usage == i ? AppColors.inkGreen : AppColors.divider),
                          ),
                          child: Text(_usages[i],
                              style: AppTypography.sans(
                                  size: 12,
                                  color: _usage == i
                                      ? AppColors.riceWhite
                                      : AppColors.textSecondary)),
                        ),
                      ),
                    ),
                ],
              ),
              const Divider(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('数量', style: AppTypography.body),
                  _QtyStepper(
                    qty: _qty,
                    onMinus: () => setState(() => _qty = (_qty - 1).clamp(1, 99)),
                    onPlus: () => setState(() => _qty = (_qty + 1).clamp(1, 99)),
                  ),
                ],
              ),
              const Divider(height: AppSpacing.lg),
              _row('预计送达', '3-5 个工作日'),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('小计', style: AppTypography.body),
                  Text('¥$_subtotal',
                      style: AppTypography.serif(
                          size: 18, weight: FontWeight.w700, color: AppColors.inkGreen)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  // helpers
  Widget _label(String t) =>
      Text(t, style: AppTypography.sans(size: 15, weight: FontWeight.w600));

  Widget _sectionTitle(String t) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(t, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
      );

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.body),
        Text(value, style: AppTypography.sans(size: 14)),
      ],
    );
  }

  String _sizeName(int i) => const ['小号', '中号', '大号'][i];
  String _sizeDim(int i) => const ['20×16×8cm', '28×20×9cm', '36×25×10cm'][i];
}

class _SizeLabel extends StatelessWidget {
  const _SizeLabel(this.raw);
  final String raw; // e.g. "中号 (28×20×9cm)"

  @override
  Widget build(BuildContext context) {
    final open = raw.indexOf('(');
    final name = open > 0 ? raw.substring(0, open).trim() : raw;
    final dim = open > 0 ? raw.substring(open + 1, raw.length - 1) : '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: AppTypography.sans(size: 13, weight: FontWeight.w600)),
        if (dim.isNotEmpty) Text(dim, style: AppTypography.sans(size: 9, color: AppColors.textTertiary)),
      ],
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({required this.qty, required this.onMinus, required this.onPlus});
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _btn(Icons.remove, onMinus),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text('$qty', style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
        ),
        _btn(Icons.add, onPlus),
      ],
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: AppColors.inkGreen),
        ),
      );
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.steps, required this.current});
  final List<String> steps;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: i <= current ? AppColors.inkGreen : AppColors.ricePaperGray,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: i < current
                      ? const Icon(Icons.check, size: 16, color: AppColors.riceWhite)
                      : Text('${i + 1}',
                          style: AppTypography.sans(
                              size: 13,
                              weight: FontWeight.w600,
                              color: i == current ? AppColors.riceWhite : AppColors.textTertiary)),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(steps[i],
                  style: AppTypography.sans(
                      size: 11,
                      color: i <= current ? AppColors.inkGreen : AppColors.textTertiary)),
            ],
          ),
          if (i != steps.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                color: i < current ? AppColors.inkGreen : AppColors.divider,
              ),
            ),
        ],
      ],
    );
  }
}

class _TeaPick extends StatelessWidget {
  const _TeaPick({required this.product, required this.selected, required this.onTap});
  final TeaProduct product;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: selected ? AppColors.inkGreen : AppColors.divider,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: TeaImage(swatch: product.swatch, radius: AppRadius.image, iconSize: 24),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: AppTypography.sans(size: 15, weight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text('${product.category} | ${product.tagline}',
                      style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(product.unit,
                      style: AppTypography.sans(size: 11, color: AppColors.textTertiary)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: selected ? AppColors.inkGreen : AppColors.textTertiary,
                  size: 22,
                ),
                const SizedBox(height: AppSpacing.md),
                Text('¥${product.price}',
                    style: AppTypography.serif(
                        size: 16, weight: FontWeight.w700, color: AppColors.inkGreen)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
