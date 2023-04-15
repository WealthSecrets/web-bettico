import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppNavigationController extends GetxController {
  static AppNavigationController instance = Get.find();

  final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'appNavKey');

  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  void goBack() => navigationKey.currentState?.pop();
}
