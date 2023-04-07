import 'package:betticos/core/core.dart';

class MenuItem {
  const MenuItem(this.name, this.route);
  final String name;
  final String route;
}

List<MenuItem> sideMenuItemRoutes = <MenuItem>[
  const MenuItem('Timeline', AppRoutes.timeline),
  const MenuItem('Explore', AppRoutes.explore),
  const MenuItem('Profile', AppRoutes.profile),
  const MenuItem('Odds Box', AppRoutes.oddboxes),
  const MenuItem('Members', AppRoutes.members),
  const MenuItem('Oddsters', AppRoutes.oddsters),
  const MenuItem('P2P Betting', AppRoutes.livescore),
  const MenuItem('Refer A Friend', AppRoutes.referral),
  const MenuItem('Settings', AppRoutes.settings),
  const MenuItem('Trade', AppRoutes.okxOptions),
  const MenuItem('Logout', AppRoutes.logout),
];

List<MenuItem> smallScreenMenuItems = <MenuItem>[
  const MenuItem('Timeline', AppRoutes.timeline),
  const MenuItem('Profile', AppRoutes.profile),
  const MenuItem('Odds Box', AppRoutes.oddboxes),
  const MenuItem('Members', AppRoutes.members),
  const MenuItem('Oddsters', AppRoutes.oddsters),
  const MenuItem('P2P Betting', AppRoutes.livescore),
  const MenuItem('Refer A Friend', AppRoutes.referral),
  const MenuItem('Settings', AppRoutes.settings),
  const MenuItem('Logout', AppRoutes.logout),
];

List<MenuItem> notLoggedInMenuItems = <MenuItem>[
  const MenuItem('Explore', AppRoutes.explore),
  const MenuItem('Settings', AppRoutes.settings)
];
