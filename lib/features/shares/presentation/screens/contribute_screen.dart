import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ContributeScreenRouteArgument {
  const ContributeScreenRouteArgument({required this.sale});

  final dynamic sale;
}

class ContributeScreen extends StatefulWidget {
  const ContributeScreen({super.key, required this.sale});

  final dynamic sale;

  @override
  State<ContributeScreen> createState() => _ContributeScreen();
}

class _ContributeScreen extends State<ContributeScreen> {
  SharesController sharesController = Get.find<SharesController>();
  ContributeController contributeController = Get.find<ContributeController>();
  WalletController wController = Get.find<WalletController>();

  String ethContributeAmount = '';

  double subTotal = 0;
  double shareTotal = 0;
  double totalAmount = 0;
  double fees = 0;

  @override
  void initState() {
    super.initState();
    wController.getOwnerFeePercentage();
  }

  @override
  Widget build(BuildContext context) {
    final double sharePrice = int.parse('${widget.sale[7]}') / weiMultiplier;
    final double sharePriceUSD = sharePrice * fakeUSD;

    final double subscriptionPrice = int.parse('${widget.sale[8]}') / weiMultiplier;
    final double subscriptionPriceUSD = subscriptionPrice * fakeUSD;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add New Shares:'.tr, style: const TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: Obx(() {
        final String ownerFeePercentage = wController.ownerFeePercentage.value;
        final double feesPercentage = double.parse(ownerFeePercentage.trim());

        final DateTime startTime = DateTime.fromMillisecondsSinceEpoch(int.parse('${widget.sale[5]}') * 1000);
        final DateTime endTime = DateTime.fromMillisecondsSinceEpoch(int.parse('${widget.sale[6]}') * 1000);

        // fetch contributions for this sale
        // get user's contribution based on this sale.
        final DateTime now = DateTime.now();
        final SalesStatus status = now.isBefore(startTime)
            ? SalesStatus.notstarted
            : now.isAfter(endTime)
                ? SalesStatus.ended
                : SalesStatus.live;

        return AppLoadingBox(
          child: SingleChildScrollView(
            padding: AppPaddings.lH,
            child: AppAnimatedColumn(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const AppSpacing(v: 20),
                const Notice(
                  message:
                      'Please just enter the number of shares and subscriptions you want and we will calculate the total amount for you.',
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
                  labelText: 'shares value'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: contributeController.validateShares,
                  onChanged: (String? value) {
                    int? shareValue = int.tryParse('$value');
                    shareValue ??= 0;
                    contributeController.onSharesChanged('$shareValue');
                    setState(() {
                      shareTotal = sharePriceUSD * shareValue!;
                      final double v = shareTotal + subTotal;
                      fees = (feesPercentage / 100) * v;
                      totalAmount = v + fees;
                      contributeController.onAmountChanged(shareTotal + subTotal + fees, context);
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(' '),
                  ],
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'subscription value'.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: contributeController.validateSubscriptoins,
                  onChanged: (String? value) {
                    int? subValue = int.tryParse('$value');
                    subValue ??= 0;
                    contributeController.onSubscriptionsChanged('$subValue');
                    setState(() {
                      subTotal = subscriptionPriceUSD * subValue!;
                      final double v = shareTotal + subTotal;
                      fees = (feesPercentage / 100) * v;
                      totalAmount = v + fees;
                      contributeController.onAmountChanged(shareTotal + subTotal + fees, context);
                    });
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(' '),
                  ],
                ),
                Text(
                  'Fees: ${fees.toStringAsFixed(2)} USD',
                  style: context.caption.copyWith(color: context.colors.black),
                ),
                const AppSpacing(v: 48),
                if (contributeController.amountDisplay.value.isNotEmpty)
                  contributeController.isLoading.value
                      ? const Align(child: LoadingLogo())
                      : Container(
                          padding: AppPaddings.mA,
                          decoration: BoxDecoration(
                            color: context.colors.primary.shade100,
                            borderRadius: AppBorderRadius.card,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Total Amount',
                                style: context.sub2.copyWith(color: context.colors.primary),
                                textAlign: TextAlign.center,
                              ),
                              const Divider(color: Colors.white, height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${contributeController.amountDisplay.value} ETH',
                                    style: TextStyle(
                                      color: context.colors.textDark,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${totalAmount.toStringAsFixed(2)} USD',
                                    style: TextStyle(
                                      color: context.colors.textDark,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                const AppSpacing(v: 49),
                AppButton(
                  enabled: contributeController.formIsValid,
                  borderRadius: AppBorderRadius.largeAll,
                  onPressed: () {
                    if (status == SalesStatus.live) {
                      _handleContribute();
                    } else {
                      _handlePurchase();
                    }
                  },
                  child: Text(
                    status == SalesStatus.live ? 'purchase'.toUpperCase() : 'Contribute'.toUpperCase(),
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

  void _handleContribute() {
    contributeController.contribute(
      '${widget.sale[0]}',
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
                      description: 'Contribution made successfully.',
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
                        await Navigator.of(context).pushReplacementNamed(
                          AppRoutes.saleDetails,
                          arguments: SaleDetailsScreenRouteArgument(value: widget.sale),
                        );
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

  void _handlePurchase() {
    contributeController.purchase(
      '${widget.sale[0]}',
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
                      description: 'Purchase made successfully.',
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
                        await Navigator.of(context).pushReplacementNamed(
                          AppRoutes.saleDetails,
                          arguments: SaleDetailsScreenRouteArgument(value: widget.sale),
                        );
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
