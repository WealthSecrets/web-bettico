import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void popUntil(String routeName) {
    return navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  void goBack() => navigatorKey.currentState?.pop();
}
