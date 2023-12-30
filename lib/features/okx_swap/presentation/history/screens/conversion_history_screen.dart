import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CovnersionHistoryScreen extends StatefulWidget {
  const CovnersionHistoryScreen({super.key});

  @override
  State<CovnersionHistoryScreen> createState() => _CovnersionHistoryScreenState();
}

class _CovnersionHistoryScreenState extends State<CovnersionHistoryScreen> {
  final OkxController controller = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      controller.getConversionHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text('Conversion History', style: TextStyle(fontSize: 14, color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        final List<OkxConversion> conversions = controller.conversions;
        return AppLoadingBox(
          loading: controller.isFetchingConversionHistory.value,
          child: conversions.isNotEmpty
              ? ListView.separated(
                  padding: AppPaddings.lH,
                  itemBuilder: (BuildContext context, int index) {
                    final OkxConversion conversion = controller.conversions[index];

                    final Currency? baseCurrency = controller.getCurrencyByCurrency(conversion.baseCurrency);

                    final Currency? quoteCurrency = controller.getCurrencyByCurrency(conversion.quoteCurrency);

                    final int timestamp = int.parse(conversion.timestamp);

                    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

                    final String baseFilledAmount = double.parse(conversion.baseFilledAmount).toStringAsFixed(2);
                    final String filledQuoteAmount = double.parse(conversion.filledQuoteAmount).toStringAsFixed(2);

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _OverlapImages(currencies: <Currency>[baseCurrency!, quoteCurrency!]),
                        const SizedBox(width: 24),
                        _ColumnText(
                          title: '$baseFilledAmount ${conversion.baseCurrency}',
                          titleFontWeight: FontWeight.normal,
                          subtitle: TimeCard(dateTime: date),
                        ),
                        const Spacer(),
                        _ColumnText(
                          title: '$filledQuoteAmount ${conversion.quoteCurrency}',
                          subtitle: Text(
                            conversion.state.name(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: conversion.state.color(context),
                            ),
                          ),
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    );
                  },
                  itemCount: conversions.length,
                  separatorBuilder: (_, __) => Divider(color: context.colors.lightGrey),
                )
              : const AppEmptyScreen(
                  title: 'Nothing Found',
                  message: 'You do not have any conversion history.',
                ),
        );
      }),
    );
  }
}

class _ColumnText extends StatelessWidget {
  const _ColumnText({required this.title, required this.subtitle, this.titleFontWeight, this.crossAxisAlignment});
  final String title;
  final Widget subtitle;
  final FontWeight? titleFontWeight;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style:
              TextStyle(fontSize: 14, fontWeight: titleFontWeight ?? FontWeight.bold, color: context.colors.textDark),
        ),
        const SizedBox(height: 5),
        subtitle
      ],
    );
  }
}

class _OverlapImages extends StatelessWidget {
  const _OverlapImages({required this.currencies});

  final List<Currency> currencies;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        for (int i = 0; i < currencies.length; i++) ...<Widget>[
          if (i == 0)
            SizedBox(width: 40, child: Image.network(currencies[i].logoLink!, height: 40, width: 40))
          else
            Positioned(
              top: i * 8,
              left: i * 8,
              child: SizedBox(width: 40, child: Image.network(currencies[i].logoLink!, height: 40, width: 40)),
            ),
        ],
      ],
    );
  }
}

extension ConversionStateX on ConversionState {
  Color color(BuildContext context) {
    switch (this) {
      case ConversionState.fullyFilled:
        return context.colors.success;
      case ConversionState.rejected:
        return context.colors.error;
    }
  }

  String name() {
    switch (this) {
      case ConversionState.fullyFilled:
        return 'successful';
      case ConversionState.rejected:
        return 'failed';
    }
  }
}
