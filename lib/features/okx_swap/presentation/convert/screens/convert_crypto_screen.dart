import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/icon_card.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/no_trading_api_key.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../okx_options/widgets/no_trading_account.dart';
import '../widgets/crypto_converter_input.dart';
import '../widgets/preview_modal.dart';

class ConvertCryptoScreen extends StatefulWidget {
  const ConvertCryptoScreen({Key? key}) : super(key: key);

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
            onPressed: () =>
                navigationController.navigateTo(AppRoutes.conversionHistory),
            icon: Image.asset(
              AssetImages.tansactionHistory,
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (!controller.isFilterred.value) {
            controller.filterCurrencies(context);
          }

          final User user = Get.find<BaseScreenController>().user.value;

          final BalanceResponse? fromBalance = controller
              .getCurrencyBalance(controller.fromCurrency.value.currency);

          return AppLoadingBox(
            loading: controller.isFetchingAssetCurrencies.value ||
                controller.isFetchingConvertCurrencies.value ||
                controller.isFetchingCurrencyPair.value ||
                registerController.isCreatingAccountApiKey.value ||
                registerController.isCreatingOkxAccount.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: user.okx == null
                  ? NoTradignAccount(user: user)
                  : user.apiKey == null
                      ? NoTradingApiKey()
                      : Column(
                          children: <Widget>[
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
                                onChanged:
                                    controller.onFromCurrencyInputChanged,
                                options: controller.options,
                                underLabel: fromBalance?.availableBalance,
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
                                controller.getConversionQuote(context,
                                    () async {
                                  await showMaterialModalBottomSheet<void>(
                                    bounce: true,
                                    animationCurve:
                                        Curves.fastLinearToSlowEaseIn,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                    builder: (BuildContext context) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .5,
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .4,
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
