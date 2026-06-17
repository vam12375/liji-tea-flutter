# 李记·TEA Flutter App 优化分析报告

> 分析范围：当前仓库 `E:\liji-tea-flutter`。
> 代码规模：`lib/` 下 57 个 Dart 文件，约 7,174 行；其中 `screens/` 34 个页面文件、`widgets/` 11 个复用组件文件。
> 当前定位：高保真 Flutter 静态原型，已覆盖首页、分类、茶文化、购物车、账户、订单、支付、登录、设置等主要页面，但尚未形成真实业务闭环。
> 复核方式：基于源码、`pubspec.yaml`、平台配置、README、测试文件逐项检查。以下按优先级排序。

---

## 总体判断

项目的视觉方向和页面覆盖度已经比较完整：主题 token、字体层级、间距、圆角、卡片、按钮、空态组件都有统一封装，页面结构清晰，适合作为品牌电商 App 的高保真样机继续演进。

目前最主要的问题不是 UI 数量，而是产品能力没有连通：购物车、收藏、登录、设置、搜索、订单等仍以页面局部状态或静态数据驱动。用户在一个页面做出的操作，大多不会成为全局事实，也不会持久保存。因此它现在更像“可演示的原型”，而不是“可上线的应用”。

---

## P0：优先处理，会直接影响可用性

### 1. 缺少全局状态管理，关键业务状态彼此割裂

证据：

- `pubspec.yaml` 没有 `provider`、`riverpod`、`bloc` 等状态管理依赖。
- 全仓库主要依赖 `StatefulWidget + setState`。
- `ProductDetailScreen` 的收藏状态是页面内 `_favorite`。
- `FavoritesScreen` 使用本地写死的 `_ids`。
- `ProductDetailScreen._showAdded` 只弹出 SnackBar，不会真正写入购物车。
- `CartScreen` 初始化自 `SampleData.cart`，并在本页面内部维护 `_lines`。

影响：

- 商品详情页收藏后，收藏列表不会同步。
- 商品详情页加入购物车后，购物车数量和明细不会变化。
- 购物车修改数量、清空等操作只存在于当前页面生命周期内。
- 登录、设置、通知、深色模式等用户状态没有统一数据源。

建议：

先引入轻量状态层，推荐从 `provider` 或 `riverpod` 二选一即可，不需要过度设计。第一阶段抽出：

- `CartStore`：购物车明细、数量、选中、合计、加入购物车、删除、清空。
- `FavoriteStore`：收藏商品 id 集合、收藏/取消收藏。
- `AuthStore`：登录态、手机号、退出登录。
- `SettingsStore`：通知开关、主题模式。

完成后，详情页、收藏页、购物车、设置页都应依赖同一份 store，而不是各自维护局部副本。

### 2. 没有持久化，重启后状态全部丢失

证据：

- `pubspec.yaml` 没有 `shared_preferences`、`hive`、`sqflite`、`secure_storage` 等依赖。
- 搜索历史来自 `SampleData.searchHistory`。
- 购物车来自 `SampleData.cart`。
- 收藏来自 `FavoritesScreen._ids`。

影响：

- 购物车、收藏、登录态、搜索历史、设置项无法跨启动保存。
- 用户再次打开 App 时看到的是演示数据，而不是自己的数据。

建议：

状态层落地后再加持久化，避免把存储逻辑散落到页面里。

- 轻量阶段：`shared_preferences` 保存购物车 JSON、收藏 id、主题模式、搜索历史。
- 进阶阶段：`hive` 或 SQLite 保存结构化数据。
- 涉及 token、手机号等敏感信息时使用安全存储，不要放普通 preferences。

### 3. 字体依赖 `google_fonts` 运行时取字体，中文场景风险较高

证据：

- `lib/theme/app_typography.dart` 使用 `GoogleFonts.notoSerifSc`、`GoogleFonts.notoSansSc`、`GoogleFonts.cormorantGaramond`。
- `pubspec.yaml` 没有声明本地 `fonts:`。
- `flutter:` 下没有字体 asset。

影响：

- 首次渲染可能等待字体获取，弱网时更明显。
- 离线环境可能回退到系统字体，导致品牌字体失效。
- CJK 字体体积大，运行时拉取不适合稳定交付。

建议：

