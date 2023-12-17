import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:betticos/features/shares/presentation/getx/contribute_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class WithdrawSharesModal extends StatefulWidget {
  const WithdrawSharesModal(
      {super.key, required this.saleId, required this.shares, required this.sharePrice, required this.sharePriceUSD});

  final String saleId;
  final int shares;
  final double sharePrice;
  final double sharePriceUSD;

  @override
  State<WithdrawSharesModal> createState() => _WithdrawSharesModalState();
}

class _WithdrawSharesModalState extends State<WithdrawSharesModal> {
  final ContributeController contributeController = Get.find<ContributeController>();
  final WalletController walletController = Get.find<WalletController>();
  int remainingShares = 0;

  @override
  void initState() {
    remainingShares = widget.shares;
    walletController.getWithdrawalFee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final String withdrawalFee = walletController.withdrawalFee.value;
        final double feesPercentage = double.parse(withdrawalFee.trim());
        return AppLoadingBox(
          loading: walletController.isWithdrawing.value,
          child: Padding(
            padding: AppPaddings.lH,
            child: AppAnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  'Please enter the number of shares you want to withdraw below.',
                  style: context.caption.copyWith(fontWeight: FontWeight.normal, color: context.colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Remaining', style: context.caption.copyWith(color: context.colors.black)),
                    Text('$remainingShares', style: context.caption.copyWith(color: context.colors.primary)),
                  ],
                ),
                const AppSpacing(v: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Withdrawal Fees', style: context.caption.copyWith(color: context.colors.black)),
                    Text('%$feesPercentage', style: context.caption.copyWith(color: context.colors.primary)),
                  ],
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'share value'.tr.toUpperCase(),
                  textInputType: TextInputType.phone,
                  backgroundColor: context.colors.primary.shade100,
                  validator: (String? value) {
                    return contributeController.validateWithdrawShares(value, widget.shares);
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(' '),
                  ],
                  onChanged: (String value) {
                    final int? vShares = int.tryParse(value);
                    if (vShares != null) {
                      setState(() => remainingShares = widget.shares - vShares);
                      contributeController.onWithdrawSharesChanged(value);
                    } else {
                      contributeController.onWithdrawSharesChanged('0');
                    }
                  },
                ),
                const SizedBox(height: 16),
                AppButton(
                  enabled: contributeController.withdrawFormIsValid(widget.shares),
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
    contributeController.withdraw(
      widget.saleId,
      callback: () {
        walletController.getSale(widget.saleId);
        walletController.getContributionsBySale(widget.saleId);
        walletController.getContributionByUserAndSale(widget.saleId);
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
