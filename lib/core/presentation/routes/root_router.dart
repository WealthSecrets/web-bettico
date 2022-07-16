import 'package:betticos/features/auth/presentation/auth_base_screen.dart';
import 'package:flutter/material.dart';
import '../../../features/onboarding_splash/presentation/onbaording/screens/onboarding_screen.dart';
import '../../../features/onboarding_splash/presentation/splash/screens/splash_screen.dart';

Route<dynamic> onRootGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingScreen.route:
      return _getPageRoute(const OnboardingScreen(), settings);
    case SplashScreen.route:
      return _getPageRoute(const SplashScreen(), settings);
    case AuthBaseScreen.route:
      return _getPageRoute(const AuthBaseScreen(), settings);
    default:
      return _getPageRoute(const SplashScreen(), settings);
  }
}

PageRoute<Widget> _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder<Widget> {
  _FadeRoute({required this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
  final Widget child;
  final String? routeName;
}
