import 'package:betticos/features/betticos/presentation/base/screens/base_screen.dart';
import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/responsiveness/large_update_screen.dart';
// import 'package:betticos/features/responsiveness/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../../../features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import '../../../features/betticos/presentation/profile/screens/profile_screen.dart';
import '../../../features/betticos/presentation/report/screens/report_screen.dart';
import '../../../features/betticos/presentation/timeline/screens/timeline_post_screen.dart';
import '../../../features/p2p_betting/presentation/livescore/screens/livescore_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_history_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';

Route<dynamic> onHomeGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ProfileScreen.route:
      return _getPageRoute(ProfileScreen(), settings);
    case TimelinePostScreen.route:
      return _getPageRoute(const TimelinePostScreen(), settings);
    case MembersScreen.route:
      return _getPageRoute(MembersScreen(), settings);
    case OddstersScreen.route:
      return _getPageRoute(OddstersScreen(), settings);
    case OddsboxScreen.route:
      return _getPageRoute(OddsboxScreen(), settings);
    case ReportScreen.route:
      return _getPageRoute(const ReportScreen(), settings);
    case SettingsScreen.route:
      return _getPageRoute(SettingsScreen(), settings);
    case LiveScoreScreen.route:
      return _getPageRoute(LiveScoreScreen(), settings);
    case P2PBettingHistoryScreen.route:
      return _getPageRoute(const P2PBettingHistoryScreen(), settings);
    case P2PBettingScreen.route:
      return _getPageRoute(const P2PBettingScreen(), settings);
    case P2PBettingCongratScreen.route:
      return _getPageRoute(const P2PBettingCongratScreen(), settings);
    case TimelineScreen.route:
      return _getPageRoute(TimelineScreen(), settings);
    case LargeUdpateScreen.route:
      return _getPageRoute(const LargeUdpateScreen(), settings);
    case ReferralScreen.route:
      return _getPageRoute(ReferralScreen(), settings);
    case BaseScreen.route:
      return _getPageRoute(const BaseScreen(), settings);
    default:
      return _getPageRoute(TimelineScreen(), settings);
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
