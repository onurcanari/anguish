import 'package:depression/app/view/landing_page.dart';
import 'package:depression/app/view/onboarding_page.dart';
import 'package:depression/app/view/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static GoRouter get router {
    return GoRouter(
      routes: [
        GoRoute(
          name: 'landing',
          path: '/',
          builder: (context, state) => LandingPage(),
        ),
        GoRoute(
          name: 'onboarding',
          path: '/onboarding',
          builder: (context, state) => OnboardingPage(),
        ),
        GoRoute(
          name: 'loading',
          path: '/loading',
          builder: (context, state) => const SplashPage(),
        ),
      ],
    );
  }
}
