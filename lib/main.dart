import 'package:flutter/material.dart';

import 'screens/onboarding_screen.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const LijiTeaApp());
}

/// 李记·TEA — 东方茶生活美学应用.
class LijiTeaApp extends StatelessWidget {
  const LijiTeaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '李记·TEA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const OnboardingScreen(),
      // On wide (desktop / web) viewports, frame the mobile UI in a centred
      // phone-width column. On real phones this is a no-op.
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            const phoneWidth = 420.0;
            if (constraints.maxWidth <= phoneWidth + 24) return child!;
            return ColoredBox(
              color: AppColors.ricePaperGray,
              child: Center(
                child: SizedBox(
                  width: phoneWidth,
                  height: constraints.maxHeight,
                  child: child,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
