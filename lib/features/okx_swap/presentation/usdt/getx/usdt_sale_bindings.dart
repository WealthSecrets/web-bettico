import 'package:get/get.dart';

import 'usdt_sale_controller.dart';

class UsdtSaleBinding {
  static void dependencies() {
    Get.put<UsdtSaleController>(
      UsdtSaleController(),
      permanent: true,
    );
  }
}
