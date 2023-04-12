import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/market_rate/market_rate_controller.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/market_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketRateScreen extends GetWidget<MarketRateController> {
  const MarketRateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isFetchingListings.value,
          child: controller.listings.isEmpty &&
                  !controller.isFetchingListings.value
              ? const AppEmptyScreen(
                  message: 'Oops! No market rates are available.')
              : ListView.builder(
                  padding: ResponsiveWidget.isSmallScreen(context)
                      ? const EdgeInsets.symmetric(horizontal: 16)
                      : EdgeInsets.zero,
                  itemCount: controller.listings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Listing listing = controller.listings[index];
                    return MarketCard(listing: listing);
                  },
                ),
        ),
      ),
    );
  }
}
