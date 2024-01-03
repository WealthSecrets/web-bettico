import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'sales_controller.dart';

class SalesBindings {
  static void dependencies() {
    Get.lazyPut(
      () => SalesController(getUserStats: GetUserStats(p2prepository: Get.find())),
    );
  }
}
