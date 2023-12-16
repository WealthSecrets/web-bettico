// import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:betticos/features/shares/presentation/getx/shares_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '/core/core.dart';

class CreateShareScreen extends StatefulWidget {
  const CreateShareScreen({super.key});

  @override
  State<CreateShareScreen> createState() => _CreateShareScreenState();
}

class _CreateShareScreenState extends State<CreateShareScreen> {
  SharesController sharesController = Get.find<SharesController>();

  String ethTargetAmount = '';
  String ethSharePrice = '';
  String ethSubscription = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add New Shares'.tr, style: const TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: Obx(() {
        return AppLoadingBox(
          loading: sharesController.walletController.isCreatingSale.value,
          child: Padding(
            padding: AppPaddings.lH,
            child: AppAnimatedColumn(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AppSpacing(v: 20),
                const Notice(
                  message: 'Please all amount should be entered in USD, we\'ll show you the equivalent in ETH.',
                ),
                const AppSpacing(v: 8),
                Text(
                  sharesController.walletController.randomMessage.value,
                  style: context.caption.copyWith(color: Colors.black),
                ),
                const AppSpacing(v: 8),
                Text(
                  sharesController.walletController.valuesChecker.value,
                  style: context.caption.copyWith(color: Colors.black),
                ),
                const AppSpacing(v: 32),
                AppTextInput(
                  labelText: 'Target Amount (USD)'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: (String value) {
                    final double? amount = double.tryParse(value);
                    if (amount != null) {
                      sharesController.walletController.convertAmount(
                        context,
                        'eth',
                        amount,
                        successCallback: (double amount) {
                          sharesController.onTargetAmountChanged('$amount');
                          setState(() => ethTargetAmount = '$amount');
                        },
                      );
                    }
                  },
                ),
                if (ethTargetAmount.isNotEmpty)
                  Text(
                    '$ethTargetAmount ETH',
                    style: TextStyle(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'Share Price (USD)'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: (String value) {
                    final double? amount = double.tryParse(value);
                    if (amount != null) {
                      sharesController.walletController.convertAmount(
                        context,
                        'eth',
                        amount,
                        successCallback: (double amount) {
                          sharesController.onSharePriceChanged('$amount');
                          setState(() => ethSharePrice = '$amount');
                        },
                      );
                    }
                  },
                ),
                if (ethSharePrice.isNotEmpty)
                  Text(
                    '$ethSharePrice ETH',
                    style: TextStyle(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'Subscription Price (USD)'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: (String value) {
                    final double? amount = double.tryParse(value);
                    if (amount != null) {
                      sharesController.walletController.convertAmount(
                        context,
                        'eth',
                        amount,
                        successCallback: (double amount) {
                          sharesController.onSubcriptionPriceChanged('$amount');
                          setState(() => ethSubscription = '$amount');
                        },
                      );
                    }
                  },
                ),
                if (ethSubscription.isNotEmpty)
                  Text(
                    '$ethSubscription ETH',
                    style: TextStyle(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'No. of Contributors'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: sharesController.onMaxContributionsChanged,
                ),
                const AppSpacing(v: 8),
                TextButton(
                  onPressed: () {
                    DatePickerBdaya.showDateTimePicker(
                      context,
                      onChanged: sharesController.onStartTimeChanged,
                      onConfirm: sharesController.onStartTimeChanged,
                      currentTime: DateTime.now(),
                    );
                  },
                  child: const Text(
                    'Pick Start Date & Time',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'Duration'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String input) => null,
                  onChanged: (String value) {},
                ),
                const AppSpacing(v: 49),
                AppButton(
                  borderRadius: AppBorderRadius.largeAll,
                  onPressed: _handleCreateShares,
                  enabled: sharesController.formIsValid,
                  child: Text(
                    'Create Shares'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const AppSpacing(v: 50),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _handleCreateShares() {
    sharesController.createSale(
      callback: () {
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
                      description: 'You have successfully created a new sale.',
                      title: Text(
                        'Sale Created',
                        style: TextStyle(
                          color: context.colors.success,
                          fontSize: 20,
                        ),
                      ),
                      buttonText: 'Dismiss',
                      onDismissed: () async {
                        Navigator.of(context).pop();
                        await Navigator.of(context).pushReplacementNamed(AppRoutes.salesScreen);
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
