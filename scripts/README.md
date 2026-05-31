# 字体下载脚本使用说明

## 快速开始

在项目根目录运行：

```powershell
.\scripts\download-fonts.ps1
```

## 功能说明

此脚本会自动：

1. ✅ 创建 `assets/fonts/` 目录
2. ✅ 从 GitHub 下载所需字体文件
3. ✅ 更新 `AppTypography._useLocalFonts = true`
4. ✅ 检查字体文件完整性

## 下载的字体

### 思源宋体 (Noto Serif SC)
- NotoSerifSC-Regular.otf
- NotoSerifSC-Medium.otf
- NotoSerifSC-SemiBold.otf
- NotoSerifSC-Bold.otf

### 思源黑体 (Noto Sans SC)
- NotoSansSC-Regular.otf
- NotoSansSC-Medium.otf
- NotoSansSC-SemiBold.otf
- NotoSansSC-Bold.otf

### Cormorant Garamond
- CormorantGaramond-Regular.ttf
- CormorantGaramond-Medium.ttf
- CormorantGaramond-SemiBold.ttf
- CormorantGaramond-Bold.ttf

## 参数选项

```powershell
# 跳过下载，只更新配置
.\scripts\download-fonts.ps1 -SkipDownload
```

## 下载完成后

1. 运行 `flutter pub get` 重新加载资源
2. 运行 `flutter clean` 清理缓存
3. 重新构建应用

## 故障排除

### 下载失败

如果自动下载失败，请手动下载：

**思源宋体和思源黑体**：
- 访问：https://github.com/googlefonts/noto-cjk/releases
- 下载最新版本的 OTF 文件
- 解压后将简体中文字体放入 `assets/fonts/`

**Cormorant Garamond**：
- 访问：https://github.com/CatharsisFonts/Cormorant/releases
- 下载 TTF 文件
- 放入 `assets/fonts/`

### 网络问题

如果 GitHub 访问较慢，可以：
1. 使用代理
2. 从 Google Fonts 下载
3. 从国内镜像站下载

### 文件大小

完整字体文件约 80-100MB，如果需要减小体积，请参考 `assets/fonts/README.md` 中的字体子集化方法。

## 验证安装

运行脚本后，检查：

```powershell
# 查看字体文件
Get-ChildItem assets\fonts\

# 检查配置
Get-Content lib\theme\app_typography.dart | Select-String "_useLocalFonts"
```

应该看到：
- 12 个字体文件（.otf 和 .ttf）
- `_useLocalFonts = true`
