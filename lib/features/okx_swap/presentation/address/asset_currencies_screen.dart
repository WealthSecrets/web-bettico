import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/core/presentation/widgets/search_field.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/presentation/funds/getx/funds_controller.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/no_trading_api_key.dart';
import 'package:betticos/features/okx_swap/presentation/withdrawal/getx/withdrawal_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../okx_options/widgets/no_trading_account.dart';

class AssetCurrenciesScreenRouteArgument {
  const AssetCurrenciesScreenRouteArgument(
      {this.isWithdrawal = false, this.isTransfer = false});

  final bool? isWithdrawal;
  final bool? isTransfer;
}

class AssetCurrenciesScreen extends StatefulWidget {
  const AssetCurrenciesScreen({Key? key}) : super(key: key);

  @override
  State<AssetCurrenciesScreen> createState() => _AssetCurrenciesScreenState();
}

class _AssetCurrenciesScreenState extends State<AssetCurrenciesScreen> {
  final OkxController controller = Get.find<OkxController>();
  final RegisterController registerController = Get.find<RegisterController>();
  final WithdrawalController wController = Get.find<WithdrawalController>();
  final FundsController fController = Get.find<FundsController>();

  List<Currency> currencies = <Currency>[];

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      controller.fetchAssetCurrencies(context);
      controller.fetchConvertCurrencies(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AssetCurrenciesScreenRouteArgument? args = ModalRoute.of(context)!
        .settings
        .arguments as AssetCurrenciesScreenRouteArgument?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text(
          'Select Crypto',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: args?.isTransfer == null && args?.isWithdrawal == null
            ? <Widget>[
                IconButton(
                  onPressed: () =>
                      navigationController.navigateTo(AppRoutes.depositHistory),
                  icon: Image.asset(
                    AssetImages.tansactionHistory,
                    height: 24,
                    width: 24,
                  ),
                ),
              ]
            : null,
      ),
      body: Obx(
        () {
          if (!controller.isFilterred.value) {
            controller.filterCurrencies(context);
          }

          final User user = Get.find<BaseScreenController>().user.value;

          final bool isKeywordEmpty = controller.keyword.value.isEmpty;

          if (!isKeywordEmpty) {
            currencies = controller.searchCurrencies;
          } else {
            currencies = controller.options;
          }

          return AppLoadingBox(
            loading: controller.isFetchingAssetCurrencies.value ||
                controller.isFetchingConvertCurrencies.value ||
                controller.isCreatingDepositAddress.value ||
                registerController.isCreatingOkxAccount.value ||
                registerController.isCreatingAccountApiKey.value,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: AppPaddings.bodyH,
                  child: SearchField(
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        controller.searchCurrencyOptions(value);
                      } else {
                        controller.resetSearch();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: user.okx == null
                      ? NoTradignAccount(user: user)
                      : user.apiKey == null
                          ? NoTradingApiKey()
                          : currencies.isNotEmpty
                              ? ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Currency currency = currencies[index];
                                    return ListTile(
                                      onTap: () => _handleOnTap(currency, args),
                                      leading: currency.logoLink != null
                                          ? SizedBox(
                                              width: 40,
                                              child: Image.network(
                                                currency.logoLink!,
                                                height: 40,
                                                width: 40,
                                              ),
                                            )
                                          : null,
                                      title: Text(
                                        currency.currency,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: context.colors.textDark,
                                        ),
                                      ),
                                      subtitle: Text(
                                        currency.name ?? '',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: context.colors.text,
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(
                                    color: context.colors.faintGrey,
                                  ),
                                  itemCount: currencies.length,
                                )
                              : AppEmptyScreen(
                                  title: 'Nothing Found',
                                  message: isKeywordEmpty
                                      ? 'No currencies were loaded. Please retry.'
                                      : 'Your search didn\'t return any results.',
                                  btnText: isKeywordEmpty ? 'Retry' : null,
                                  onBottonPressed: isKeywordEmpty
                                      ? () {
                                          controller
                                              .fetchAssetCurrencies(context);
                                          controller
                                              .fetchConvertCurrencies(context);
                                        }
                                      : null,
                                ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleOnTap(
      Currency currency, AssetCurrenciesScreenRouteArgument? args) {
    WidgetUtils.showChainModal(
      context: context,
      currencies: controller.getTokens(currency.currency),
      controller: controller,
      onTap: (Currency item) {
        Navigator.of(context).pop();
        if (args?.isWithdrawal == true) {
          wController.setCurrency(item);
          navigationController.navigateTo(AppRoutes.withdrawal);
        } else if (args?.isTransfer == true) {
          fController.setCurrency(item);
          navigationController.navigateTo(AppRoutes.transferFunds);
        } else {
          controller.createOkxDepositAddress(
            context,
            item.currency,
            item.chain!,
          );
        }
      },
    );
  }
}
