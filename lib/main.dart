import 'package:flutter/material.dart';

import 'app.dart';
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
      home: const AppShell(),
    );
  }
}
