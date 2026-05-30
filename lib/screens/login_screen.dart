import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';

/// 登录 / 注册 — phone + verification code sign-in (static demo).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_agreed) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('请先阅读并同意用户协议与隐私政策',
                style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
            backgroundColor: AppColors.inkGreen,
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const CloseButton()),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.xl),
          children: [
            Center(
              child: Column(
                children: [
                  Text('LIJI·TEA',
                      style: AppTypography.latin(size: 34, weight: FontWeight.w600, letterSpacing: 2)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('一杯好茶,陪你度过美好时光', style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('手机号登录', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.lg),
            _InputField(
              controller: _phone,
              hint: '请输入手机号',
              icon: Icons.phone_iphone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.md),
            _InputField(
              controller: _code,
              hint: '请输入验证码',
              icon: Icons.lock_outline,
              keyboardType: TextInputType.number,
              suffix: TextButton(
                onPressed: () {},
                child: Text('获取验证码',
                    style: AppTypography.sans(size: 13, color: AppColors.inkGreen)),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: '登录', expand: true, onPressed: _submit),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v ?? false),
                  activeColor: AppColors.inkGreen,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: AppTypography.caption,
                      children: const [
                        TextSpan(text: '我已阅读并同意 '),
                        TextSpan(text: '《用户协议》', style: TextStyle(color: AppColors.inkGreen)),
                        TextSpan(text: ' 和 '),
                        TextSpan(text: '《隐私政策》', style: TextStyle(color: AppColors.inkGreen)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.divider)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text('其他登录方式', style: AppTypography.caption),
                ),
                const Expanded(child: Divider(color: AppColors.divider)),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _SocialIcon(icon: Icons.wechat, label: '微信'),
                SizedBox(width: AppSpacing.xl),
                _SocialIcon(icon: Icons.apple, label: 'Apple'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.suffix,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Widget? suffix;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.image),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Icon(icon, size: 20, color: AppColors.pineGreen),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: AppTypography.sans(size: 15),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTypography.sans(size: 15, color: AppColors.textTertiary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
          ?suffix,
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider),
          ),
          child: Icon(icon, color: AppColors.inkGreen),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