将品牌所需字重的字体文件放入 `assets/fonts/` 并在 `pubspec.yaml` 声明。中文字体建议做 subset 子集化，避免把完整 CJK 字库全部打包。随后把 `AppTypography` 改为本地 `TextStyle(fontFamily: ...)`。

如果短期保留 `google_fonts`，至少在启动时禁用运行时抓取并确保字体已随包内置：

```dart
GoogleFonts.config.allowRuntimeFetching = false;
```

---

## P1：接后端和产品化前应补齐

### 4. 缺少数据层与网络层，UI 直接绑定静态数据

证据：

- 商品、购物车、搜索热词都来自 `lib/data/sample_data.dart`。
- 没有 `http`、`dio`、repository、service、API client。
- 页面直接引用 `SampleData`，例如 `CartScreen`、`SearchScreen`、`FavoritesScreen`。

影响：

- 接真实后端时需要大面积改页面。
- loading、empty、error、retry 无法自然表达。
- mock 数据与真实数据切换成本高。

建议：

新增 `lib/repositories/` 或 `lib/services/`：

- `ProductRepository`
- `CartRepository`
- `OrderRepository`
- `UserRepository`
- `ContentRepository`

接口先返回 `Future<T>`，初期实现仍可读取 `SampleData`。这样 UI 先适配异步三态，后续替换成 HTTP 实现时页面改动会小很多。

### 5. 异步状态组件存在，但没有真正进入业务流

证据：

- `NetworkErrorScreen` 和 `StatusView` 已存在。
- `NetworkErrorScreen` 没有被其他文件引用。
- 空态主要用于购物车、收藏、搜索无结果，但没有真实 loading/error 数据流。

影响：

- 网络失败、接口超时、重试逻辑目前只是设计稿占位。
- 用户无法区分“真的没有数据”和“数据加载失败”。

建议：

配合 repository，把页面统一拆成：

- loading：骨架屏或加载中。
- empty：暂无数据。
- error：错误说明 + 重试。
- data：正常内容。

`StatusView` 可以继续复用，但需要补语义、按钮行为和不同状态文案。

### 6. 路由分散在页面中，不利于深链、Web 和埋点

证据：

- 全仓库大量 `Navigator.of(context).push(MaterialPageRoute(...))`。
- 没有 `go_router`、命名路由、集中路由表。
- `MaterialApp` 直接使用 `home: const AppShell()`。

影响：

- Web URL 不可表达具体页面。
- 商品详情、订单详情等无法通过链接直达。
- 登录拦截、返回栈、埋点和页面权限会越来越难维护。

建议：

引入 `go_router`，集中声明：

- `/`
- `/category`
- `/products/:id`
- `/cart`
- `/orders`
- `/orders/:id`
- `/login`
- `/settings`

同时把底部 tab shell 和详情页路由拆清楚，避免后续页面栈混乱。

### 7. 登录、验证码、协议、订单等仍是演示行为

证据：

- `LoginScreen` 的“获取验证码”是空 `onPressed: () {}`。
- 登录只校验协议勾选，然后 `pop()`。
- 用户协议、隐私政策在登录页只是彩色文本，不可点击。
- 设置页退出登录后只是跳转到登录页，没有修改全局登录态。
- 订单、支付、售后等页面主要是静态流程。

影响：

- 用户身份体系不存在，后续订单、地址、积分、优惠券都无法与真实用户绑定。
- 当前“登录成功/退出登录”只是页面导航，不是状态变化。

建议：

先定义最小 auth contract：

- 手机号验证码发送。
- 验证码登录。
- token 保存与刷新。
- 退出登录。
- 用户协议和隐私政策页面。
- 未登录访问购物车、订单、收藏等页面时的跳转策略。

即使后端未接入，也应先用 mock auth service 把状态流跑通。

---

## P2：体验质量和可维护性

### 8. 无障碍能力不足

证据：

- `rg "Semantics|semanticLabel|tooltip" lib` 无匹配。
- 底部导航是自定义 `InkWell + Icon + Text`，没有显式语义。
- 详情页收藏、分享等纯图标按钮没有 `tooltip`。
- 购物车 `_Check` 触达区域为 22 x 22，低于常见 48 x 48 触达建议。
- 登录页 checkbox 使用 `MaterialTapTargetSize.shrinkWrap`。

影响：

- 读屏用户很难理解纯图标按钮。
- 小触达区域影响移动端可用性。
- 自动化可访问性测试会暴露较多问题。

建议：

