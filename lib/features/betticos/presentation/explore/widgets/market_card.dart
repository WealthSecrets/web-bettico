import 'dart:math';
import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:flutter/material.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

import '../../../../../core/core.dart';

class MarketCard extends StatelessWidget {
  const MarketCard({
    Key? key,
    required this.listing,
  }) : super(key: key);

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: AppPaddings.mB.add(AppPaddings.sH),
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: AppBorderRadius.smallAll,
        border: Border.all(
          color: context.colors.faintGrey,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(listing.logo, height: 45, width: 45),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  listing.symbol,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textDark,
                  ),
                ),
                Text(
                  listing.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: context.colors.text,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${listing.quote.usd.volumeChange24h.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: context.colors.success,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                LineChart(
                  width: 50, // Width size of chart
                  height: 20, // Height size of chart
                  data: List<LineChartModel>.generate(
                    6,
                    (_) => LineChartModel(amount: Random().nextDouble() * 10),
                  ),

                  linePaint: Paint()
                    ..strokeWidth = 2.5
                    ..style = PaintingStyle.stroke
                    ..color =
                        context.colors.success, // Custom paint for the line
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '\$${listing.quote.usd.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textDark,
                  ),
                ),
                Text(
                  '1 ${listing.symbol.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: context.colors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
