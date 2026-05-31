import 'package:flutter/material.dart';

import '../models/tea_product.dart';

/// Static sample content used to populate the UI before a backend is wired up.
class SampleData {
  SampleData._();

  // ---------------------------------------------------------------------------
  // Products
  // ---------------------------------------------------------------------------

  static const TeaProduct longjing = TeaProduct(
    id: 'longjing',
    name: '明前龙井',
    origin: '浙江·杭州',
    category: '绿茶',
    tagline: '清香淡雅,鲜爽回甘',
    price: 168,
    unit: '50g',
    swatch: Color(0xFFA9B89A),
    imageAsset: 'assets/images/tea_detail2.png',
    thumbAsset: 'assets/images/tea_thumb.png',
    description: '甄选明前头采芽叶,遵循传统工艺,手工炒制而成。'
        '干茶扁平挺秀,色泽嫩绿光润;汤色嫩绿明亮,香气清雅持久,滋味鲜爽甘醇,回味悠长。',
    attributes: [
      ProductAttribute(label: '采摘', value: '明前头采', icon: Icons.eco_outlined),
      ProductAttribute(label: '产地', value: '西湖龙井村', icon: Icons.terrain_outlined),
      ProductAttribute(label: '口感', value: '鲜爽回甘', icon: Icons.water_drop_outlined),
      ProductAttribute(label: '香气', value: '豆香清雅', icon: Icons.spa_outlined),
    ],
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct biluochun = TeaProduct(
    id: 'biluochun',
    name: '碧螺春',
    origin: '江苏·苏州',
    category: '绿茶',
    tagline: '花果香,鲜爽生津',
    price: 128,
    unit: '50g',
    swatch: Color(0xFFB3C0A0),
    thumbAsset: 'assets/images/tea_thumb.png',
    description: '产自洞庭东西山,茶果间作,天然花果香。条索纤细卷曲似螺,白毫显露,'
        '汤色碧绿清澈,滋味鲜醇,回味甘甜。',
    attributes: [
      ProductAttribute(label: '采摘', value: '雨前嫩芽', icon: Icons.eco_outlined),
      ProductAttribute(label: '产地', value: '洞庭山', icon: Icons.terrain_outlined),
      ProductAttribute(label: '口感', value: '鲜醇生津', icon: Icons.water_drop_outlined),
      ProductAttribute(label: '香气', value: '花果清香', icon: Icons.spa_outlined),
    ],
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct anjiBaicha = TeaProduct(
    id: 'anji',
    name: '安吉白茶',
    origin: '浙江·安吉',
    category: '绿茶',
    tagline: '清甜鲜爽,氨基酸丰富',
    price: 138,
    unit: '50g',
    swatch: Color(0xFFAEBE9C),
    thumbAsset: 'assets/images/tea_thumb.png',
    description: '安吉白茶属绿茶类,因低温期白化而得名。氨基酸含量高,滋味清甜鲜爽,'
        '汤色嫩绿明亮,叶白脉翠,观之赏心悦目。',
    attributes: [
      ProductAttribute(label: '采摘', value: '春分前后', icon: Icons.eco_outlined),
      ProductAttribute(label: '产地', value: '浙江安吉', icon: Icons.terrain_outlined),
      ProductAttribute(label: '口感', value: '清甜鲜爽', icon: Icons.water_drop_outlined),
      ProductAttribute(label: '香气', value: '嫩香高扬', icon: Icons.spa_outlined),
    ],
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct mengding = TeaProduct(
    id: 'mengding',
    name: '蒙顶甘露',
    origin: '四川·雅安',
    category: '绿茶',
    tagline: '嫩香清雅,甘醇鲜爽',
    price: 118,
    unit: '50g',
    swatch: Color(0xFFB6C2A4),
    thumbAsset: 'assets/images/tea_thumb.png',
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct liuan = TeaProduct(
    id: 'liuan',
    name: '六安瓜片',
    origin: '安徽·六安',
    category: '绿茶',
    tagline: '栗香高长,回甘持久',
    price: 98,
    unit: '50g',
    swatch: Color(0xFFA7B595),
    thumbAsset: 'assets/images/tea_thumb.png',
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct baihaoYinzhen = TeaProduct(
    id: 'baihao',
    name: '白毫银针',
    origin: '福建·福鼎',
    category: '白茶',
    tagline: '毫香显露,清甜爽口',
    price: 188,
    unit: '50g',
    swatch: Color(0xFFD8D2BE),
    description: '白茶中的极品,满披白毫,色白如银,形似针。汤色杏黄明亮,毫香清鲜,'
        '滋味清甜醇厚,素有"茶中美女"之称。',
    attributes: [
      ProductAttribute(label: '采摘', value: '春芽单芽', icon: Icons.eco_outlined),
      ProductAttribute(label: '产地', value: '福鼎', icon: Icons.terrain_outlined),
      ProductAttribute(label: '口感', value: '清甜醇厚', icon: Icons.water_drop_outlined),
      ProductAttribute(label: '香气', value: '毫香清鲜', icon: Icons.spa_outlined),
    ],
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct shoumei = TeaProduct(
    id: 'shoumei',
    name: '白露寿眉',
    origin: '福建·政和',
    category: '白茶',
    tagline: '醇厚甘甜,秋意渐浓',
    price: 88,
    unit: '50g',
    swatch: Color(0xFFCFC8B2),
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct dahongpao = TeaProduct(
    id: 'dahongpao',
    name: '大红袍',
    origin: '福建·武夷山',
    category: '乌龙茶',
    tagline: '岩骨花香,醇厚回甘',
    price: 198,
    unit: '50g',
    swatch: Color(0xFF8A6E4B),
    description: '武夷岩茶之王,生长于岩缝之中,具独特"岩韵"。汤色橙黄明亮,香气馥郁,'
        '滋味醇厚,岩骨花香,回甘明显,耐冲泡。',
    attributes: [
      ProductAttribute(label: '工艺', value: '传统炭焙', icon: Icons.local_fire_department_outlined),
      ProductAttribute(label: '产地', value: '武夷山', icon: Icons.terrain_outlined),
      ProductAttribute(label: '口感', value: '醇厚回甘', icon: Icons.water_drop_outlined),
      ProductAttribute(label: '香气', value: '岩骨花香', icon: Icons.spa_outlined),
    ],
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct guihuaWulong = TeaProduct(
    id: 'guihua',
    name: '桂花乌龙',
    origin: '福建·安溪',
    category: '乌龙茶',
    tagline: '桂香馥郁,舒缓放松',
    price: 108,
    unit: '50g',
    swatch: Color(0xFFC2A878),
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct qimenHongcha = TeaProduct(
    id: 'qimen',
    name: '祁门红茶',
    origin: '安徽·祁门',
    category: '红茶',
    tagline: '蜜糖香甜,醇和温润',
    price: 158,
    unit: '50g',
    swatch: Color(0xFF9C5B3F),
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct puerShu = TeaProduct(
    id: 'puer',
    name: '陈年普洱熟茶',
    origin: '云南·勐海',
    category: '黑茶',
    tagline: '温润脾胃,暖意相随',
    price: 298,
    unit: '357g',
    swatch: Color(0xFF6B4A33),
    description: '精选云南大叶种晒青毛茶,经渥堆发酵陈化而成。汤色红浓明亮,'
        '陈香显著,滋味醇厚顺滑,温润养胃。',
    attributes: [
      ProductAttribute(label: '工艺', value: '渥堆发酵', icon: Icons.layers_outlined),
      ProductAttribute(label: '产地', value: '勐海', icon: Icons.terrain_outlined),
      ProductAttribute(label: '口感', value: '醇厚顺滑', icon: Icons.water_drop_outlined),
      ProductAttribute(label: '香气', value: '陈香显著', icon: Icons.spa_outlined),
    ],
    specs: ['100g', '357g 饼'],
  );

  static const TeaProduct molihua = TeaProduct(
    id: 'molihua',
    name: '茉莉花茶',
    origin: '福建·福州',
    category: '花茶',
    tagline: '花香清扬,鲜灵持久',
    price: 78,
    unit: '50g',
    swatch: Color(0xFFD9CFC0),
    specs: ['50g', '100g', '250g'],
  );

  static const TeaProduct shanshuiPot = TeaProduct(
    id: 'shanshui_pot',
    name: '山水茶壶',
    origin: '原创设计',
    category: '茶具',
    tagline: '山水入器,茶香相伴',
    price: 328,
    unit: '300ml',
    swatch: Color(0xFF4C5B52),
    imageAsset: 'assets/images/teapot_detail.png',
    thumbAsset: 'assets/images/teapot_detail.png',
    description: '灵感源自山水之间的宁静之美,壶身纹理如远山起伏,釉色温润,手感细腻。',
    attributes: [
      ProductAttribute(label: '材质', value: '陶瓷', icon: Icons.coffee_outlined),
      ProductAttribute(label: '容量', value: '300ml', icon: Icons.local_drink_outlined),
      ProductAttribute(label: '工艺', value: '手工拉坯', icon: Icons.handyman_outlined),
      ProductAttribute(label: '风格', value: '东方极简', icon: Icons.landscape_outlined),
    ],
    specs: ['单壶 (300ml)', '礼盒装 (壶+杯2)'],
  );

  static const TeaProduct baiciGaiwan = TeaProduct(
    id: 'gaiwan',
    name: '白瓷盖碗',
    origin: '茶席·器物',
    category: '茶具',
    tagline: '静心一席,茶香自来',
    price: 98,
    unit: '150ml',
    swatch: Color(0xFFE3DED2),
    specs: ['白瓷', '青瓷'],
  );

  static const TeaProduct chaze = TeaProduct(
    id: 'chaze',
    name: '茶则·竹制',
    origin: '茶道六君子之一',
    category: '茶具',
    tagline: '取茶量器,自然素雅',
    price: 28,
    unit: '件',
    swatch: Color(0xFFC8B68C),
    specs: ['竹制'],
  );

  static const TeaProduct chunshanGift = TeaProduct(
    id: 'chunshan_gift',
    name: '春山礼盒',
    origin: '礼盒装',
    category: '礼盒',
    tagline: '明前春茶·鲜爽知初',
    price: 298,
    unit: '龙井 50g×2 罐',
    swatch: Color(0xFF3C5246),
    thumbAsset: 'assets/images/gift_box.png',
    specs: ['标准装'],
  );

  // ---------------------------------------------------------------------------
  // Collections
  // ---------------------------------------------------------------------------

  /// 今日推荐 — the featured product on the home screen.
  static const TeaProduct featured = longjing;

  static const List<TeaProduct> allProducts = [
    longjing, biluochun, anjiBaicha, mengding, liuan,
    baihaoYinzhen, shoumei, dahongpao, guihuaWulong, qimenHongcha,
    puerShu, molihua, shanshuiPot, baiciGaiwan, chaze, chunshanGift,
  ];

  /// 分类 left-rail categories.
  static const List<String> categories = [
    '绿茶', '白茶', '乌龙茶', '红茶', '黑茶', '花茶', '茶具', '茶食', '礼盒',
  ];

  static List<TeaProduct> productsByCategory(String category) =>
      allProducts.where((p) => p.category == category).toList();

  /// Quick entries under the greeting.
  static const List<QuickEntry> quickEntries = [
    QuickEntry(label: '精选茶品', icon: Icons.local_cafe_outlined),
    QuickEntry(label: '茶具器物', icon: Icons.emoji_food_beverage_outlined),
    QuickEntry(label: '茶艺课程', icon: Icons.menu_book_outlined),
    QuickEntry(label: '茶生活', icon: Icons.spa_outlined),
  ];

  static const List<TeaProduct> recommended = [
    longjing, biluochun, anjiBaicha, shanshuiPot,
  ];

  /// 茶语 quote shown on the home screen.
  static const String teaQuote = '"茶之为饮,发乎神农氏,闻于鲁周公。"';
  static const String teaQuoteAuthor = '—— 陆羽《茶经》';

  // ---------------------------------------------------------------------------
  // Cart
  // ---------------------------------------------------------------------------

  static const List<CartItem> cart = [
    CartItem(product: longjing, spec: '50g', quantity: 1),
    CartItem(product: shanshuiPot, spec: '墨绿 · 300ml', quantity: 1),
    CartItem(product: chunshanGift, spec: '龙井 50g×2 罐 (礼盒装)', quantity: 1),
  ];

  /// Search — hot keywords and history.
  static const List<String> hotSearch = [
    '明前龙井', '安吉白茶', '碧螺春', '大红袍', '白毫银针', '普洱茶', '茉莉花茶', '茶具套装',
  ];

  static const List<String> searchHistory = ['明前龙井', '茶具', '白茶', '玻璃茶壶'];
}

/// A circular quick-entry shortcut on the home screen.
class QuickEntry {
  const QuickEntry({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
