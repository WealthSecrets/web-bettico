import 'package:betticos/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  RxString currentRoute = AppRoutes.timeline.obs;
  RxList<String> routes = <String>[].obs;

  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    currentRoute.value = routeName;
    routes.add(routeName);
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void popUntil(String routeName) {
    return navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  void goBack() {
    routes.removeLast();
    if (routes.isNotEmpty) {
      currentRoute.value = routes.last;
    } else {
      currentRoute.value = AppRoutes.timeline;
    }

    navigatorKey.currentState?.pop();
  }
}
