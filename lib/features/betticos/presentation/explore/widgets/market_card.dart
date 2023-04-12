import 'dart:math';
import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/data/models/listing/listing_model.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/market_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MarketCard extends StatefulWidget {
  const MarketCard({
    Key? key,
    required this.listing,
  }) : super(key: key);

  final Listing listing;

  @override
  State<MarketCard> createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  @override
  Widget build(BuildContext context) {
    final double size = isSmallScreen ? 30 : 40;
    final double percentChange1h = widget.listing.quote.usd.percentChange1h;
    final Color color =
        percentChange1h < 0 ? context.colors.error : context.colors.success;
    return GestureDetector(
      onTap: () async {
        await showMaterialModalBottomSheet<bool?>(
          bounce: true,
          useRootNavigator: false,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          )),
          builder: (BuildContext modalContext) {
            return MarketBottomSheet(listing: widget.listing);
          },
          context: context,
        );
      },
      child: Container(
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
            Image.network(
              'https://s2.coinmarketcap.com/static/img/coins/64x64/${widget.listing.id}.png',
              height: size,
              width: size,
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.listing.symbol,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textDark,
                    ),
                  ),
                  Text(
                    widget.listing.name,
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
                    '${percentChange1h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LineChart(
                    width: 80, // Width size of chart
                    height: 20, // Height size of chart
                    data: List<LineChartModel>.generate(
                      6,
                      (_) => LineChartModel(amount: Random().nextDouble() * 10),
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
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '\$${widget.listing.quote.usd.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textDark,
                    ),
                  ),
                  Text(
                    '1 ${widget.listing.symbol.toUpperCase()}',
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
      ),
    );
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);
}
