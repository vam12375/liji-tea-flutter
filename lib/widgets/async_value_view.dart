import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'status_view.dart';

class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.future,
    required this.builder,
    this.empty,
    this.isEmpty,
    this.loadingLabel = '正在加载',
  });

  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;
  final Widget? empty;
  final bool Function(T data)? isEmpty;
  final String loadingLabel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: AppColors.inkGreen),
                const SizedBox(height: AppSpacing.md),
                Text(loadingLabel, style: AppTypography.caption),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: StatusView(
                icon: Icons.wifi_off_outlined,
                title: '加载失败',
                subtitle: '请稍后重试',
              ),
            ),
          );
        }
        final data = snapshot.requireData;
        if (isEmpty?.call(data) ?? false) {
          return empty ??
              Center(
                child: Text('暂无内容', style: AppTypography.body),
              );
        }
        return builder(context, data);
      },
    );
  }
}
