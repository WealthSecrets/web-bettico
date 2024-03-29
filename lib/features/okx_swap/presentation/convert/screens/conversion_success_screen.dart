import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversionSuccessScreen extends StatelessWidget {
  ConversionSuccessScreen({super.key});

  final OkxController controller = Get.find<OkxController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final ConversionResponse response = controller.currentConversion.value;
          final Currency? baseCurrency = controller.getCurrencyByCurrency(response.baseCurrency);
          final Currency? quoteCurrency = controller.getCurrencyByCurrency(response.quoteCurrency);
          return Padding(
            padding: AppPaddings.bodyH,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AssetImages.checkedColor, height: 65, width: 65),
                const SizedBox(height: 16),
                const Text(
                  'Conversion Successful',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 32),
                ListTileColumn(
                  title: controller.isSwap.value == '0' ? 'From' : 'To',
                  amount: response.filledQuoteAmount,
                  quoteCurrency: response.quoteCurrency,
                  currency: quoteCurrency,
                ),
                Divider(color: context.colors.lightGrey),
                ListTileColumn(
                  title: controller.isSwap.value != '0' ? 'From' : 'To',
                  amount: response.baseFilledAmount,
                  quoteCurrency: response.baseCurrency,
                  currency: baseCurrency,
                ),
                const SizedBox(height: 50),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                        padding: EdgeInsets.zero,
                        borderRadius: AppBorderRadius.largeAll,
                        backgroundColor: context.colors.text,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'BACK',
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
                        onPressed: () => navigationController.navigateTo(AppRoutes.conversionHistory),
                        child: const Text(
                          'VIEW HISTORY',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
