---
name: testing-liji-tea
description: Build, serve, and test the 李记·TEA Flutter e-commerce app end-to-end in the browser. Use when verifying any screen/UI change in this repo.
---

# Testing 李记·TEA (Flutter web)

This app is a static (no backend) Flutter app. Easiest way to test UI end-to-end is via the web build in Chrome.

## Build & serve
```bash
flutter pub get
flutter build web
(cd build/web && python3 -m http.server 8090)
# open http://localhost:8090 in Chrome
```
Also run before pushing: `flutter analyze` and `flutter test`.

## App structure / navigation map
- 5 bottom tabs (left→right): 首页 / 分类 / 茶文化 / 购物车 / 我的 (see `lib/app.dart`).
- Home (`home_screen.dart`): search bar → SearchScreen; feature row → AI推荐 / 茶礼定制 / 节气; quick entries → 分类/冲泡指南/茶文化.
- 茶文化 hub → 节气(SolarTerm) / 冲泡指南 / 茶叶产区 / 品牌故事 / 茶席.
- Checkout chain: 购物车 → 订单确认 → 支付方式 → 支付成功 → 物流追踪.
- 我的 → 我的收藏 / 优惠券. 商品详情 → 商品评价. 茶礼定制 = 4-step wizard.
- All data is static in `lib/data/sample_data.dart` and `lib/data/content_data.dart`. Do NOT modify `lib/theme/` (design tokens).

## Known testing limitations / workarounds
- **CJK text input may not register in Flutter web text fields** when typed via automated tooling (xdotool). Workaround: trigger search via the 热门搜索 / 搜索历史 keyword chips, which run the same filter logic without typing. Latin text typing may work; prefer chips for Chinese queries.
- Pushed routes (订单确认/支付/支付成功/wizard) cover the bottom nav bar; use the in-page back arrow or 回到首页 button to return to the tab shell rather than clicking nav coords.
- Clicking a nav/card immediately after a route transition can land on the wrong target. Wait ~1s after a transition before the next click, and re-screenshot to confirm state.
- The web build renders full desktop width (not phone ratio); layout still works for functional verification.

## What to verify after screen changes
- Each of the 5 tabs renders real content, NOT the old "敬请期待" placeholder (regression check for broken wiring still pointing at PlaceholderScreen).
- Stateful flows: category switch updates list; cart steppers/totals; gift wizard step-gating (下一步 disabled until a tea is selected); favorites heart toggle removes item.

## Devin Secrets Needed
- None. App is fully static; no credentials/backend required.
