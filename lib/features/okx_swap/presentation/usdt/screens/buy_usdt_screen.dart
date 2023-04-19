import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/presentation/usdt/getx/usdt_sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyUsdtScreen extends GetWidget<UsdtSaleController> {
  const BuyUsdtScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Price: GH\u{20B5} 12.11',
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
              children: const <Widget>[
                _FooterText(
                  title: 'Quantity',
                  subtitle: '41.02 USDT',
                ),
                SizedBox(height: 16),
                _FooterText(
                  title: 'Amount',
                  subtitle: '500 GHS',
                ),
              ],
            ),
            const SizedBox(height: 100),
            AppButton(
              enabled: controller.formIsValid,
              padding: EdgeInsets.zero,
              borderRadius: AppBorderRadius.largeAll,
              backgroundColor: context.colors.primary,
              onPressed: () {},
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
