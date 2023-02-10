import 'package:betticos/features/betticos/presentation/private_sales/getx/sales_controller.dart';
import 'package:get/get.dart';

class SalesBindings {
  static void dependencies() {
    Get.lazyPut(
      () => SalesController(),
    );
  }
}
