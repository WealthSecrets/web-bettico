import 'package:betticos/common/common.dart';

class SideMenuItem {
  const SideMenuItem(this.name, this.route);
  final String name;
  final String route;
}

const SideMenuItem timeline = SideMenuItem('Timeline', AppRoutes.timeline);
const SideMenuItem explore = SideMenuItem('Explore', AppRoutes.explore);
const SideMenuItem profile = SideMenuItem('Profile', AppRoutes.profile);
const SideMenuItem referral = SideMenuItem('Referral', AppRoutes.referral);
const SideMenuItem settings = SideMenuItem('Settings', AppRoutes.settings);
const SideMenuItem logout = SideMenuItem('Logout', AppRoutes.logout);
const SideMenuItem games = SideMenuItem('Games', AppRoutes.games);
const SideMenuItem reels = SideMenuItem('Reels', AppRoutes.reels);
const SideMenuItem messages = SideMenuItem('Messages', AppRoutes.messages);
