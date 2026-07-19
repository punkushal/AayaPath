import 'package:aayapath/core/routes/app_routes.dart';
import 'package:aayapath/core/storage/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 800), () {
        _resolveStartRoute();
      });
    });
  }

  Future<void> _resolveStartRoute() async {
    final completed = await AppPreferences().hasCompletedOnboarding();
    if (!mounted) return;
    context.goNamed(completed ? AppRouteName.home : AppRouteName.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Splash page")));
  }
}
