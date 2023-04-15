import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/explore_container.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/profile_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
// import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_post_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';

import 'package:flutter/material.dart';

class AppRouter {
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
      case AppRoutes.home:
        return const TimelineScreen();
      case AppRoutes.explore:
        return ExploreContainer();
      case AppRoutes.post:
        return PostDetailsScreen(post: Post.empty());
      case AppRoutes.followers:
        return const Scaffold(body: Center(child: Text('Followers')));
      case AppRoutes.following:
        return const Scaffold(body: Center(child: Text('Followings')));
      default:
        return ProfileScreen(username: settings.name);
    }
  }
}
