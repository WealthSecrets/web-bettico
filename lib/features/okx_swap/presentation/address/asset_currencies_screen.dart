import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/core/presentation/widgets/search_field.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetCurrenciesScreen extends StatefulWidget {
  const AssetCurrenciesScreen({Key? key}) : super(key: key);

  @override
  State<AssetCurrenciesScreen> createState() => _AssetCurrenciesScreenState();
}

class _AssetCurrenciesScreenState extends State<AssetCurrenciesScreen> {
  final OkxController controller = Get.find<OkxController>();

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
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                navigationController.navigateTo(AppRoutes.depositHistory),
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

          return AppLoadingBox(
            loading: controller.isFetchingAssetCurrencies.value ||
                controller.isFetchingConvertCurrencies.value ||
                controller.isCreatingDepositAddress.value,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: AppPaddings.bodyH,
                  child: const SearchField(),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: controller.options.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final Currency currency = controller.options[index];
                            return ListTile(
                              onTap: () => WidgetUtils.showChainModal(
                                context,
                                controller.getTokens(currency.currency),
                                controller,
                              ),
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
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            color: context.colors.faintGrey,
                          ),
                          itemCount: controller.options.length,
                        )
                      : AppEmptyScreen(
                          title: 'Nothing Found',
                          message:
                              'Failed to load tokens or no tokens were found.',
                          btnText: 'Retry',
                          onBottonPressed: () {
                            controller.fetchAssetCurrencies(context);
                            controller.fetchConvertCurrencies(context);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
