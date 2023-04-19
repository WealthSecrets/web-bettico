import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/presentation/usdt/getx/usdt_sale_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class BuyUsdtScreen extends GetWidget<UsdtSaleController> {
  BuyUsdtScreen({Key? key}) : super(key: key);

  final LiveScoreController lController = Get.find<LiveScoreController>();
  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const AppBackButton(color: Colors.black),
            title: const Text(
              'Purchase USDT',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: AppAnimatedColumn(
              children: <Widget>[
                Text(
                  'Price: GH\u{20B5}${controller.price.value}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: context.colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  labelText: 'FIAT AMOUNT (GH\u{20B5})',
                  textInputType: TextInputType.number,
                  onChanged: controller.onAmountInputChanged,
                  backgroundColor: context.colors.primary.shade100,
                  validator: controller.validateAmount,
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  labelText: 'ADDRESS',
                  backgroundColor: context.colors.primary.shade100,
                  validator: controller.validateAddress,
                  onChanged: controller.onWalletAddressChanged,
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _FooterText(
                      title: 'Quantity',
                      subtitle:
                          '${controller.quantity.value.toStringAsFixed(2)} USDT',
                    ),
                    const SizedBox(height: 16),
                    _FooterText(
                      title: 'Amount',
                      subtitle: '${controller.fiatAmount.value} GHS',
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                AppButton(
                  enabled: controller.formIsValid,
                  padding: EdgeInsets.zero,
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.primary,
                  onPressed: () => FlutterPaystackPlus.openPaystackPopup(
                    publicKey:
                        'pk_test_64a0268c0a078c0afb223cefefb91d2f4e4397d9',
                    email: user.email ?? '',
                    amount: (double.parse(controller.fiatAmount.value) * 100)
                        .toString(),
                    ref: DateTime.now().millisecondsSinceEpoch.toString(),
                    onClosed: () {
                      // show failure modal here
                      controller.reset();
                    },
                    onSuccess: () async {
                      final TransactionResponse? result =
                          await lController.sendUsdt(
                              context,
                              controller.quantity.value,
                              controller.walletAddress.value);
                      if (result != null && result.hash.isNotEmpty) {
                        await showAppModal<void>(
                          barrierDismissible: false,
                          context: context,
                          alignment: Alignment.center,
                          builder: (BuildContext modalContext) {
                            return Center(
                              child: SizedBox(
                                width: 600,
                                height: 500,
                                child: Column(
                                  children: <Widget>[
                                    const Spacer(),
                                    AppDialogueModal(
                                      icon: Icon(
                                        Ionicons.checkmark_circle_sharp,
                                        color: context.colors.success,
                                        size: 60,
                                      ),
                                      description:
                                          'You have successfully accepted purchased ${controller.quantity.value} USDT',
                                      title: Text(
                                        'USDT Purchased',
                                        style: TextStyle(
                                          color: context.colors.success,
                                          fontSize: 20,
                                        ),
                                      ),
                                      buttonText: 'Dismiss',
                                      onDismissed: () async {
                                        controller.reset();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  child: const Text(
                    'PURCHASE',
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
        ),
      ),
    );
  }
}

class _FooterText extends StatelessWidget {
  const _FooterText({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: context.colors.text,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: context.colors.black,
          ),
        )
      ],
    );
  }
}
