import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AppMenuController extends GetxController {
  static AppMenuController instance = Get.find();

  RxString activeitem = AppRoutes.timeline.obs;
  RxString hoverItem = ''.obs;

  void changeActiveItemTo(String itemName) {
    activeitem.value = itemName;
  }

  void onHover(String itemName) {
    if (!isActive(itemName)) {
      hoverItem.value = itemName;
    }
  }

  void resetActiveItem() {
    activeitem.value = '';
  }

  bool isActive(String itemName) => activeitem.value == itemName;

  bool isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case AppRoutes.timeline:
        return _customIcon(Ionicons.home_sharp, itemName);
      case AppRoutes.profile:
        return _customIcon(Ionicons.person_circle_sharp, itemName);
      case AppRoutes.livescore:
        return _customIcon(Ionicons.football_sharp, itemName);
      case AppRoutes.oddboxes:
        return _customIcon(Ionicons.gift_sharp, itemName);
      case AppRoutes.members:
        return _customIcon(Ionicons.people_circle_sharp, itemName);
      case AppRoutes.oddsters:
        return _customIcon(Ionicons.trending_up_sharp, itemName);
      case AppRoutes.p2pBetting:
        return _customIcon(Ionicons.baseball_sharp, itemName);
      case AppRoutes.referral:
        return _customIcon(Ionicons.share_social_sharp, itemName);
      case AppRoutes.settings:
        return _customIcon(Ionicons.settings_sharp, itemName);
      case AppRoutes.okxOptions:
        return _customIcon(Ionicons.swap_horizontal_sharp, itemName);
      case AppRoutes.explore:
        return _customIcon(Ionicons.search_sharp, itemName);
      case AppRoutes.moreScreen:
        return _customIcon(Ionicons.apps_sharp, itemName);
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
      color: isHovering(itemName)
          ? const Color(0xFF3d3d3d)
          : const Color(0xFFD3D3D3),
    );
  }
}