- 所有 `IconButton` 加 `tooltip`。
- 自定义可点击区域用 `Semantics(button: true, selected: ..., label: ...)`。
- 关键控件保证 48 x 48 最小触达。
- 底部导航标记当前选中 tab。

### 9. 深色主题 token 已定义，但没有真正接入

证据：

- `AppColors` 定义了 `inkBlack`、`riceGray`，注释为“夜茶模式”。
- `AppTheme` 只有 `light`。
- `MaterialApp` 只设置 `theme: AppTheme.light`。
- `SettingsScreen` 的“夜茶模式(深色)”开关只提示“即将上线”，不会改变应用主题。

影响：

- 设置项与实际能力不一致。
- 已有设计 token 没有形成完整主题系统。

建议：

新增 `AppTheme.dark`，由 `SettingsStore` 或系统设置驱动：

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: settings.themeMode,
)
```

### 10. 国际化缺失，与中英双语品牌定位不匹配

证据：

- 没有 `flutter_localizations`、`intl`。
- 全部文案硬编码在 Dart 文件里。
- 价格使用 `'¥$price'` 直接拼接。
- 品牌呈现为 `李记·TEA / LIJI·TEA`，但应用无 locale 能力。

影响：

- 文案维护困难。
- 价格、日期、数量等格式无法按地区变化。
- 后续做英文版或港澳台版本时改动成本高。

建议：

接入 Flutter 官方本地化流程，使用 ARB 管理文案。价格使用 `NumberFormat.simpleCurrency` 或封装 `MoneyText`，不要散落拼接。

### 11. 仍有空交互和占位体验

证据：

- `ProductDetailScreen` 分享按钮为空。
- `LoginScreen` 获取验证码为空。
- `SolarTermScreen` 的“查看”按钮为空。
- `CartScreen` 空购物车“去逛逛”按钮为空。
- `CategoryScreen` 对无商品分类显示“敬请期待”。

影响：

- 演示时会出现点击无反馈。
- 用户会误以为功能损坏。

建议：

空交互必须二选一：

- 接入真实行为，例如分享、跳转、发送验证码。
- 明确给出 toast、禁用态或“即将上线”说明。

### 12. README 与实际项目状态不一致

证据：

- README 仍写“当前为脚手架阶段：首页 + 商品详情”，但源码已经有 34 个页面文件。
- README 测试部分写“6 项全部通过”，实际 `test/widget_test.dart` 只有 3 个 widget 测试。
- README 项目结构写 `models/` 只有 `TeaProduct`，实际还有 account/content 模型。

影响：

- 新协作者会误判项目范围。
- 测试覆盖描述不可信。

建议：

同步 README：

- 更新功能列表为当前页面范围。
- 明确“当前为静态原型，核心业务未接后端”。
- 测试章节改为真实测试数量和运行命令。
- 增加架构状态与下一步计划。

### 13. 测试覆盖偏薄

证据：

- `test/widget_test.dart` 只有 3 个 widget 测试。
- 没有覆盖购物车合计、选择、数量变更。
- 没有覆盖搜索过滤。
- 没有覆盖收藏、登录协议校验、设置开关等核心交互。

建议：

优先补低成本、高价值测试：

- 购物车合计与全选逻辑。
- 搜索关键词过滤。
- 登录未勾选协议时显示提示。
- 收藏状态进入 store 后的增删。
- 加入购物车后购物车数量变化。

### 14. 平台元数据仍是 Flutter 默认状态

证据：

- `pubspec.yaml`：`description: "A new Flutter project."`
- Android：`android:label="liji_tea"`
- Web manifest：`name`、`short_name` 为 `liji_tea`，`description` 为默认值，`theme_color` / `background_color` 仍是 Flutter 蓝 `#0175C2`。
- 图标仍引用默认 `ic_launcher` 和 Web 默认 icon 文件。

影响：

- 安装后品牌识别不完整。
- Web PWA 信息与品牌不一致。
- 发布商店前会被视为未完成配置。

建议：

- `pubspec.yaml` 改为真实 description。
- Android/iOS/Web 统一应用名：`李记·TEA` 或发布策略指定名称。
- 用 `flutter_launcher_icons` 生成平台图标。
- 用 `flutter_native_splash` 配置启动屏。
- Web manifest 颜色改为品牌墨绿/米白。

### 15. 演示媒体直接进入仓库，无 Git LFS 管理

证据：

