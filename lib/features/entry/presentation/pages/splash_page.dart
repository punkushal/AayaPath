import 'package:aayapath/core/routes/app_routes.dart';
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
        if (mounted) {
          context.goNamed(AppRouteName.onboarding);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Splash page")));
  }
}
