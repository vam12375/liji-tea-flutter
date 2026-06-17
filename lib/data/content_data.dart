import 'package:flutter/material.dart';

import '../models/content_models.dart';

/// Static content for the editorial / 茶文化 screens.
class ContentData {
  ContentData._();

  // ---------------------------------------------------------------------------
  // 商品评价 — reviews
  // ---------------------------------------------------------------------------
  static const List<Review> reviews = [
    Review(
      author: '茶香四溢',
      rating: 5,
      content: '包装很雅致,茶叶很新鲜,豆香明显,口感鲜爽,回甘持久,喜欢!',
      date: '2024.04.12',
      repurchase: 2,
      images: 3,
    ),
    Review(
      author: '静水流深',
      rating: 5,
      content: '明前龙井名不虚传,清香怡人,家人都很喜欢,会继续回购。',
      date: '2024.04.08',
      repurchase: 4,
      images: 1,
    ),
    Review(
      author: '一叶知春',
      rating: 5,
      content: '茶叶很干净,冲泡后嫩绿明亮,口感非常棒!',
      date: '2024.04.05',
      repurchase: 1,
    ),
  ];

  // ---------------------------------------------------------------------------
  // 节气 — solar terms
  // ---------------------------------------------------------------------------
  static const List<SolarTerm> solarTerms = [
    SolarTerm(
      name: '清明',
      pinyin: 'QING MING',
      poem: '清明时节雨纷纷,路上行人欲断魂。',
      recommendName: '明前龙井',
      recommendDesc: '清明时节,鲜爽甘醇',
      recommendPrice: 168,
      recommendTags: ['绿茶', '明前采摘'],
      foods: [
        TermFood(name: '青团', desc: '清香软糯'),
        TermFood(name: '艾草糕', desc: '艾香清新'),
        TermFood(name: '春笋', desc: '鲜嫩脆甜'),
      ],
      wellness: [
        TermWellness(label: '疏肝理气', icon: Icons.spa_outlined),
        TermWellness(label: '清肺润燥', icon: Icons.air_outlined),
        TermWellness(label: '养神明目', icon: Icons.visibility_outlined),
      ],
      gradient: [Color(0xFFE8EEE4), Color(0xFFD3E0CE)],
    ),
    SolarTerm(
      name: '谷雨',
      pinyin: 'GU YU',
      poem: '谷雨春光晓,山川翠色青。',
      recommendName: '雨前碧螺春',
      recommendDesc: '谷雨时节,嫩香鲜活',
      recommendPrice: 198,
      recommendTags: ['绿茶', '雨前采摘'],
      foods: [
        TermFood(name: '香椿芽', desc: '清香爽口'),
        TermFood(name: '谷雨茶饭', desc: '清淡育胃'),
        TermFood(name: '绿豆糕', desc: '清凉解暑'),
      ],
      wellness: [
        TermWellness(label: '健脾祛湿', icon: Icons.eco_outlined),
        TermWellness(label: '清热降火', icon: Icons.local_fire_department_outlined),
        TermWellness(label: '益气养生', icon: Icons.favorite_outline),
      ],
      gradient: [Color(0xFFE4ECE0), Color(0xFFCBDCC4)],
    ),
    SolarTerm(
      name: '白露',
      pinyin: 'BAI LU',
      poem: '白露秋风夜,一夜凉一夜。',
      recommendName: '白露寿眉',
      recommendDesc: '醇厚甘甜,秋意渐浓',
      recommendPrice: 228,
      recommendTags: ['白茶', '自然萎凋'],
      foods: [
        TermFood(name: '梨膏', desc: '润肺生津'),
        TermFood(name: '莲子羹', desc: '清心润燥'),
        TermFood(name: '桂花糕', desc: '香甜软糯'),
      ],
      wellness: [
        TermWellness(label: '润肺养阴', icon: Icons.air_outlined),
        TermWellness(label: '益胃生津', icon: Icons.water_drop_outlined),
        TermWellness(label: '安神养心', icon: Icons.favorite_outline),
      ],
      gradient: [Color(0xFFF0EBDD), Color(0xFFE0D5BE)],
    ),
    SolarTerm(
      name: '冬至',
      pinyin: 'DONG ZHI',
      poem: '冬至阳生春又来,天时人事日相催。',
      recommendName: '陈年普洱熟茶',
      recommendDesc: '温润脾胃,暖意相随',
      recommendPrice: 298,
      recommendTags: ['黑茶', '陈年静化'],
      foods: [
        TermFood(name: '汤圆', desc: '团圆美满'),
        TermFood(name: '红枣桂圆', desc: '温补养血'),
        TermFood(name: '姜枣茶', desc: '驱寒暖身'),
      ],
      wellness: [
        TermWellness(label: '温补阳气', icon: Icons.wb_sunny_outlined),
        TermWellness(label: '驱寒暖身', icon: Icons.local_fire_department_outlined),
        TermWellness(label: '养精蓄锐', icon: Icons.bedtime_outlined),
      ],
      gradient: [Color(0xFFEDEEF0), Color(0xFFD8DCE0)],
    ),
  ];

