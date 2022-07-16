import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/presentation/auth_base_screen.dart';
import '../../../features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
import '../utils/route_animation.dart';

class AppRoutes {
  static Route<dynamic> router(RouteSettings settings) {
    return FadeInRoute<void>(builder: (BuildContext context) {
      return _widgetBuilder(settings, context);
    });
  }

  static Widget _widgetBuilder(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case AuthBaseScreen.route:
        return const AuthBaseScreen();
      // case HomeScaffoldBaseScreen.route:
      //   return const HomeScaffoldBaseScreen();
    }
    return const SplashScreen();
  }
}
