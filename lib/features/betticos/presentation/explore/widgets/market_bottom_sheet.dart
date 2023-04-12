import 'dart:math';

import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

class MarketBottomSheet extends StatelessWidget {
  const MarketBottomSheet({
    Key? key,
    required this.listing,
  }) : super(key: key);

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final double percentChange1h = listing.quote.usd.percentChange1h;
    final Color color =
        percentChange1h < 0 ? context.colors.error : context.colors.success;
    return Stack(
      children: <Widget>[
        Container(
          padding: AppPaddings.mH.add(AppPaddings.bodyT),
          width: 1.sw,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(width: 10),
              Expanded(
                child: AppAnimatedColumn(
                  duration: const Duration(milliseconds: 700),
                  delay: const Duration(milliseconds: 200),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      listing.name,
                      style: TextStyle(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const AppSpacing(v: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      amount: Random().nextDouble() * 10),
                                ),

                                linePaint: Paint()
                                  ..strokeWidth = 2.5
                                  ..style = PaintingStyle.stroke
                                  ..color = color, // Custom paint for the line
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                listing.quote.usd.volume24h.toStringAsFixed(2),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                listing.quote.usd.marketCap.toStringAsFixed(2),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                listing.quote.usd.fullyDilutedMarketCap!
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
    );
  }
}
