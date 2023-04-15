import 'package:betticos/core/core.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../address/asset_currencies_screen.dart';
import 'widgets/crypto_card.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          right: 16.0,
          left: 16.0,
        ),
        child: AppAnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Ionicons.close_sharp,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Send Funds',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CryptoCard(
                  title: 'Internal',
                  subtitle: 'Send funds to other users on the platform.',
                  imagePath: AssetImages.internal,
                  onPressed: () => navigationController.navigateTo(
                    '/currencies',
                    arguments: const AssetCurrenciesScreenRouteArgument(
                      isTransfer: true,
                    ),
                  ),
                ),
                CryptoCard(
                  title: 'External',
                  subtitle: 'Withdraw or send funds to any address.',
                  imagePath: AssetImages.external,
                  onPressed: () => navigationController.navigateTo(
                    '/currencies',
                    arguments: const AssetCurrenciesScreenRouteArgument(
                      isWithdrawal: true,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
