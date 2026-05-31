import 'package:flutter/material.dart';

import '../app.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/primary_button.dart';

/// 启动 / 引导页 — the LIJI·TEA splash screen with the brand mark, couplet,
/// ink-wash landscape and an entry call-to-action.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _enter(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AppShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      children: [
                        const SizedBox(height: 56),
                        Image.asset('assets/images/logo_mark.png', width: 60, height: 60),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'LIJI·TEA',
                          style: AppTypography.latin(
                              size: 24, weight: FontWeight.w600, letterSpacing: 4, color: AppColors.inkGreen),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Image.asset('assets/images/splash_couplet.png', width: 104),
                        const SizedBox(height: 36),
                        Image.asset('assets/images/splash_mountains.png',
                            width: double.infinity, fit: BoxFit.fitWidth),
                        const SizedBox(height: AppSpacing.lg),
                        const _Dots(count: 3, active: 0),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg),
                  child: PrimaryButton(
                      label: '开启茶之旅程', expand: true, onPressed: () => _enter(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == active ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == active ? AppColors.inkGreen : AppColors.divider,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
