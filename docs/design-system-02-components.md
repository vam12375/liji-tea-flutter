# 李记·TEA Design System

## Components System
**组件系统**

---

<br/>
<br/>

## 01 Buttons
**按钮组件**

<br/>

### Primary Button / 主要按钮

```
背景：墨绿 #1E3A32
文字：米白 #F7F4EE
圆角：8px
高度：48px
内边距：16px 24px
字体：思源黑体 Medium 15px

状态：
- Default: 墨绿背景
- Hover: 松针绿 #355B4C
- Pressed: 墨绿 + 0.8 透明度
- Disabled: 宣纸灰 #E7E2D9
```

<br/>

### Secondary Button / 次要按钮

```
背景：透明
边框：1px 墨绿 #1E3A32
文字：墨绿 #1E3A32
圆角：8px
高度：48px
内边距：16px 24px

状态：
- Default: 透明背景 + 墨绿边框
- Hover: 米白背景 #F7F4EE
- Pressed: 宣纸灰背景 #E7E2D9
- Disabled: 边框和文字变为 #9C9A92
```

<br/>

### Ghost Button / 幽灵按钮

```
背景：透明
文字：墨绿 #1E3A32
无边框
高度：40px
内边距：12px 16px

用于：次要操作、取消、返回
```

<br/>

### 按钮尺寸

```
Large:  48px 高度（主要 CTA）
Medium: 40px 高度（表单、对话框）
Small:  32px 高度（卡片内操作）
```

<br/>
<br/>

---

<br/>
<br/>

## 02 Cards
**卡片组件**

<br/>

### Tea Product Card / 茶品卡片

```
尺寸：160px × 220px
背景：米白卡片 #FCFAF5
圆角：12px
阴影：0 2px 8px rgba(0,0,0,0.04)
内边距：12px

结构：
┌────────────────┐
│                │
│   [茶品图片]    │  ← 160×120px
│                │
├────────────────┤
│ 明前龙井        │  ← 思源宋体 16px
│ ¥298/50g      │  ← 思源黑体 14px
│ ★★★★★ 4.9   │  ← 评分
└────────────────┘
```

<br/>

### Seasonal Card / 节气卡片

```
尺寸：全宽 × 180px
背景：渐变（米白 → 宣纸灰）
圆角：16px
内边距：24px

结构：
┌─────────────────────────────┐
│                             │
│  谷雨                        │  ← 思源宋体 28px
│  Grain Rain                 │  ← Cormorant 18px
│  雨生百谷，茶香正浓           │  ← 思源黑体 14px
│                             │
│  [查看节气茶单]              │  ← Ghost Button
│                             │
└─────────────────────────────┘
```

<br/>

### Story Card / 故事卡片

```
尺寸：全宽 × 240px
背景：山水纹理 + 半透明墨绿遮罩
圆角：16px
内边距：24px

用于：品牌故事、茶文化、茶空间
```

<br/>

### Tea Space Card / 茶空间卡片

```
尺寸：全宽 × 320px
背景：大图 + 底部渐变遮罩
圆角：20px
文字：米白 #F7F4EE

用于：线下茶室、体验空间
```

<br/>
<br/>

---

<br/>
<br/>

## 03 Icon System
**图标系统**

<br/>

### 设计原则

**东方极简 · 线性图标**

- 线宽：1.5px
- 圆角：圆润处理
- 尺寸：20px / 24px / 28px
- 颜色：墨绿 / 松针绿 / 炭黑

<br/>

### 核心图标

```
茶壶    teapot          [首页、泡茶指南]
茶叶    tea-leaf        [分类、商品]
茶杯    teacup          [订单、购物车]
山水    landscape       [茶文化、产地]
节气    solar-term      [节气茶单]
收藏    favorite        [收藏、心愿单]
购物车  cart            [购物车]
用户    profile         [我的]
搜索    search          [搜索]
筛选    filter          [筛选]
```

<br/>

### 图标状态

```
Default:  线性轮廓
Active:   填充 + 墨绿色
Disabled: 灰色 #9C9A92
```

<br/>

### 图标使用规范

```
导航图标：24px
卡片图标：20px
按钮图标：20px
装饰图标：28px
```

<br/>
<br/>

---

<br/>
<br/>

## 04 Navigation
**导航组件**

<br/>

### Bottom Tab Bar / 底部导航

```
高度：60px + Safe Area
背景：米白 #F7F4EE
上边框：1px 分割线 #E3DED4

Tab 项：
- 图标：24px
- 文字：思源黑体 11px
- 间距：图标与文字 4px
- 选中色：墨绿 #1E3A32
- 未选中：次要文字 #9C9A92

5 个 Tab：
首页 / 分类 / 茶文化 / 购物车 / 我的
```

<br/>

### Top App Bar / 顶部导航

```
高度：56px + Status Bar
背景：米白 #F7F4EE
无阴影（扁平设计）

结构：
┌─────────────────────────────┐
│ [返回]  标题         [操作]  │
└─────────────────────────────┘

标题：思源宋体 18px SemiBold
图标：24px 墨绿色
```

<br/>

### Search Bar / 搜索框

```
高度：40px
背景：宣纸灰 #E7E2D9
圆角：20px（胶囊形）
内边距：12px 16px

占位符：思源黑体 14px 次要文字
图标：搜索 20px 松针绿
```

<br/>

### Segment Control / 分段控制

```
高度：36px
背景：宣纸灰 #E7E2D9
圆角：8px
内边距：2px

选中项：
- 背景：米白 #F7F4EE
- 文字：墨绿 #1E3A32
- 圆角：6px

未选中项：
- 背景：透明
- 文字：次要文字 #6B6B66
```

<br/>
<br/>

---

<br/>
<br/>

## 组件复用原则

**KISS 原则**  
保持简单，避免过度设计

**一致性**  
相同场景使用相同组件

**可访问性**  
最小触达区域 48×48px

**响应式**  
适配不同屏幕尺寸

<br/>
<br/>

---

*李记·TEA Design System v1.0*  
*Components System — 组件系统*
