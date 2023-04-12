import 'package:betticos/features/betticos/domain/usecases/market/fetch_listings.dart';
import 'package:get/get.dart';

import 'market_rate_controller.dart';

class MarketRateBindings {
  static void dependencies() {
    Get.put<MarketRateController>(
      MarketRateController(
        fetchListings: FetchListings(repository: Get.find()),
      ),
      permanent: true,
    );
  }
}
