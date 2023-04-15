import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  RxString activeitem = AppRoutes.home.obs;
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
      case AppRoutes.home:
        return _customIcon(Ionicons.home_sharp, itemName);
      case '/profile':
        return _customIcon(Ionicons.person_circle_sharp, itemName);
      case '/livescore':
        return _customIcon(Ionicons.football_sharp, itemName);
      case '/oddboxes':
        return _customIcon(Ionicons.gift_sharp, itemName);
      case '/members':
        return _customIcon(Ionicons.people_circle_sharp, itemName);
      case '/oddsters':
        return _customIcon(Ionicons.trending_up_sharp, itemName);
      case '/p2p_betting':
        return _customIcon(Ionicons.baseball_sharp, itemName);
      case '/referral':
        return _customIcon(Ionicons.share_social_sharp, itemName);
      case '/settings':
        return _customIcon(Ionicons.settings_sharp, itemName);
      case '/okx':
        return _customIcon(Ionicons.swap_horizontal_sharp, itemName);
      case AppRoutes.explore:
        return _customIcon(Ionicons.search_sharp, itemName);
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
