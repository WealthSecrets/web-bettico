import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:betticos/features/betticos/domain/usecases/market/fetch_listings.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class MarketRateController extends GetxController {
  MarketRateController({
    required this.fetchListings,
  });

  final FetchListings fetchListings;

  // observable variables
  RxBool isFetchingListings = false.obs;
  RxList<Listing> listings = <Listing>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllListings();
  }

  void getAllListings() async {
    isFetchingListings(true);

    final Either<Failure, List<Listing>> failureOrListings =
        await fetchListings(NoParams());

    failureOrListings.fold<void>(
      (Failure failure) {
        isFetchingListings(false);
      },
      (List<Listing> value) {
        isFetchingListings(false);
        listings(value);
      },
    );
  }

  Future<List<Listing>> getListings() async {
    isFetchingListings(true);

    final Either<Failure, List<Listing>> failureOrListings =
        await fetchListings(NoParams());

    return failureOrListings.fold<List<Listing>>(
      (Failure failure) {
        isFetchingListings(false);
        return <Listing>[];
      },
      (List<Listing> value) {
        isFetchingListings(false);
        return value;
      },
    );
  }
}
