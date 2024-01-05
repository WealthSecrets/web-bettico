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
  const SideMenuItem('Refer A Friend', AppRoutes.referral),
  const SideMenuItem('Settings', AppRoutes.settings),
  const SideMenuItem('More', AppRoutes.moreScreen),
  const SideMenuItem('Logout', AppRoutes.logout),
];

List<SideMenuItem> smallScreenMenuItems = <SideMenuItem>[
  const SideMenuItem('Timeline', AppRoutes.timeline),
  const SideMenuItem('Profile', AppRoutes.profile),
  const SideMenuItem('Refer A Friend', AppRoutes.referral),
  const SideMenuItem('Settings', AppRoutes.settings),
  const SideMenuItem('Logout', AppRoutes.logout),
];

List<SideMenuItem> notLoggedInMenuItems = <SideMenuItem>[
  const SideMenuItem('Explore', AppRoutes.explore),
  const SideMenuItem('Settings', AppRoutes.settings)
];
