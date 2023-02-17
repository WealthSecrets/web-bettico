import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/okx_swap/presentation/withdrawal/getx/withdrawal_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final WithdrawalController controller = Get.find<WithdrawalController>();

  final OkxController okxController = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      final User user = Get.find<BaseScreenController>().user.value;
      if (user.okx != null && user.apiKey != null) {
        okxController.getBalances(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(color: Colors.black),
        title: const Text(
          'Withdrawal',
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
                navigationController.navigateTo(AppRoutes.withdrawalHistory),
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
          final Currency currency = controller.currency.value;
          final BalanceResponse? balance =
              okxController.getCurrencyBalance(currency.currency);
          return AppLoadingBox(
            loading: controller.isMakingWithdrawal.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
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
                        '${balance != null ? double.parse(balance.availableBalance).toStringAsFixed(2) : 0.0} ${balance?.currency.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: context.colors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ),
                          if (currency.maxFee != null &&
                              currency.minFee != null)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Transaction Fee',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: context.colors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${currency.minFee} - ${currency.maxFee} ${currency.currency}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: context.colors.text,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AppTextInput(
                        labelText: 'RECIPIENT ADDRESS',
                        backgroundColor: context.colors.primary.shade100,
                        validator: controller.onRecipientAddressValidator,
                        onChanged: controller.onRecipientAddressChanged,
                      ),
                      const SizedBox(height: 16),
                      AppTextInput(
                        labelText:
                            'AMOUNT (${currency.currency.toUpperCase()})',
                        textInputType: TextInputType.number,
                        onChanged: controller.onAmountInputChanged,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(' '),
                        ],
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
                    onPressed: () => controller.makeWithdrawal(context),
                    child: const Text(
                      'WITHDRAW',
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
