import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/icon_card.dart';
import 'package:betticos/features/okx_swap/presentation/usdt/getx/sell_usdt_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';

class SellUsdtSummaryScreen extends GetWidget<SellUsdtController> {
  SellUsdtSummaryScreen({super.key});

  final LiveScoreController lController = Get.find<LiveScoreController>();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return AppLoadingBox(
      loading: controller.isInitiatingTransfer.value,
      child: SingleChildScrollView(
        padding: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sell USDT Summary',
              style: context.sub2.copyWith(fontWeight: FontWeight.bold, color: context.colors.textDark),
              textAlign: TextAlign.center,
            ),
            const AppSpacing(v: 24),
            _SummaryItem(
              title: 'USDT',
              subtitle: controller.usdtAmount.value,
              imagePath: AssetImages.darts,
            ),
            const SizedBox(height: 16),
            _SummaryItem(
              title: 'GHS',
              subtitle: '\u{20B5}${controller.quantity.value}',
              imagePath: AssetImages.category,
            ),
            const SizedBox(height: 16),
            _SummaryItem(
              title: 'Destination',
              subtitle: controller.sellMethod.value.name.toUpperCase(),
              imagePath: AssetImages.ageRange,
            ),
            const SizedBox(height: 16),
            _SummaryItem(
              title: controller.sellMethod.value == SellMethod.bank ? 'Account Number' : 'Phone Number',
              subtitle: controller.accountNumber.value,
              imagePath: AssetImages.location,
            ),
            const SizedBox(height: 16),
            _SummaryItem(
              title: controller.sellMethod.value == SellMethod.bank ? 'Bank' : 'Network Provider',
              subtitle: controller.selectedBank.value.name,
              imagePath: AssetImages.gender,
            ),
            const SizedBox(height: 160),
            AppButton(
              enabled: controller.formIsValid && !controller.isResolvingAccount.value,
              padding: EdgeInsets.zero,
              borderRadius: AppBorderRadius.largeAll,
              backgroundColor: context.colors.primary,
              onPressed: () => _handleSellUsdt(context),
              child: const Text(
                'SELL',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  void _handleSellUsdt(BuildContext context) async {
    final TransactionResponse? response =
        await lController.sendUSDT(context, double.parse(controller.usdtAmount.value));
    if (response != null && context.mounted) {
      print('Has entered the if zone');
      controller.initTransfer(context);
    } else {
      await AppSnacks.show(context, message: 'Sorry we couldn\'t process your payment.');
    }
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.title, required this.subtitle, required this.imagePath});
  final String title;
  final String subtitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconCard(imagePath: imagePath, padding: const EdgeInsets.all(5), radius: 8, size: 35),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: context.colors.textDark),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: context.colors.text),
            )
          ],
        ),
      ],
    );
  }
}
