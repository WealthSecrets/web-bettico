// ignore_for_file: use_setters_to_change_properties
import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMenuController extends GetxController {
  static AppMenuController instance = Get.find();

  RxString activeitem = AppRoutes.timeline.obs;
  RxString hoverItem = ''.obs;

  void changeActiveItemTo(String itemName) => activeitem.value = itemName;

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
        return _customIcon(AppAssetIcons.home, itemName);
      case AppRoutes.profile:
        return _customIcon(AppAssetIcons.user, itemName);
      case AppRoutes.referral:
        return _customIcon(AppAssetIcons.users, itemName);
      case AppRoutes.settings:
        return _customIcon(AppAssetIcons.settings, itemName);
      case AppRoutes.explore:
        return _customIcon(AppAssetIcons.search, itemName);
      case AppRoutes.moreScreen:
        return _customIcon(AppAssetIcons.menuSolid, itemName);
      case AppRoutes.games:
        return _customIcon(AppAssetIcons.rocket, itemName);
      case AppRoutes.reels:
        return _customIcon(AppAssetIcons.play, itemName);
      case AppRoutes.messages:
        return _customIcon(AppAssetIcons.chat, itemName);
      default:
        return _customIcon(AppAssetIcons.logout, itemName);
    }
  }

  Widget _customIcon(String icon, String itemName) {
    Color iconColor = const Color(0xFFD3D3D3);

    if (itemName == AppRoutes.logout) {
      iconColor = const Color(0xFFD20000);
    }

    if ((isActive(itemName) || isHovering(itemName)) && itemName != AppRoutes.logout) {
      iconColor = const Color(0xFF3d3d3d);
    }

    return Image.asset(icon, height: 20, width: 20, color: iconColor);
  }
}
