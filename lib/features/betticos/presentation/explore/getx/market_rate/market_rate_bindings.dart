import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'market_rate_controller.dart';

class MarketRateBindings {
  static void dependencies() {
    Get.put<MarketRateController>(
      MarketRateController(
        fetchListings: FetchListings(repository: Get.find()),
        getListing: GetListing(repository: Get.find()),
      ),
      permanent: true,
    );
  }
}
