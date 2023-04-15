import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthNavigationController extends GetxController {
  static AuthNavigationController instance = Get.find();

  final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'authNavKey');

  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  void goBack() => navigationKey.currentState?.pop();
}
