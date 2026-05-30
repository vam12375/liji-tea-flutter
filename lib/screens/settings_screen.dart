import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/soft_card.dart';
import 'about_screen.dart';
import 'login_screen.dart';

/// 设置 — app settings with notification / dark-mode toggles.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notify = true;
  bool _darkMode = false;

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(msg, style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _confirmLogout() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        title: Text('退出登录', style: AppTypography.h3),
        content: Text('确定要退出当前账号吗?', style: AppTypography.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('取消', style: AppTypography.sans(size: 14, color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            child: Text('退出', style: AppTypography.sans(size: 14, color: AppColors.inkGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenMargin, AppSpacing.md, AppSpacing.screenMargin, AppSpacing.xl),
          children: [
            SoftCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _SwitchRow(
                    label: '消息通知',
                    value: _notify,
                    onChanged: (v) => setState(() => _notify = v),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _SwitchRow(
                    label: '夜茶模式(深色)',
                    value: _darkMode,
                    onChanged: (v) {
                      setState(() => _darkMode = v);
                      if (v) _toast('夜茶深色模式即将上线,敬请期待');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SoftCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _MenuRow(label: '账号与安全', onTap: () => _toast('账号与安全')),
                  _MenuRow(label: '清除缓存', trailing: '12.6 MB', onTap: () => _toast('缓存已清除')),
                  _MenuRow(label: '用户协议', onTap: () => _toast('用户协议')),
                  _MenuRow(label: '隐私政策', onTap: () => _toast('隐私政策')),
                  _MenuRow(
                    label: '关于我们',
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const AboutScreen())),
                    last: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            GestureDetector(
              onTap: _confirmLogout,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Text('退出登录',
                    style: AppTypography.sans(size: 15, weight: FontWeight.w500, color: AppColors.textSecondary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({required this.label, required this.value, required this.onChanged});

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      child: Row(
        children: [
          Text(label, style: AppTypography.sans(size: 14)),
          const Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.riceWhite,
            activeTrackColor: AppColors.inkGreen,
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.label, this.trailing, required this.onTap, this.last = false});

  final String label;
  final String? trailing;
  final VoidCallback onTap;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          border: last ? null : const Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            Text(label, style: AppTypography.sans(size: 14)),
            const Spacer(),
            if (trailing != null) Text(trailing!, style: AppTypography.caption),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
