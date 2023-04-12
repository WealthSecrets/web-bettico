import 'package:betticos/features/betticos/domain/usecases/market/fetch_listings.dart';
import 'package:betticos/features/betticos/domain/usecases/market/get_listing.dart';
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
