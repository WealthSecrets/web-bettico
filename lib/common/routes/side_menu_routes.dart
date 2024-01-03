import 'package:betticos/common/common.dart';

class SideMenuItem {
  const SideMenuItem(this.name, this.route);
  final String name;
  final String route;
}

List<SideMenuItem> sideMenuItemRoutes = <SideMenuItem>[
  const SideMenuItem('Timeline', AppRoutes.timeline),
  const SideMenuItem('Explore', AppRoutes.explore),
  const SideMenuItem('Profile', AppRoutes.profile),
  const SideMenuItem('Odds Box', AppRoutes.oddboxes),
  const SideMenuItem('Sales', AppRoutes.salesScreen),
  const SideMenuItem('Members', AppRoutes.members),
  const SideMenuItem('Oddsters', AppRoutes.oddsters),
  const SideMenuItem('P2P Betting', AppRoutes.livescore),
  const SideMenuItem('Refer A Friend', AppRoutes.referral),
  const SideMenuItem('Settings', AppRoutes.settings),
  const SideMenuItem('Trade', AppRoutes.okxOptions),
  const SideMenuItem('More', AppRoutes.moreScreen),
  const SideMenuItem('Logout', AppRoutes.logout),
];

List<SideMenuItem> smallScreenMenuItems = <SideMenuItem>[
  const SideMenuItem('Timeline', AppRoutes.timeline),
  const SideMenuItem('Profile', AppRoutes.profile),
  const SideMenuItem('Odds Box', AppRoutes.oddboxes),
  const SideMenuItem('Sales', AppRoutes.salesScreen),
  const SideMenuItem('Members', AppRoutes.members),
  const SideMenuItem('Oddsters', AppRoutes.oddsters),
  const SideMenuItem('P2P Betting', AppRoutes.livescore),
  const SideMenuItem('Refer A Friend', AppRoutes.referral),
  const SideMenuItem('Settings', AppRoutes.settings),
  const SideMenuItem('Logout', AppRoutes.logout),
];

List<SideMenuItem> notLoggedInMenuItems = <SideMenuItem>[
  const SideMenuItem('Explore', AppRoutes.explore),
  const SideMenuItem('Settings', AppRoutes.settings)
];
