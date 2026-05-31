import 'package:flutter/material.dart';

import '../data/content_data.dart';
import '../data/sample_data.dart';
import '../models/content_models.dart';
import '../models/tea_product.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/section_header.dart';
import '../widgets/tea_image.dart';
import 'product_detail_screen.dart';

/// 茶叶产区 — China map, province tabs, a region detail card and region teas.
class TeaRegionScreen extends StatefulWidget {
  const TeaRegionScreen({super.key});

  @override
  State<TeaRegionScreen> createState() => _TeaRegionScreenState();
}

class _TeaRegionScreenState extends State<TeaRegionScreen> {
  int _index = 0;

  // Approximate dot positions (fractional) for the labelled provinces.
  static const _dots = <String, Offset>{
    '安徽': Offset(0.66, 0.46),
    '浙江': Offset(0.74, 0.56),
    '福建': Offset(0.70, 0.70),
  };

  List<TeaProduct> get _regionTeas {
    const names = ['六安瓜片', '祁门红茶', '安吉白茶', '大红袍'];
    return [
      for (final n in names)
        SampleData.allProducts.firstWhere((p) => p.name == n, orElse: () => SampleData.featured)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final regions = ContentData.regions;
    final region = regions[_index];
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: AppBar(title: Text('茶叶产区', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.xs, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            // China map with province dots
            SizedBox(
              height: 220,
              child: LayoutBuilder(builder: (context, c) {
                return Stack(
                  children: [
                    Center(
                      child: Image.asset('assets/images/china_map.png',
                          height: 220, fit: BoxFit.contain),
                    ),
                    for (final e in _dots.entries)
                      Positioned(
                        left: c.maxWidth * e.value.dx,
                        top: 220 * e.value.dy,
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                  color: AppColors.inkGreen, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 3),
                            Text(e.key,
                                style: AppTypography.sans(
                                    size: 12, weight: FontWeight.w600, color: AppColors.inkGreen)),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ),
            const SizedBox(height: AppSpacing.md),
            // province tabs
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: regions.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, i) {
                  final on = i == _index;
                  return GestureDetector(
                    onTap: () => setState(() => _index = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: on ? AppColors.inkGreen : AppColors.cardSurface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: on ? AppColors.inkGreen : AppColors.divider),
                      ),
                      child: Text(regions[i].province,
                          style: AppTypography.sans(
                              size: 13,
                              weight: on ? FontWeight.w600 : FontWeight.w400,
                              color: on ? AppColors.riceWhite : AppColors.textSecondary)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // region detail card
            _RegionDetail(region: region),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: '产区好茶', actionLabel: '更多', onAction: () {}),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < _regionTeas.length; i++) ...[
                  Expanded(child: _TeaMini(product: _regionTeas[i])),
                  if (i != _regionTeas.length - 1) const SizedBox(width: AppSpacing.xs),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RegionDetail extends StatelessWidget {
  const _RegionDetail({required this.region});
  final TeaRegion region;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(region.title, style: AppTypography.h3),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textTertiary),
              const SizedBox(width: 2),
              Text('${region.province} · ${region.title.split('·').first}',
                  style: AppTypography.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(region.desc, style: AppTypography.sans(size: 14, height: 1.8)),
          const SizedBox(height: AppSpacing.sm),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.image),
                child: Image.asset('assets/images/region_huangshan.png',
                    width: double.infinity, height: 130, fit: BoxFit.cover),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: AppColors.riceWhite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeaMini extends StatelessWidget {
  const _TeaMini({required this.product});
  final TeaProduct product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: TeaImage(swatch: product.swatch, radius: AppRadius.image, iconSize: 26),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(product.name,
              style: AppTypography.sans(size: 12, weight: FontWeight.w600),
              maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(product.category, style: AppTypography.caption),
          const SizedBox(height: 2),
          Row(
            children: [
              Text('¥${product.price}',
                  style: AppTypography.serif(
                      size: 14, weight: FontWeight.w700, color: AppColors.inkGreen)),
              Text(' 起', style: AppTypography.caption),
              const Spacer(),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(color: AppColors.inkGreen, shape: BoxShape.circle),
                child: const Icon(Icons.add, color: AppColors.riceWhite, size: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
