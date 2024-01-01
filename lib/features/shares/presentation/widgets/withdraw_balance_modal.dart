import 'package:betticos/core/core.dart';
import 'package:betticos/features/shares/presentation/getx/contribute_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class WithdrawBalanceModal extends StatefulWidget {
  const WithdrawBalanceModal({super.key});

  @override
  State<WithdrawBalanceModal> createState() => _WithdrawBalanceModal();
}

class _WithdrawBalanceModal extends State<WithdrawBalanceModal> {
  final ContributeController contributeController = Get.find<ContributeController>();
  final WalletController walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AppLoadingBox(
          loading: walletController.isBalanceWithdrawal.value,
          child: Padding(
            padding: AppPaddings.lH,
            child: AppAnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  'Please enter the amount in USD, we will provide ETH equivalent.',
                  style: context.caption.copyWith(fontWeight: FontWeight.normal, color: context.colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AppTextInput(
                  labelText: 'Amount (usd)'.tr.toUpperCase(),
                  textInputType: TextInputType.phone,
                  backgroundColor: context.colors.primary.shade100,
                  validator: contributeController.validateWithdrawalAmount,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(' '),
                  ],
                  onChanged: (String value) {
                    double? aV = double.tryParse(value);
                    aV ??= 0;
                    contributeController.onWithdrawalAmountChanged(aV, context);
                  },
                ),
                Text('ETH equivalent: ${contributeController.withdrawalAmountDisplay}'),
                const SizedBox(height: 16),
                AppButton(
                  enabled: contributeController.withdrawalFormIsValid,
                  padding: EdgeInsets.zero,
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.primary,
                  onPressed: _handleWithdrawal,
                  child: Text(
                    'withdraw'.tr.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleWithdrawal() {
    contributeController.withdrawBalance(
      callback: () {
        walletController.getTotalSubscriptionRaisedByCreator();
        Navigator.of(context).pop();
        showAppModal<void>(
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
                      description: 'Withdrawal made successfully.',
                      title: Text(
                        'Success',
                        style: TextStyle(
                          color: context.colors.success,
                          fontSize: 20,
                        ),
                      ),
                      buttonText: 'Dismiss',
                      onDismissed: () async {
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
      },
    );
  }
}
