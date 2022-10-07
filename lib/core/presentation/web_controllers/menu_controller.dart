import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/profile_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/livescore_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import 'package:betticos/features/settings/presentation/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  RxString activeitem = TimelineScreen.route.obs;
  RxString hoverItem = ''.obs;

  void changeActiveItemTo(String itemName) {
    activeitem.value = itemName;
  }

  void onHover(String itemName) {
    if (!isActive(itemName)) {
      hoverItem.value = itemName;
    }
  }

  bool isActive(String itemName) => activeitem.value == itemName;

  bool isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case TimelineScreen.route:
        return _customIcon(Ionicons.home, itemName);
      case ProfileScreen.route:
        return _customIcon(Ionicons.person_circle, itemName);
      case LiveScoreScreen.route:
        return _customIcon(Ionicons.football, itemName);
      case OddsboxScreen.route:
        return _customIcon(Ionicons.gift, itemName);
      case MembersScreen.route:
        return _customIcon(Ionicons.people_circle, itemName);
      case OddstersScreen.route:
        return _customIcon(Ionicons.trending_up, itemName);
      case P2PBettingScreen.route:
        return _customIcon(Ionicons.baseball, itemName);
      case ReferralScreen.route:
        return _customIcon(Ionicons.share_social, itemName);
      case SettingsScreen.route:
        return _customIcon(Ionicons.settings, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(icon, size: 24, color: const Color(0xFF3d3d3d));
    }

    return Icon(
      icon,
      size: 24,
      color: isHovering(itemName) ? const Color(0xFF3d3d3d) : const Color(0xFFD3D3D3),
    );
  }
}
