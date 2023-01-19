import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/icon_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/crypto_converter_input.dart';

class ConvertCryptoScreen extends StatefulWidget {
  const ConvertCryptoScreen({Key? key}) : super(key: key);

  @override
  State<ConvertCryptoScreen> createState() => _ConvertCryptoScreenState();
}

class _ConvertCryptoScreenState extends State<ConvertCryptoScreen> {
  late final TextEditingController fromController;
  late final TextEditingController toController;

  final OkxController controller = Get.find<OkxController>();
  List<Currency> options = <Currency>[];

  @override
  void initState() {
    fromController = TextEditingController();
    toController = TextEditingController(text: '0.00000000');
    WidgetUtils.onWidgetDidBuild(() {
      controller.fetchAssetCurrencies(context);
      controller.fetchConvertCurrencies(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (!controller.isFilterred.value) {
          controller.filterCurrencies();
        }
        return AppLoadingBox(
          loading: controller.isFetchingAssetCurrencies.value ||
              controller.isFetchingConvertCurrencies.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30)
                .add(const EdgeInsets.only(top: 40)),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const AppBackButton(),
                      const SizedBox(width: 24),
                      Text(
                        'Swap Crypto Currencies',
                        style: TextStyle(
                          color: context.colors.textDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'From',
                    style: TextStyle(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const AppSpacing(v: 5),
                Obx(
                  () => CryptoConverterInput(
                    controller: fromController,
                    selectedCurrency: controller.fromCurrency.value,
                    onAmountChanged: (double amount) {},
                    onCurrencyChanged: (Currency currency) {
                      controller.fromCurrency.value = currency;
                    },
                    options: controller.options,
                  ),
                ),
                const AppSpacing(v: 16),
                IconCard(
                  imagePath: AssetImages.upDown,
                  backgroundColor: context.colors.primary,
                  color: context.colors.textDark,
                  onTap: () => controller.swapCurrencies(),
                ),
                const AppSpacing(v: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'To',
                    style: TextStyle(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const AppSpacing(v: 5),
                Obx(
                  () => CryptoConverterInput(
                    disableAmountInput: true,
                    controller: toController,
                    selectedCurrency: controller.toCurrency.value,
                    onAmountChanged: (double amount) {},
                    onCurrencyChanged: (Currency currency) {
                      controller.toCurrency.value = currency;
                    },
                    options: controller.options,
                  ),
                ),
                const Spacer(),
                AppButton(
                  padding: EdgeInsets.zero,
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.primary,
                  onPressed: () {},
                  child: const Text(
                    'PREVIEW EXCHANGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const AppSpacing(v: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
