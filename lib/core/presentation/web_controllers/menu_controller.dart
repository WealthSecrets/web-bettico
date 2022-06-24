import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

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

  bool isActive(String itemName) => activeitem.value == itemName;

  bool isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case AppRoutes.timeline:
        return _customIcon(Ionicons.home, itemName);
      case AppRoutes.profile:
        return _customIcon(Ionicons.person_circle, itemName);
      case AppRoutes.livescore:
        return _customIcon(Ionicons.football, itemName);
      case AppRoutes.oddboxes:
        return _customIcon(Ionicons.gift, itemName);
      case AppRoutes.members:
        return _customIcon(Ionicons.people_circle, itemName);
      case AppRoutes.oddsters:
        return _customIcon(Ionicons.trending_up, itemName);
      case AppRoutes.p2pBetting:
        return _customIcon(Ionicons.baseball, itemName);
      case AppRoutes.referral:
        return _customIcon(Ionicons.share_social, itemName);
      case AppRoutes.settings:
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
      color: isHovering(itemName)
          ? const Color(0xFF3d3d3d)
          : const Color(0xFFD3D3D3),
    );
  }
}
