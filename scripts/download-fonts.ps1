# 李记·TEA 字体自动下载脚本
# 自动下载思源宋体、思源黑体、Cormorant Garamond

param(
    [switch]$SkipDownload = $false
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "李记·TEA 字体自动下载工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 字体目录
$fontsDir = "assets\fonts"
$tempDir = "temp_fonts"

# 创建目录
if (-not (Test-Path $fontsDir)) {
    New-Item -ItemType Directory -Force -Path $fontsDir | Out-Null
    Write-Host "✓ 创建字体目录: $fontsDir" -ForegroundColor Green
}

if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
}

# 字体下载配置
$fonts = @{
    "NotoSerifSC" = @{
        "Name" = "思源宋体 Noto Serif SC"
        "Weights" = @("Regular", "Medium", "SemiBold", "Bold")
        "BaseUrl" = "https://github.com/googlefonts/noto-cjk/raw/main/Serif/OTF/SimplifiedChinese"
        "Extension" = "otf"
    }
    "NotoSansSC" = @{
        "Name" = "思源黑体 Noto Sans SC"
        "Weights" = @("Regular", "Medium", "SemiBold", "Bold")
        "BaseUrl" = "https://github.com/googlefonts/noto-cjk/raw/main/Sans/OTF/SimplifiedChinese"
        "Extension" = "otf"
    }
    "CormorantGaramond" = @{
        "Name" = "Cormorant Garamond"
        "Weights" = @("Regular", "Medium", "SemiBold", "Bold")
        "BaseUrl" = "https://github.com/CatharsisFonts/Cormorant/raw/master/fonts/ttf"
        "Extension" = "ttf"
    }
}

# 下载函数
function Download-Font {
    param(
        [string]$Family,
        [string]$Weight,
        [string]$Url,
        [string]$OutputPath
    )

    if (Test-Path $OutputPath) {
        Write-Host "  ✓ 已存在: $Weight" -ForegroundColor Yellow
        return $true
    }

    try {
        Write-Host "  ⬇ 下载中: $Weight..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath -UseBasicParsing
        Write-Host "  ✓ 完成: $Weight" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "  ✗ 失败: $Weight - $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# 下载所有字体
$totalFonts = 0
$successFonts = 0

if (-not $SkipDownload) {
    Write-Host "开始下载字体文件..." -ForegroundColor Cyan
    Write-Host ""

    foreach ($familyKey in $fonts.Keys) {
        $font = $fonts[$familyKey]
        Write-Host "[$($font.Name)]" -ForegroundColor Magenta

        foreach ($weight in $font.Weights) {
            $totalFonts++

            # 构建文件名和URL
            $fileName = "$familyKey-$weight.$($font.Extension)"
            $outputPath = Join-Path $fontsDir $fileName

            # 根据不同字体构建不同的URL
            if ($familyKey -eq "CormorantGaramond") {
                $url = "$($font.BaseUrl)/Cormorant-$weight.$($font.Extension)"
            } else {
                $url = "$($font.BaseUrl)/$fileName"
            }

            if (Download-Font -Family $familyKey -Weight $weight -Url $url -OutputPath $outputPath) {
                $successFonts++
            }
        }
        Write-Host ""
    }

    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "下载完成: $successFonts / $totalFonts" -ForegroundColor $(if ($successFonts -eq $totalFonts) { "Green" } else { "Yellow" })
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
}

# 更新 AppTypography 配置
Write-Host "更新字体配置..." -ForegroundColor Cyan

$typographyFile = "lib\theme\app_typography.dart"

if (Test-Path $typographyFile) {
    $content = Get-Content $typographyFile -Raw

    # 检查是否需要更新
    if ($content -match "static const bool _useLocalFonts = false;") {
        $newContent = $content -replace "static const bool _useLocalFonts = false;", "static const bool _useLocalFonts = true;"
        Set-Content -Path $typographyFile -Value $newContent -NoNewline
        Write-Host "✓ 已启用本地字体: AppTypography._useLocalFonts = true" -ForegroundColor Green
    } elseif ($content -match "static const bool _useLocalFonts = true;") {
        Write-Host "✓ 本地字体已启用" -ForegroundColor Yellow
    } else {
        Write-Host "✗ 未找到 _useLocalFonts 配置" -ForegroundColor Red
    }
} else {
    Write-Host "✗ 未找到文件: $typographyFile" -ForegroundColor Red
}

Write-Host ""

# 清理临时目录
if (Test-Path $tempDir) {
    Remove-Item -Path $tempDir -Recurse -Force
}

# 检查字体文件
Write-Host "检查字体文件..." -ForegroundColor Cyan
$fontFiles = Get-ChildItem -Path $fontsDir -Filter "*.otf","*.ttf" -ErrorAction SilentlyContinue

if ($fontFiles.Count -gt 0) {
    Write-Host "✓ 找到 $($fontFiles.Count) 个字体文件:" -ForegroundColor Green
    foreach ($file in $fontFiles) {
        $sizeKB = [math]::Round($file.Length / 1KB, 2)
        $sizeText = "$sizeKB KB"
        Write-Host "  - $($file.Name) ($sizeText)" -ForegroundColor Gray
    }
} else {
    Write-Host "✗ 未找到字体文件" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "下一步：" -ForegroundColor Yellow
Write-Host "1. 运行 'flutter pub get' 重新加载资源" -ForegroundColor White
Write-Host "2. 运行 'flutter clean' 清理缓存" -ForegroundColor White
Write-Host "3. 重新构建应用" -ForegroundColor White
Write-Host ""
Write-Host "注意：如果字体下载失败，请手动从以下地址下载：" -ForegroundColor Yellow
Write-Host "- 思源宋体: https://github.com/googlefonts/noto-cjk/releases" -ForegroundColor White
Write-Host "- 思源黑体: https://github.com/googlefonts/noto-cjk/releases" -ForegroundColor White
Write-Host "- Cormorant: https://github.com/CatharsisFonts/Cormorant/releases" -ForegroundColor White
