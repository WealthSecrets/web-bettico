import 'package:auto_size_text/auto_size_text.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/balance/balance_response.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/currency/currency.dart';

class TokenScreen extends StatefulWidget {
  const TokenScreen({super.key});

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  final OkxController controller = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      controller.fetchAssetCurrencies(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final List<Balance> balances = controller.myBalances;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              final Balance balance = balances[index];
              final Currency? currency = controller.getCurrencyByCurrency(balance.currency);
              return _TokenCard(
                currency: balance.currency,
                imagePath: currency?.logoLink,
                marketValue: balance.marketValue,
                balance: balance.balance,
                eqUsd: balance.usd,
                onPressed: () {},
              );
            },
            itemCount: controller.myBalances.length,
          ),
        );
      },
    );
  }
}

class _TokenCard extends StatelessWidget {
  const _TokenCard({
    required this.currency,
    this.imagePath,
    required this.marketValue,
    required this.balance,
    required this.eqUsd,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final String? imagePath;
  final String currency;
  final String marketValue;
  final String balance;
  final String eqUsd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 62,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.faintGrey),
        ),
        child: Row(
          children: <Widget>[
            if (imagePath != null) ...<Widget>[
              const SizedBox(width: 8),
              Image.network(
                imagePath!,
                height: 40,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    currency,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  AutoSizeText(
                    marketValue,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: context.colors.text,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  double.parse(balance).toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                AutoSizeText(
                  '\$$eqUsd',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: context.colors.text,
                  ),
                  maxLines: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
