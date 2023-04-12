import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/market_rate/market_rate_controller.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/market_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketRateScreen extends StatefulWidget {
  const MarketRateScreen({Key? key}) : super(key: key);

  @override
  State<MarketRateScreen> createState() => _MarketRateScreenState();
}

class _MarketRateScreenState extends State<MarketRateScreen> {
  final MarketRateController controller = Get.find<MarketRateController>();

  Timer? _timer;

  final StreamController<List<Listing>> _listingsStreamController =
      StreamController<List<Listing>>.broadcast();

  @override
  void initState() {
    initialFetch();
    startBroadcast();
    super.initState();
  }

  @override
  void dispose() {
    _listingsStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  void startBroadcast() async {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      final List<Listing> listings = await controller.getListings();
      _listingsStreamController.add(listings);
    });
  }

  void initialFetch() async {
    final List<Listing> listings = await controller.getListings();
    _listingsStreamController.add(listings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Listing>>(
        stream: _listingsStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Listing>> snapshot) {
          final List<Listing>? listings = snapshot.data;
          if (listings != null) {
            return listings.isEmpty && !controller.isFetchingListings.value
                ? const AppEmptyScreen(
                    message: 'Oops! No market rates are available.')
                : ListView.builder(
                    padding: ResponsiveWidget.isSmallScreen(context)
                        ? const EdgeInsets.symmetric(horizontal: 16)
                        : EdgeInsets.zero,
                    itemCount: listings.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Listing listing = listings[index];
                      return MarketCard(listing: listing);
                    },
                  );
          }

          return const Center(child: LoadingLogo());
        },
      ),
    );
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);
}
