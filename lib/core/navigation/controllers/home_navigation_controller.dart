import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeNavigationController extends GetxController {
  static HomeNavigationController instance = Get.find();

  GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeNaveKey');

  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  void goBack() => navigationKey.currentState?.pop();
}
