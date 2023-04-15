import 'package:betticos/core/core.dart';

import 'package:flutter/material.dart';

class ProfileRouter {
  static Route<dynamic> router(RouteSettings settings) {
    return FadeInRoute<void>(
      builder: (BuildContext context) {
        return _widgetBuilder(settings, context);
      },
      settings: settings,
    );
  }

  static Widget _widgetBuilder(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case ProfileRoutes.following:
        return const Scaffold(
          body: Center(child: Text('followings')),
        );
      case ProfileRoutes.followers:
        return const Scaffold(
          body: Center(child: Text('followers')),
        );
      case ProfileRoutes.posts:
        return const Scaffold(
          body: Center(child: Text('Users post')),
        );
      default:
        return Scaffold(
          body: Center(child: Text('Username: ${settings.name}')),
        );
    }
  }
}
