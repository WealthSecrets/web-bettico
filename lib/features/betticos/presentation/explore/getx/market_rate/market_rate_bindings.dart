import 'package:get/get.dart';

import 'market_rate_controller.dart';

class ExploreBindings {
  static void dependencies() {
    Get.put<MarketRateController>(
      MarketRateController(),
      permanent: true,
    );
  }
}
