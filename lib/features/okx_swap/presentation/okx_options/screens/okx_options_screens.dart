import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/option_card.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';

class OkxOptionsScreen extends StatefulWidget {
  const OkxOptionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OkxOptionsScreen> createState() => _OkxOptionsScreenState();
}

class _OkxOptionsScreenState extends State<OkxOptionsScreen> {
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
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Trade Cryptocurrencies',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.colors.textDark,
                  ),
                ),
                Image.asset(
                  AssetImages.wallet,
                  height: 24,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 24),
            OptionCard(
              imagePath: AssetImages.convert,
              title: 'Convert / Swap',
              subtitle: 'Convert or swap any token within seconds.',
              backgroundColor: const Color(0xFFAA7503).withOpacity(.2),
              iconColor: const Color(0xFFAA7503),
              onPressed: () =>
                  navigationController.navigateTo(AppRoutes.convertCrypto),
            ),
            OptionCard(
              imagePath: AssetImages.deposit,
              title: 'Deposit',
              subtitle: 'Send money into your deposit address',
              backgroundColor: const Color(0xFF1896A5).withOpacity(.2),
              iconColor: const Color(0xFF1896A5),
              onPressed: () {},
            ),
            OptionCard(
              imagePath: AssetImages.withdrawal,
              title: 'Withdraw',
              subtitle: 'Withdraw money from your deposit address',
              backgroundColor: const Color(0xFF1896A5).withOpacity(.2),
              iconColor: const Color(0xFF1896A5),
              onPressed: () {},
            ),
            OptionCard(
              imagePath: AssetImages.bitcoinWallet,
              title: 'Addresses',
              subtitle: 'View deposit addresses and create new ones',
              backgroundColor: const Color(0xFF7C8B96).withOpacity(.2),
              iconColor: const Color(0xFF7C8B96),
              onPressed: () =>
                  navigationController.navigateTo(AppRoutes.walletAddresses),
            ),
            OptionCard(
              imagePath: AssetImages.transactionHisotry,
              title: 'History',
              subtitle: 'View all deposit and withdrawal transactions',
              backgroundColor: const Color(0xFF1896A5).withOpacity(.2),
              iconColor: const Color(0xFF1896A5),
              onPressed: () {},
            ),
            const Spacer(),
            AppButton(
              padding: EdgeInsets.zero,
              borderRadius: AppBorderRadius.largeAll,
              backgroundColor: context.colors.success,
              onPressed: () {},
              child: const Text(
                'CONNECT WALLET',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
