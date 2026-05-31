import 'package:flutter/material.dart';

import '../repositories/mock_auth_repository.dart';
import '../state/app_state.dart';
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
  static const _authRepository = MockAuthRepository();

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();
  bool _agreed = false;
  bool _sending = false;
  bool _submitting = false;
  int _countdown = 0; // 验证码倒计时（秒）

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (_sending || _countdown > 0) return;
    setState(() => _sending = true);
    try {
      await _authRepository.sendCode(_phone.text);
      _toast('验证码已发送');
      // 启动60秒倒计时
      setState(() => _countdown = 60);
      _startCountdown();
    } on AuthException catch (error) {
      _toast(error.message);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (_countdown > 0) {
          _countdown--;
          _startCountdown();
        }
      });
    });
  }

  Future<void> _submit() async {
    if (!_agreed) {
      _toast('请先阅读并同意用户协议与隐私政策');
      return;
    }
    if (_submitting) return;
    setState(() => _submitting = true);
    try {
      await _authRepository.signInWithCode(_phone.text, _code.text);
      AppStateScope.of(context).signIn(_phone.text);
      if (mounted) Navigator.of(context).pop();
    } on AuthException catch (error) {
      _toast(error.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: AppTypography.sans(size: 14, color: AppColors.riceWhite)),
          backgroundColor: AppColors.inkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _showAgreement(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.riceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.divider)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text('用户协议与隐私政策', style: AppTypography.h3),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  Text('用户协议', style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '欢迎使用李记·TEA。在使用本应用前，请仔细阅读本用户协议。\n\n'
                    '1. 服务说明\n'
                    '李记·TEA 致力于为用户提供优质的茶叶产品和茶文化体验服务。\n\n'
                    '2. 账户注册\n'
                    '用户需提供真实、准确的手机号码进行注册。您有责任维护账户安全。\n\n'
                    '3. 用户行为规范\n'
                    '用户在使用本应用时，应遵守相关法律法规，不得从事违法违规活动。\n\n'
                    '4. 知识产权\n'
                    '本应用的所有内容，包括但不限于文字、图片、商标等，均受知识产权法保护。\n\n'
                    '5. 免责声明\n'
                    '本应用对因不可抗力或第三方原因导致的服务中断不承担责任。',
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('隐私政策', style: AppTypography.h3),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '我们重视您的隐私保护。本隐私政策说明我们如何收集、使用和保护您的个人信息。\n\n'
                    '1. 信息收集\n'
                    '我们会收集您的手机号码、收货地址、订单信息等必要信息。\n\n'
                    '2. 信息使用\n'
                    '您的信息仅用于提供服务、改善用户体验和履行法律义务。\n\n'
                    '3. 信息保护\n'
                    '我们采用行业标准的安全措施保护您的个人信息。\n\n'
                    '4. 信息共享\n'
                    '未经您同意，我们不会向第三方共享您的个人信息，法律要求除外。\n\n'
                    '5. 您的权利\n'
                    '您有权访问、更正或删除您的个人信息。',
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                onPressed: (_sending || _countdown > 0) ? null : _sendCode,
                child: Text(
                  _countdown > 0 ? '${_countdown}s' : '获取验证码',
                  style: AppTypography.sans(
                    size: 13,
                    color: (_sending || _countdown > 0) ? AppColors.textTertiary : AppColors.inkGreen,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: _submitting ? '登录中...' : '登录', expand: true, onPressed: _submit),
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
                  child: GestureDetector(
                    onTap: () => _showAgreement(context),
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
