# 李记·TEA 字体配置指南

本目录用于存放应用所需的本地字体文件。

## 所需字体

### 1. 思源宋体 (Noto Serif SC) - 用于标题和品牌展示

**下载地址**：
- 官方 GitHub: https://github.com/googlefonts/noto-cjk/releases
- Google Fonts: https://fonts.google.com/noto/specimen/Noto+Serif+SC

**所需字重**：
- `NotoSerifSC-Regular.otf` (400)
- `NotoSerifSC-Medium.otf` (500)
- `NotoSerifSC-SemiBold.otf` (600)
- `NotoSerifSC-Bold.otf` (700)

**子集化建议**：
完整的思源宋体文件约 10-15MB，建议使用工具进行子集化，只保留常用汉字：
```bash
# 使用 fonttools 进行子集化
pip install fonttools brotli
pyftsubset NotoSerifSC-Regular.otf \
  --text-file=common-chars.txt \
  --output-file=NotoSerifSC-Regular.otf \
  --flavor=woff2
```

### 2. 思源黑体 (Noto Sans SC) - 用于正文和 UI 文本

**下载地址**：
- 官方 GitHub: https://github.com/googlefonts/noto-cjk/releases
- Google Fonts: https://fonts.google.com/noto/specimen/Noto+Sans+SC

**所需字重**：
- `NotoSansSC-Regular.otf` (400)
- `NotoSansSC-Medium.otf` (500)
- `NotoSansSC-SemiBold.otf` (600)
- `NotoSansSC-Bold.otf` (700)

### 3. Cormorant Garamond - 用于英文标题和品牌名

**下载地址**：
- Google Fonts: https://fonts.google.com/specimen/Cormorant+Garamond
- GitHub: https://github.com/CatharsisFonts/Cormorant

**所需字重**：
- `CormorantGaramond-Regular.ttf` (400)
- `CormorantGaramond-Medium.ttf` (500)
- `CormorantGaramond-SemiBold.ttf` (600)
- `CormorantGaramond-Bold.ttf` (700)

## 安装步骤

1. 从上述地址下载字体文件
2. 将字体文件放入 `assets/fonts/` 目录
3. 确保文件名与 `pubspec.yaml` 中的配置一致
4. 运行 `flutter pub get` 重新加载资源
5. 重新构建应用

## 字体许可

- **思源宋体/黑体**：SIL Open Font License 1.1
- **Cormorant Garamond**：SIL Open Font License 1.1

这些字体均为开源字体，可免费用于商业项目。

## 当前状态

⚠️ **字体文件尚未添加**

当前应用使用 `google_fonts` 包在运行时加载字体。为了提升性能和离线体验，建议：

1. 下载并添加上述字体文件
2. 在 `lib/main.dart` 中移除 `GoogleFonts.config.allowRuntimeFetching = false;`
3. 应用将自动使用本地字体

## 临时方案

如果暂时无法添加本地字体文件，可以保持当前的 `google_fonts` 配置。但请注意：
- 首次加载可能较慢
- 需要网络连接
- 离线环境会回退到系统字体
