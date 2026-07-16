import 'package:aayapath/core/routes/app_routes.dart';
import 'package:aayapath/features/entry/presentation/pages/on_boarding_page.dart';
import 'package:aayapath/features/entry/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutePath.splashPath,
  routes: [
    // splash page
    GoRoute(
      path: AppRoutePath.splashPath,
      name: AppRouteName.splash,
      builder: (context, state) => SplashPage(),
    ),

    // onboarding page
    GoRoute(
      path: AppRoutePath.onboardingPath,
      name: AppRouteName.onboarding,
      builder: (context, state) => OnBoardingPage(),
    ),
  ],
);
