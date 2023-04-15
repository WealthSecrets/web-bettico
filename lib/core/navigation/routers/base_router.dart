import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/base_screens/auth_base_screen.dart';
import 'package:betticos/features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
import 'package:betticos/features/responsiveness/home_base_screen.dart';
import 'package:betticos/features/responsiveness/not_found_screen.dart';

import 'package:flutter/material.dart';

class BaseRouter {
  static Route<dynamic> router(RouteSettings settings) {
    return FadeInRoute<void>(
      builder: (BuildContext context) {
        return _widgetBuilder(settings, context);
      },
      settings: settings,
    );
  }

  static Widget _widgetBuilder(RouteSettings settings, BuildContext context) {
    if (settings.name == BaseRoutes.splash) {
      return const SplashScreen();
    } else if (settings.name!.startsWith(BaseRoutes.initial)) {
      final String subRoute =
          settings.name!.substring(BaseRoutes.initial.length).toLowerCase();

      if (!StringUtils.checkSpecialChar(subRoute)) {
        if (subRoute.isEmpty ||
            subRoute == AppRoutes.home.replaceAll('/', '')) {
          return const AppBaseScreen(initialScreen: AppRoutes.home);
        } else if (subRoute == AppRoutes.explore.replaceAll('/', '')) {
          return const AppBaseScreen(initialScreen: AppRoutes.explore);
        } else if (subRoute == AuthRoutes.login) {
          return AuthBaseScreen(initialRoute: AuthRoutes.login);
        } else if (subRoute == AuthRoutes.registration) {
          return AuthBaseScreen(initialRoute: AuthRoutes.registration);
        } else {
          if (subRoute.contains('/')) {
            final String profRoute =
                subRoute.substring(subRoute.indexOf('/')).toLowerCase();

            if (profRoute == AppRoutes.followers ||
                profRoute == '${AppRoutes.followers}/') {
              return const AppBaseScreen(initialScreen: AppRoutes.followers);
            } else if (profRoute == AppRoutes.following ||
                profRoute == '${AppRoutes.following}/') {
              return const AppBaseScreen(initialScreen: AppRoutes.following);
            } else if (profRoute.startsWith(AppRoutes.post) ||
                profRoute.contains('${AppRoutes.post}/')) {
              final String postID =
                  profRoute.substring('${AppRoutes.post}/'.length);
              return AppBaseScreen(
                initialScreen: AppRoutes.post,
                arguments: AppBaseScreenArguments(postId: postID),
              );
            }
          }

          return AppBaseScreen(initialScreen: settings.name!);
        }
      }

      return const NotFoundScreen();
    }

    return const AppBaseScreen(initialScreen: '/home');
  }
}