  // ---------------------------------------------------------------------------
  // 茶叶产区 — regions
  // ---------------------------------------------------------------------------
  static const List<String> regionProvinces = ['安徽', '浙江', '福建', '云南', '四川'];

  static const List<TeaRegion> regions = [
    TeaRegion(
      province: '安徽',
      title: '黄山·核心产区',
      desc: '云雾缭绕,高山温润,孕育鲜爽甘甜的好茶。',
      swatch: Color(0xFF8FA487),
    ),
    TeaRegion(
      province: '浙江',
      title: '西湖·龙井产区',
      desc: '群山环抱,气候温和,成就龙井的清香与鲜爽。',
      swatch: Color(0xFF9DB191),
    ),
    TeaRegion(
      province: '福建',
      title: '武夷·岩茶产区',
      desc: '丹霞地貌,岩骨花香,造就独特的岩韵。',
      swatch: Color(0xFFA08763),
    ),
    TeaRegion(
      province: '云南',
      title: '勐海·普洱产区',
      desc: '古茶树林立,大叶种醇厚,越陈越香。',
      swatch: Color(0xFF7E6A4D),
    ),
    TeaRegion(
      province: '四川',
      title: '蒙顶·名山产区',
      desc: '蒙顶山高,云雾常驻,甘露之名传千年。',
      swatch: Color(0xFF93A589),
    ),
  ];

  // ---------------------------------------------------------------------------
  // 冲泡指南 — brewing guide
  // ---------------------------------------------------------------------------
  static const List<BrewStep> brewSteps = [
    BrewStep(title: '温杯洁具', desc: '用热水将茶具温热,洁净茶具。', icon: Icons.local_drink_outlined),
    BrewStep(title: '投茶', desc: '取 3g 茶叶投入盖碗中。', icon: Icons.grass_outlined),
    BrewStep(title: '注水', desc: '沿盖碗壁缓缓注入 80-85℃ 热水。', icon: Icons.water_drop_outlined),
    BrewStep(title: '出汤', desc: '静置 15-20 秒,汤色明亮后出汤。', icon: Icons.coffee_outlined),
    BrewStep(title: '品饮', desc: '先闻其香,再品其味,感受回甘。', icon: Icons.emoji_food_beverage_outlined),
  ];

  // ---------------------------------------------------------------------------
  // 礼盒 / 茶礼定制
  // ---------------------------------------------------------------------------
  static const List<GiftBox> giftBoxes = [
    GiftBox(name: '山水·大雅礼盒', desc: '精选6款经典客茶', priceFrom: 588, swatch: Color(0xFF3C5246)),
    GiftBox(name: '明月·中秋礼盒', desc: '秋月作伴·回圆佳礼', priceFrom: 688, swatch: Color(0xFF2E4138)),
    GiftBox(name: '春和·春茶礼盒', desc: '明前春茶·鲜爽知初', priceFrom: 528, swatch: Color(0xFFC2A878)),
  ];

  static const List<String> giftSteps = ['选择包装', '选择茶品', '定制设计', '确认信息'];
  static const List<String> giftBoxSizes = ['小号 (20×16×8cm)', '中号 (28×20×9cm)', '大号 (36×25×10cm)'];

  // ---------------------------------------------------------------------------
  // 优惠券 — coupons
  // ---------------------------------------------------------------------------
  static const List<Coupon> coupons = [
    Coupon(amount: 30, threshold: 299, scope: '全场通用', expiry: '2024.06.01'),
    Coupon(amount: 50, threshold: 499, scope: '全场通用', expiry: '2024.06.15'),
    Coupon(amount: 10, threshold: 199, scope: '部分商品可用', expiry: '2024.05.20', usable: false),
  ];

  // ---------------------------------------------------------------------------
  // 茶文化 — culture aesthetics (和 / 静 / 雅 / 清)
  // ---------------------------------------------------------------------------
  static const List<Map<String, String>> cultureAesthetics = [
    {'word': '和', 'title': '和敬清寂', 'desc': '茶与心的对话'},
    {'word': '静', 'title': '静心一席', 'desc': '在茶中沉淀自我'},
    {'word': '雅', 'title': '器物之美', 'desc': '茶器寄托生活美学'},
    {'word': '清', 'title': '清净自然', 'desc': '回归本真的状态'},
  ];

  // ---------------------------------------------------------------------------
  // 物流追踪 — logistics timeline
  // ---------------------------------------------------------------------------
  static const List<Map<String, String>> logistics = [
    {'title': '运输中', 'desc': '包裹已到达【杭州转运中心】,正在发往【上海分拨中心】', 'time': '05-23 10:30'},
    {'title': '已发货', 'desc': '包裹已从【杭州仓】发出', 'time': '05-22 16:45'},
    {'title': '已打包', 'desc': '您的包裹已打包完成', 'time': '05-22 14:20'},
    {'title': '已付款', 'desc': '订单支付成功', 'time': '05-22 10:05'},
  ];
}
