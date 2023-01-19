import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/okx_swap/presentation/address/addresses_screen.dart';
import 'package:betticos/features/okx_swap/presentation/convert/screens/convert_crypto_screen.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/screens/okx_options_screens.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/new_livescore_screen.dart';
import 'package:betticos/features/responsiveness/not_found_screen.dart';
import 'package:flutter/material.dart';
import '../../../features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import '../../../features/betticos/presentation/profile/screens/profile_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.profile:
      return _getPageRoute(const ProfileScreen(), settings);
    case AppRoutes.members:
      return _getPageRoute(const MembersScreen(), settings);
    case AppRoutes.oddsters:
      return _getPageRoute(const OddstersScreen(), settings);
    case AppRoutes.oddboxes:
      return _getPageRoute(const OddsboxScreen(), settings);
    case AppRoutes.settings:
      return _getPageRoute(const SettingsScreen(), settings);
    case AppRoutes.livescore:
      return _getPageRoute(const NewLiveScore(), settings);
    case AppRoutes.timeline:
      return _getPageRoute(const TimelineScreen(), settings);
    case AppRoutes.referral:
      return _getPageRoute(const ReferralScreen(), settings);
    case AppRoutes.convertCrypto:
      return _getPageRoute(const ConvertCryptoScreen(), settings);
    case AppRoutes.okxOptions:
      return _getPageRoute(const OkxOptionsScreen(), settings);
    case AppRoutes.walletAddresses:
      return _getPageRoute(const AddressesScreen(), settings);
    default:
      return _getPageRoute(const NotFoundScreen(), settings);
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
