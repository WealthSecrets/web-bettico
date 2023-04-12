import 'dart:math';

import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

import '../../../../../core/core.dart';

class MarketBottomSheet extends StatelessWidget {
  const MarketBottomSheet({
    Key? key,
    required this.listing,
  }) : super(key: key);

  final Listing listing;

  @override
  Widget build(BuildContext context) {
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
                      style: context.sub1.copyWith(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.w700,
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
                                  style: context.overline.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: context.colors.text,
                                  ),
                                ),
                                Text(
                                  '\$${listing.quote.usd.price.toStringAsFixed(2)}',
                                  style: context.body2.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: context.colors.text,
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
                                style: context.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
                                ),
                              ),
                              const AppSpacing(v: 10),
                              Text(
                                '${listing.quote.usd.volumeChange24h.toStringAsFixed(2)}%',
                                style: context.body2.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.success,
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
                                style: context.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
                                ),
                              ),
                              LineChart(
                                width: 50, // Width size of chart
                                height: 20, // Height size of chart
                                data: List<LineChartModel>.generate(
                                  6,
                                  (_) => LineChartModel(
                                      amount: Random().nextDouble() * 10),
                                ),

                                linePaint: Paint()
                                  ..strokeWidth = 2.5
                                  ..style = PaintingStyle.stroke
                                  ..color = context.colors
                                      .success, // Custom paint for the line
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
                                style: context.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
                                ),
                              ),
                              const AppSpacing(v: 10),
                              Text(
                                '%${listing.quote.usd.volume24h.toStringAsFixed(2)}',
                                style: context.body2.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
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
                                style: context.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
                                ),
                              ),
                              Text(
                                listing.quote.usd.marketCap.toStringAsFixed(2),
                                style: context.body2.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
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
                                style: context.overline.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
                                ),
                              ),
                              const AppSpacing(v: 10),
                              Text(
                                listing.quote.usd.fullyDilutedMarketCap!
                                    .toStringAsFixed(2),
                                style: context.body2.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.text,
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
