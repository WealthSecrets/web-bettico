import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BuySellCryptoScreen extends StatelessWidget {
  const BuySellCryptoScreen({super.key});

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
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Ionicons.close_sharp, size: 24, color: Colors.black),
                ),
                const SizedBox(width: 16),
                Text(
                  'Buy / Sell Crypto',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.colors.textDark),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CryptoCard(
                  title: 'Xviral Token',
                  subtitle: 'Buy Xviral token for private sale.',
                  imagePath: AssetImages.crypto,
                  onPressed: () => navigationController.navigateTo(AppRoutes.privateSales),
                ),
                CryptoCard(
                  title: 'USDT',
                  subtitle: 'Buy or sell USDT',
                  imagePath: AssetImages.tether,
                  onPressed: () => navigationController.navigateTo(AppRoutes.buyUsdt),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
