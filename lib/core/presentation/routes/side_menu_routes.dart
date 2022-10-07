import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/profile_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import 'package:betticos/features/settings/presentation/settings/screens/settings_screen.dart';

class MenuItem {
  const MenuItem(this.name, this.route);
  final String name;
  final String route;
}

List<MenuItem> sideMenuItemRoutes = <MenuItem>[
  const MenuItem('Timeline', TimelineScreen.route),
  const MenuItem('Profile', ProfileScreen.route),
  const MenuItem('Odds Box', OddsboxScreen.route),
  const MenuItem('Members', MembersScreen.route),
  const MenuItem('Oddsters', OddstersScreen.route),
  const MenuItem('P2P Betting', P2PBettingScreen.route),
  const MenuItem('Refer A Friend', ReferralScreen.route),
  const MenuItem('Settings', SettingsScreen.route),
  const MenuItem('Logout', LoginScreen.route),
];
