import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/explore_container.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/profile_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/responsiveness/home_base_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator extends StatelessWidget {
  AppNavigator({Key? key, this.initialRoute, this.arguments}) : super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  final String? initialRoute;

  final AppBaseScreenArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: (RouteSettings settings) {
          return FadeInRoute<void>(
            builder: (BuildContext context) {
              return _widgetBuilder(settings, context, arguments);
            },
            settings: settings,
          );
        },
      ),
    );
  }

  static Widget _widgetBuilder(RouteSettings settings, BuildContext context,
      AppBaseScreenArguments? arguments) {
    switch (settings.name) {
      case AppRoutes.home:
        return const TimelineScreen();
      case AppRoutes.explore:
        return ExploreContainer();
      case AppRoutes.post:
        String? postID;
        if (arguments != null && arguments.postId != null) {
          postID = arguments.postId;
        }
        return Scaffold(
          body: Center(child: Text('Post Details with ID: $postID')),
        );
      case AppRoutes.followers:
        return const Scaffold(body: Center(child: Text('Followers')));
      case AppRoutes.following:
        return const Scaffold(body: Center(child: Text('Followings')));
      default:
        return ProfileScreen(username: settings.name);
    }
  }
}
