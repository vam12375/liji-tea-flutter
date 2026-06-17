import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/status_view.dart';

/// 网络异常 — generic network error state.
class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('网络异常', style: AppTypography.h3)),
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: StatusView(
              icon: Icons.wifi_off_outlined,
              title: '网络开小差了',
              subtitle: '请检查网络连接后重试',
              actionLabel: '重新加载',
              onAction: () => Navigator.of(context).maybePop(),
            ),
          ),
        ),
      ),
    );
  }
}