- `docs/` 下媒体和文档合计约 5.2 MB。
- 包含 `demo.gif`、`demo.mp4`、`account-screens-demo.gif`、`account-screens-demo.mp4`。
- 仓库没有 `.gitattributes`。

影响：

- 当前体积还能接受，但历史会持续膨胀。
- 后续继续提交录屏会明显拖慢 clone。

建议：

- 若继续保留视频/GIF，启用 Git LFS。
- 或只保留压缩 GIF，把高清视频放到 Release、对象存储或外部链接。

### 16. Lint 和 CI 仍是模板级

证据：

- `analysis_options.yaml` 仅 include `package:flutter_lints/flutter.yaml`。
- 自定义 lint 规则仍是注释示例。
- 未发现 `.github/workflows`。

建议：

逐步开启更严格规则，例如：

- `prefer_const_constructors`
- `require_trailing_commas`
- `use_super_parameters`
- `unnecessary_lambdas`
- `avoid_redundant_argument_values`

新增 CI，至少执行：

```bash
flutter pub get
flutter analyze
flutter test
```

---

## 建议落地路线

### 第一阶段：让业务状态连起来

目标：从“页面演示”变成“用户操作可持续影响应用状态”。

1. 引入状态管理。
2. 实现 `CartStore`、`FavoriteStore`、`AuthStore`、`SettingsStore`。
3. 商品详情加入购物车真正写入 `CartStore`。
4. 收藏页和详情页共用 `FavoriteStore`。
5. 设置页深色模式开关驱动 `ThemeMode`。
6. 用 `shared_preferences` 持久化购物车、收藏、主题和搜索历史。

### 第二阶段：隔离数据来源

目标：为接后端做准备，减少未来重写页面的成本。

1. 建立 repository/service 层。
2. UI 从直接读取 `SampleData` 改为调用 repository。
3. 页面补 loading、empty、error、retry。
4. `SampleData` 只作为 mock repository 的数据来源。

### 第三阶段：补产品基础设施

目标：让 App 接近可发布标准。

1. 引入 `go_router`。
2. 完善 auth mock/service contract。
3. 补协议、隐私政策、分享、验证码、空购物车跳转等行为。
4. 完成本地字体打包。
5. 修正平台元数据、图标、启动屏、Web manifest。

### 第四阶段：质量收口

目标：让项目可持续维护。

1. 更新 README，与真实页面范围和测试数量一致。
2. 补核心单元测试和 widget 测试。
3. 增加 CI。
4. 启用更严格 lint。
5. 处理演示媒体的 LFS 或外部托管策略。

---

## 优先级表

| 优先级 | 项目 | 当前问题 | 建议动作 |
| --- | --- | --- | --- |
| P0 | 状态管理 | 购物车、收藏、登录、设置割裂 | 引入 store 并接入关键页面 |
| P0 | 持久化 | 重启后全部丢失 | 用 preferences/hive 保存核心状态 |
| P0 | 字体 | 依赖 `google_fonts` 运行时字体 | 本地字体 + subset |
| P1 | 数据层 | UI 直接读静态数据 | repository/service 抽象 |
| P1 | 异步三态 | loading/error 未进入业务流 | 页面接入异步状态 |
| P1 | 路由 | `MaterialPageRoute` 分散 | 引入 `go_router` |
| P1 | 登录 | 验证码/登录态为演示 | 定义 auth contract |
| P2 | 无障碍 | 缺少 tooltip/Semantics | 补语义与触达尺寸 |
| P2 | 深色主题 | 只有开关占位 | `AppTheme.dark + ThemeMode` |
| P2 | README | 与实际状态不一致 | 更新文档 |
| P2 | 测试 | 仅 3 个 widget 测试 | 补核心逻辑测试 |
| P2 | 平台配置 | 默认名称/描述/图标 | 发布元数据品牌化 |

---

## 结论

这份代码的 UI 完成度高于 README 描述，已经不只是“首页 + 商品详情”的脚手架；但它的业务闭环完成度低于视觉完成度。下一步最值得投入的不是继续堆页面，而是把状态、持久化、数据层、路由这几条主干补起来。

建议先做 P0：状态管理、持久化、本地字体。完成后，用户的“收藏、加车、登录、设置”才会成为真实可感知的 App 行为；再推进 repository、路由、异步三态，项目就能比较平滑地从高保真原型进入可联调、可测试、可发布的阶段。
