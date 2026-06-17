# 李记·TEA Design System

## Foundation System
**基础系统**

---

<br/>
<br/>

## 01 Color Tokens
**色彩体系**

<br/>

### Primary / 主色

```
墨绿 Ink Green
#1E3A32
用于主要按钮、导航选中态、品牌强调
```

```
松针绿 Pine Green
#355B4C
用于次要按钮、悬停态、辅助强调
```

<br/>

### Neutral / 中性色

```
米白 Rice White
#F7F4EE
背景色、大面积留白
```

```
宣纸灰 Rice Paper Gray
#E7E2D9
卡片表面、次级背景
```

```
炭黑 Charcoal Black
#1A1A1A
主要文本、标题
```

<br/>

### Accent / 强调色

```
烫金 Gold
#C6A56B
会员标识、限定标签、高级感点缀
```

<br/>

### Dark Theme / 夜茶模式

```
墨黑 Ink Black
#0D0F0E
深色模式背景
```

```
米灰 Rice Gray
#A8A296
深色模式次要文本
```

<br/>
<br/>

---

<br/>
<br/>

## 02 Typography
**字体系统**

<br/>

### 中文字体

**思源宋体 Noto Serif SC**  
用于标题、品牌展示、茶诗文

```
H1 / 28px / SemiBold / 行高 1.3
H2 / 22px / SemiBold / 行高 1.3
H3 / 18px / SemiBold / 行高 1.4
```

**思源黑体 Noto Sans SC**  
用于正文、UI 文本、说明

```
Body Large / 16px / Regular / 行高 1.6
Body / 14px / Regular / 行高 1.6
Caption / 12px / Regular / 行高 1.5
```

<br/>

### 英文字体

**Cormorant Garamond**  
用于 LIJI·TEA 品牌标识、英文标题

```
Brand / 34px / SemiBold / 字间距 2px
Heading / 22px / Medium / 字间距 1px
```

<br/>

### 字体层级示例

```
李记·TEA                    [H1 / 思源宋体 / 28px]
一杯好茶，陪你度过美好时光      [Body / 思源黑体 / 14px]

LIJI·TEA                   [Latin / Cormorant / 34px]
Oriental Tea Lifestyle      [Caption / 思源黑体 / 12px]
```

<br/>
<br/>

---

<br/>
<br/>

## 03 Spacing System
**间距系统**

<br/>

### 4pt Grid 基准

```
xs    4px    极小间距（图标与文字）
sm    8px    小间距（标签内边距）
md    12px   中等间距（卡片内容）
lg    16px   标准间距（列表项）
xl    24px   大间距（区块间隔）
xxl   32px   超大间距（页面留白）
```

<br/>

### 留白原则

**东方美学 · 超大留白**

- 页面顶部留白：32-48px
- 区块间距：24-32px
- 卡片内边距：16-20px
- 文字行间距：1.5-1.8x

<br/>

### 应用示例

```
┌─────────────────────────────────┐
│                                 │  ← 32px 顶部留白
│   李记·TEA                       │
│   一杯好茶，陪你度过美好时光       │
│                                 │  ← 24px 区块间距
│   ┌─────────────────────────┐  │
│   │                         │  │
│   │   [茶品卡片]             │  │  ← 16px 卡片内边距
│   │                         │  │
│   └─────────────────────────┘  │
│                                 │
└─────────────────────────────────┘
```

<br/>
<br/>

---

<br/>
<br/>

## 04 Grid System
**网格系统**

<br/>

### 12 Column Grid

```
Container Width: 375px (Mobile)
Columns: 12
Gutter: 16px
Margin: 16px
```

<br/>

### Safe Area

```
Top: Status Bar + 16px
Bottom: Home Indicator + 16px
Sides: 16px
```

<br/>

### 卡片对齐规则

```
全宽卡片：左右边距 16px
半宽卡片：占 6 列，间距 16px
三分卡片：占 4 列，间距 12px
```

<br/>

### 布局示例

```
┌─16px─┬────────────────────────┬─16px─┐
│      │                        │      │
│      │   [全宽卡片]            │      │
│      │                        │      │
│      ├──────────┬─16px─┬──────┤      │
│      │          │      │      │      │
│      │ [半宽]   │      │[半宽]│      │
│      │          │      │      │      │
│      └──────────┴──────┴──────┘      │
└──────────────────────────────────────┘
```

<br/>
<br/>

---

<br/>
<br/>

## 设计哲学

**Minimal Japanese Zen**  
极简禅意，东方留白

**墨绿体系**  
自然沉静，茶山本色

**山水水墨**  
意境悠远，文化底蕴

**高级杂志感**  
Apple × MUJI × 茶品牌

<br/>
<br/>

---

*李记·TEA Design System v1.0*  
*Foundation System — 基础系统*
