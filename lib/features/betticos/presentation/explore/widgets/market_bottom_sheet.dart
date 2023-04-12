import 'dart:async';
import 'dart:math';

import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/market_rate/market_rate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

class MarketBottomSheet extends StatefulWidget {
  const MarketBottomSheet({
    Key? key,
    required this.listing,
  }) : super(key: key);

  final Listing listing;

  @override
  State<MarketBottomSheet> createState() => _MarketBottomSheetState();
}

class _MarketBottomSheetState extends State<MarketBottomSheet> {
  final MarketRateController controller = Get.find<MarketRateController>();
  Timer? _timer;

  final StreamController<Listing?> _listingStreamController =
      StreamController<Listing?>.broadcast();

  @override
  void initState() {
    initialFetch(widget.listing.symbol);
    startBroadcast(widget.listing.symbol);
    super.initState();
  }

  @override
  void dispose() {
    _listingStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  void startBroadcast(String symbol) async {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      final Listing? listing = await controller.getSingleListing(symbol);
      _listingStreamController.add(listing);
    });
  }

  void initialFetch(String symbol) async {
    final Listing? listing = await controller.getSingleListing(symbol);
    _listingStreamController.add(listing);
  }

  @override
  Widget build(BuildContext context) {
    final double percentChange1h = widget.listing.quote.usd.percentChange1h;
    final Color color =
        percentChange1h < 0 ? context.colors.error : context.colors.success;
    final double space = getSpaceValue(context);
    return StreamBuilder<Listing?>(
      stream: _listingStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<Listing?> snapshot) {
        final Listing? listing = snapshot.data;
        return listing != null
            ? Stack(
                children: <Widget>[
                  Container(
                    padding: AppPaddings.mH.add(AppPaddings.bodyT),
                    width: 1.sw,
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: AppBorderRadius.mediumAll,
                          child: Image.network(
                            'https://s2.coinmarketcap.com/static/img/coins/64x64/${listing.id}.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          listing.name,
                          style: TextStyle(
                            color: context.colors.textDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: space),
                            child: AppAnimatedColumn(
                              duration: const Duration(milliseconds: 700),
                              delay: const Duration(milliseconds: 200),
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'PRICE',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: context.colors.text,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              '\$${listing.quote.usd.price.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: context.colors.text,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ]),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'CHANGE',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            '${percentChange1h.toStringAsFixed(2)}%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: color,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const AppSpacing(v: 30),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'PRICE CHART',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 10,
                                            ),
                                          ),
                                          LineChart(
                                            width: 50,
                                            height: 20,
                                            data: List<LineChartModel>.generate(
                                              6,
                                              (_) => LineChartModel(
                                                  amount:
                                                      Random().nextDouble() *
                                                          10),
                                            ),

                                            linePaint: Paint()
                                              ..strokeWidth = 2.5
                                              ..style = PaintingStyle.stroke
                                              ..color =
                                                  color, // Custom paint for the line
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'VOLUME',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            listing.quote.usd.volume24h
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const AppSpacing(v: 30),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'MARKET CAP',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            listing.quote.usd.marketCap
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'DILUTED MARKET CAP',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            listing.quote.usd
                                                .fullyDilutedMarketCap!
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: context.colors.text,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const AppSpacing(v: 50),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: Icon(
                        Icons.cancel_rounded,
                        color: context.colors.error,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(
                width: 1.sw,
                height: 350,
                child: const Center(child: LoadingLogo()),
              );
      },
    );
  }

  double getSpaceValue(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    final bool isMediumScreen = ResponsiveWidget.isMediumScreen(context);
    final bool isCustomScreen = ResponsiveWidget.isCustomSize(context);

    return isSmallScreen
        ? 12
        : isCustomScreen
            ? 20
            : isMediumScreen
                ? 28
                : 40;
  }
}
