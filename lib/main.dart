import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigation/app_router.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  final appState = await AppState.create();
  runApp(LijiTeaApp(appState: appState));
}

/// 李记·TEA — 东方茶生活美学应用.
class LijiTeaApp extends StatelessWidget {
  const LijiTeaApp({super.key, required this.appState});

  final AppState appState;
  late final _router = createRouter(appState);

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      state: appState,
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          return MaterialApp.router(
            title: '李记·TEA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: appState.themeMode,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
