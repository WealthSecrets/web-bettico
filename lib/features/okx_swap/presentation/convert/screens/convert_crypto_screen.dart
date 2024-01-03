import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConvertCryptoScreen extends StatefulWidget {
  const ConvertCryptoScreen({super.key});

  @override
  State<ConvertCryptoScreen> createState() => _ConvertCryptoScreenState();
}

class _ConvertCryptoScreenState extends State<ConvertCryptoScreen> {
  late final TextEditingController fromController;
  late final TextEditingController toController;

  final OkxController controller = Get.find<OkxController>();
  final RegisterController registerController = Get.find<RegisterController>();
  List<Currency> options = <Currency>[];

  @override
  void initState() {
    fromController = TextEditingController();
    toController = TextEditingController();
    WidgetUtils.onWidgetDidBuild(() {
      controller.fetchAssetCurrencies(context);
      controller.fetchConvertCurrencies(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text(
          'Swap Crypto Currencies',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () => navigationController.navigateTo(AppRoutes.conversionHistory),
            icon: Image.asset(AssetImages.tansactionHistory, height: 24, width: 24),
          ),
        ],
      ),
      body: Obx(
        () {
          if (!controller.isFilterred.value) {
            controller.filterCurrencies(context);
          }

          final User user = Get.find<BaseScreenController>().user.value;

          final Balance? fromBalance = controller.getCurrencyBalance(controller.fromCurrency.value.currency);

          return AppLoadingBox(
            loading: controller.isConvertScreenLoading || registerController.isLoading,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
              child: user.okx == null
                  ? NoTradignAccount(user: user)
                  : user.apiKey == null
                      ? NoTradingApiKey()
                      : Column(
                          children: <Widget>[
                            if (!(controller.isConvertScreenLoading || registerController.isLoading)) ...<Widget>[
                              if (fromBalance != null) ...<Widget>[
                                Text(
                                  'From Balance',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: context.colors.text,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${double.parse(fromBalance.availableBalance).toStringAsFixed(2)} ${fromBalance.currency.toUpperCase()}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: context.colors.primary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              if (fromBalance == null)
                                Text(
                                  'You have insufficient balance in ${controller.fromCurrency.value.currency.toUpperCase()}.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: context.colors.error,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              const SizedBox(height: 24),
                            ],
                            if (controller.isConvertScreenLoading || registerController.isLoading)
                              const Align(child: LoadingLogo(height: 14, width: 14)),
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
                                controller: controller.fromController,
                                selectedCurrency: controller.fromCurrency.value,
                                hintText: controller.fromCurrencyHint.value,
                                onCurrencyChanged: (Currency currency) {
                                  controller.fromCurrency.value = currency;
                                  controller.getCurrencyPair(context);
                                },
                                validator: controller.onFromCurrencyValidator,
                                onChanged: controller.onFromCurrencyInputChanged,
                                options: controller.options,
                              ),
                            ),
                            const AppSpacing(v: 16),
                            IconCard(
                              imagePath: AssetImages.upDown,
                              backgroundColor: context.colors.primary,
                              color: context.colors.textDark,
                              onTap: () => controller.swapCurrencies(context),
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
                                controller: controller.toController,
                                selectedCurrency: controller.toCurrency.value,
                                hintText: controller.toCurrencyHint.value,
                                onChanged: controller.onToCurrencyInputChanged,
                                onCurrencyChanged: (Currency currency) {
                                  controller.toCurrency.value = currency;
                                  controller.getCurrencyPair(context);
                                },
                                validator: controller.onToCurrencyValidator,
                                options: controller.options,
                              ),
                            ),
                            const Spacer(),
                            AppButton(
                              padding: EdgeInsets.zero,
                              borderRadius: AppBorderRadius.largeAll,
                              backgroundColor: context.colors.primary,
                              enabled: controller.quoteAmount.isNotEmpty,
                              onPressed: () async {
                                controller.getConversionQuote(context, () async {
                                  await showMaterialModalBottomSheet<void>(
                                    bounce: true,
                                    animationCurve: Curves.fastLinearToSlowEaseIn,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                    builder: (BuildContext context) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context).size.height * .55,
                                          minHeight: MediaQuery.of(context).size.height * .45,
                                        ),
                                        child: const ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            topLeft: Radius.circular(30),
                                          ),
                                          child: PreviewModal(),
                                        ),
                                      );
                                    },
                                    context: context,
                                  );
                                });
                              },
                              child: controller.isEstimatingConversion.value
                                  ? const LoadingLogo(height: 24, width: 24)
                                  : const Text(
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
      ),
    );
  }
}
