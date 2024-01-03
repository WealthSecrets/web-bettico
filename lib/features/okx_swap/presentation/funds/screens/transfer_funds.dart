import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferFundsScreen extends StatefulWidget {
  const TransferFundsScreen({super.key});

  @override
  State<TransferFundsScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<TransferFundsScreen> {
  final FundsController controller = Get.find<FundsController>();

  final OkxController okxController = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(_getUserBalances);
  }

  void _getUserBalances({VoidCallback? onSuccess}) {
    final User user = Get.find<BaseScreenController>().user.value;
    if (user.okx != null && user.apiKey != null) {
      okxController.getBalances(context, onSuccess: onSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text(
          'Transfer Funds',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () => navigationController.navigateTo(AppRoutes.transferHistory),
            icon: Image.asset(AssetImages.tansactionHistory, height: 24, width: 24),
          ),
        ],
      ),
      body: Obx(
        () {
          final User user = Get.find<BaseScreenController>().user.value;
          final Currency currency = controller.currency.value;
          controller.setBalance(okxController.getCurrencyBalance(currency.currency));
          return AppLoadingBox(
            loading: controller.isTransferring.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: user.okx == null
                  ? NoTradignAccount(user: user)
                  : user.apiKey == null
                      ? NoTradingApiKey()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            AppAnimatedColumn(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Your Balance',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: context.colors.text,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${controller.balance.value.availableBalance != '' ? double.parse(controller.balance.value.availableBalance).toStringAsFixed(2) : 2.0} ${controller.balance.value.availableBalance != '' ? controller.balance.value.currency.toUpperCase() : ''}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: context.colors.primary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          currency.currency.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: context.colors.textDark,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          currency.chain?.toUpperCase() ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: context.colors.text,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 24),
                                AppTextInput(
                                  labelText: 'TRADING USERNAME',
                                  backgroundColor: context.colors.primary.shade100,
                                  validator: controller.onSubAccountValidator,
                                  onChanged: controller.onSubAccountChanged,
                                ),
                                const SizedBox(height: 16),
                                AppTextInput(
                                  labelText: 'AMOUNT (${currency.currency.toUpperCase()})',
                                  textInputType: TextInputType.number,
                                  onChanged: controller.onAmountInputChanged,
                                  backgroundColor: context.colors.primary.shade100,
                                  validator: controller.onAmountInputValidator,
                                ),
                              ],
                            ),
                            const Spacer(),
                            AppButton(
                              enabled: controller.formIsValid,
                              padding: EdgeInsets.zero,
                              borderRadius: AppBorderRadius.largeAll,
                              backgroundColor: context.colors.primary,
                              onPressed: () => controller.transferFundsToSubAccount(
                                context,
                                onSuccess: () {
                                  _getUserBalances(
                                    onSuccess: () => controller.setBalance(
                                      okxController.getCurrencyBalance(currency.currency),
                                    ),
                                  );
                                },
                              ),
                              child: const Text(
                                'SEND',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
}
