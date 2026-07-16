import 'package:aayapath/core/responsive/responsive_config.dart';
import 'package:aayapath/core/routes/app_router.dart';
import 'package:aayapath/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveConfig.init(context);
    return MaterialApp.router(
      title: 'AayaPath',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: .system,
      routerConfig: goRouter,
    );
  }
}
