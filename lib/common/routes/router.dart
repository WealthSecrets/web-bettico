import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.onboard:
      return _getPageRoute(const OnboardingScreen(), settings);
    case AppRoutes.profile:
      final ProfileScreenArgument argument = settings.arguments! as ProfileScreenArgument;
      return _getPageRoute(ProfileScreen(user: argument.user, showBackButton: argument.showBackButton), settings);
    case AppRoutes.settings:
      return _getPageRoute(const SettingsScreen(), settings);
    case AppRoutes.timeline:
      return _getPageRoute(const TimelineScreen(), settings);
    case AppRoutes.referral:
      return _getPageRoute(const ReferralScreen(), settings);
    case AppRoutes.success:
      return _getPageRoute(const SucessScreen(), settings);
    case AppRoutes.appwebview:
    case AppRoutes.explore:
      return _getPageRoute(ExploreContainer(), settings);
    case AppRoutes.search:
      return _getPageRoute(SearchContainer(), settings);
    default:
      return _getPageRoute(const NotFoundScreen(), settings);
  }
}

PageRoute<Widget> _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, settings: settings);
}

class _FadeRoute extends PageRouteBuilder<Widget> {
  _FadeRoute({required this.child, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              child,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  FadeTransition(opacity: animation, child: child),
        );
  final Widget child;
  @override
  final RouteSettings settings;
}
