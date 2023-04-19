import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class BuyUsdtScreen extends StatelessWidget {
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
              onChanged: (String value) {},
              backgroundColor: context.colors.primary.shade100,
              validator: (String value) => null,
            ),
            const SizedBox(height: 16),
            AppTextInput(
              labelText: 'ADDRESS',
              backgroundColor: context.colors.primary.shade100,
              validator: (String value) => null,
              onChanged: (String value) {},
            ),
            AppTextInput(
              labelText: 'EMAIL ADDRESS',
              backgroundColor: context.colors.primary.shade100,
              lableStyle: TextStyle(
                color: context.colors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
              errorStyle: TextStyle(
                color: context.colors.error,
                fontSize: 12,
              ),
              validator: (String value) => null,
              onChanged: (String value) {},
            ),
            const SizedBox(height: 100),
            AppButton(
              enabled: true,
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
