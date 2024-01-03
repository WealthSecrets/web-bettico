import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/controllers/controllers.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PrivateSale extends StatefulWidget {
  const PrivateSale({super.key});

  @override
  State<PrivateSale> createState() => _PrivateSaleState();
}

class _PrivateSaleState extends State<PrivateSale> {
  final SalesController controller = Get.find<SalesController>();
  final P2PBetController p2pBetController = Get.find<P2PBetController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
  final WalletController wController = Get.find<WalletController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      bController.fetchSetup();
      controller.fetchUserStats(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double xRate = bController.setup.value.xviralRate;
    final String depositAddress = bController.setup.value.xviralDepositAddress;
    return Scaffold(
      body: Obx(
        () {
          final bool hasAmount = controller.convertedAmount.value > 0;
          final String walletAddress = lController.walletAddress.value;
          final double? totalAmount = controller.stats.value?.totalAmount;
          return AppLoadingBox(
            loading: bController.isGettingSetup.value || wController.isMakingPayment.value,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: 16.0, left: 16.0),
              child: Column(
                children: <Widget>[
                  AppAnimatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Ionicons.close_sharp, size: 24, color: Colors.black),
                          ),
                          Text(
                            'Private Sales',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.colors.textDark),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(
                            child:
                                Image.asset(AssetImages.transactionHisotry, color: Colors.black, height: 24, width: 24),
                            onTap: () {
                              navigationController.navigateTo(
                                AppRoutes.transactions,
                                arguments: const TransactionHistoryScreenRouteArgument(isSale: true),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your Total Purchase',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: context.colors.text),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        totalAmount != null ? r'$' + totalAmount.toStringAsFixed(2) : r'$0.00',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: context.colors.primary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      const Notice(
                        message:
                            'Please make sure you only purchase private sale from betticos.io to prevent loss of funds.',
                      ),
                      const SizedBox(height: 32),
                      StepProgressIndicator(
                        totalSteps: 500000,
                        currentStep: 35000,
                        size: 8,
                        padding: 0,
                        selectedColor: context.colors.primary,
                        unselectedColor: context.colors.lightGrey,
                        roundedEdges: const Radius.circular(10),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '35000 USD',
                            style:
                                TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.textDark),
                          ),
                          Text(
                            '500000 USD',
                            style:
                                TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.textDark),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      AppTextInput(
                        labelText: 'AMOUNT (USDT)',
                        textInputType: TextInputType.number,
                        onChanged: (String value) {
                          final double? amount = double.tryParse(value);
                          if (amount != null) {
                            controller.onAmountInputChanged(amount);
                            controller.convertAmount(xRate);
                          } else {
                            controller.resetValues();
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(' '),
                        ],
                        backgroundColor: context.colors.primary.shade50,
                        validator: controller.validateAmount,
                      ),
                      const AppSpacing(v: 4),
                      Obx(
                        () => Text(
                          controller.convertedAmount.value == 0.0
                              ? 'No USD to convert'
                              : 'USD coverted to Xviral: ${controller.convertedAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: hasAmount ? context.colors.success : context.colors.text,
                            fontWeight: hasAmount ? FontWeight.bold : FontWeight.normal,
                            fontStyle: hasAmount ? FontStyle.normal : FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppButton(
                    enabled: walletAddress.isNotEmpty ? controller.amount.value > 0 : true,
                    padding: EdgeInsets.zero,
                    borderRadius: AppBorderRadius.largeAll,
                    backgroundColor: walletAddress.isNotEmpty ? context.colors.primary : context.colors.success,
                    onPressed: () => _handleSubmit(walletAddress, depositAddress),
                    child: Text(
                      walletAddress.isNotEmpty ? 'PURCHASE' : 'CONNECT WALLET',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleSubmit(String walletAddress, String depositAddress) async {
    if (walletAddress.isEmpty) {
      wController.walletInit();
    } else {
      final TransactionResponse? response = await wController.sendUsdt(
        context,
        controller.amount.value,
        depositAddress,
      );
      if (response != null && context.mounted) {
        p2pBetController.createBetTransaction(
          context,
          convertedAmount: controller.convertedAmount.value,
          amount: controller.amount.value,
          description: 'Xviral Private Sale',
          type: 'deposit',
          wallet: lController.walletAddress.value,
          txthash: response.hash,
          convertedToken: 'xvl',
          time: response.timestamp,
          callback: () => navigationController.navigateTo(AppRoutes.saleSuccess),
        );
      }
    }
  }
}
