import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/convert/okx_quote.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/presentation/convert/widgets/listtile_column.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class PreviewModal extends StatefulWidget {
  const PreviewModal({super.key});

  @override
  State<PreviewModal> createState() => _PreviewModalState();
}

class _PreviewModalState extends State<PreviewModal> {
  final OkxController controller = Get.find<OkxController>();
  late final Timer _timer;
  late final Timer _countDown;
  int quoteExpiry = 0;
  int start = 0;

  @override
  void initState() {
    super.initState();
    final int? milliseconds = int.tryParse(controller.currentQuote.value.expiryTime);
    if (milliseconds != null) {
      start = milliseconds ~/ 1000;
      setState(() {
        quoteExpiry = milliseconds ~/ 1000;
      });
    }

    _timer = Timer.periodic(Duration(milliseconds: milliseconds ?? 10000), (_) {
      controller.getConversionQuote(context);
    });

    _countDown = Timer.periodic(const Duration(seconds: 1), (_) {
      if (start == 0) {
        setState(() {
          start = milliseconds! ~/ 1000;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _countDown.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final OkxQuote quote = controller.currentQuote.value;
      final Currency? baseCurrency = controller.getCurrencyByCurrency(quote.baseCurrency);
      final Currency? quoteCurrency = controller.getCurrencyByCurrency(quote.quoteCurrency);
      return AppLoadingBox(
        loading: controller.isEstimatingConversion.value || controller.isConvertingCrypto.value,
        child: Padding(
          padding: AppPaddings.bodyH.add(AppPaddings.lV),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    'Confirm Order',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Ionicons.close_sharp, size: 20, color: context.colors.error),
                  )
                ],
              ),
              if (controller.isSwap.value == '0')
                ListTileColumn(
                  title: controller.topTitle.value,
                  amount: quote.quoteConvertedAmount,
                  quoteCurrency: quote.quoteCurrency,
                  currency: quoteCurrency,
                )
              else
                ListTileColumn(
                  title: controller.bottomTitle.value,
                  amount: quote.baseConvertedAmount,
                  quoteCurrency: quote.baseCurrency,
                  currency: baseCurrency,
                ),
              Divider(color: context.colors.lightGrey),
              if (controller.isSwap.value == '-1')
                ListTileColumn(
                  title: controller.topTitle.value,
                  amount: quote.quoteConvertedAmount,
                  quoteCurrency: quote.quoteCurrency,
                  currency: quoteCurrency,
                )
              else
                ListTileColumn(
                  title: controller.bottomTitle.value,
                  amount: quote.baseConvertedAmount,
                  quoteCurrency: quote.baseCurrency,
                  currency: baseCurrency,
                ),
              const SizedBox(height: 16),
              const Text(
                'CONVERSION PRICE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${quote.rate} ${quote.baseCurrency}',
                style: TextStyle(
                  fontSize: 14,
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Please note that this quote refreshes every $quoteExpiry seconds.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: context.colors.error,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: AppButton(
                      padding: EdgeInsets.zero,
                      borderRadius: AppBorderRadius.largeAll,
                      backgroundColor: context.colors.text,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      padding: EdgeInsets.zero,
                      borderRadius: AppBorderRadius.largeAll,
                      backgroundColor: context.colors.primary,
                      onPressed: () => controller.convertCrypto(context),
                      child: Text(
                        'CONVERT ($start)',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    });
  }
}
