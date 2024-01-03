import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/controllers/controllers.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OkxOptionsScreen extends StatefulWidget {
  const OkxOptionsScreen({super.key});

  @override
  State<OkxOptionsScreen> createState() => _OkxOptionsScreenState();
}

class _OkxOptionsScreenState extends State<OkxOptionsScreen> {
  final RegisterController registerController = Get.find<RegisterController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final WalletController wController = Get.find<WalletController>();
  final OkxController okxController = Get.find<OkxController>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      final User user = Get.find<BaseScreenController>().user.value;
      if (user.okx != null && user.apiKey != null) {
        okxController.getBalances(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(
        () {
          final User user = Get.find<BaseScreenController>().user.value;
          return AppLoadingBox(
            loading: wController.isConnectingWallet.value ||
                registerController.isCreatingAccountApiKey.value ||
                registerController.isCreatingOkxAccount.value,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                right: 16.0,
                left: 16.0,
              ),
              child: user.okx == null
                  ? NoTradignAccount(user: user)
                  : user.apiKey == null
                      ? NoTradingApiKey()
                      : AppAnimatedColumn(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Trade Cryptocurrencies',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: context.colors.textDark,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            OptionCard(
                              imagePath: AssetImages.convert,
                              title: 'Convert / Swap',
                              subtitle: 'Convert or swap any token within seconds.',
                              backgroundColor: const Color(0xFFAA7503).withOpacity(.2),
                              iconColor: const Color(0xFFAA7503),
                              onPressed: () => navigationController.navigateTo(AppRoutes.convertCrypto),
                            ),
                            OptionCard(
                              imagePath: AssetImages.deposit,
                              title: 'Deposit',
                              subtitle: 'Send money into your deposit address',
                              backgroundColor: const Color(0xFF1896A5).withOpacity(.2),
                              iconColor: const Color(0xFF1896A5),
                              onPressed: () => navigationController.navigateTo(AppRoutes.currencies),
                            ),
                            OptionCard(
                              imagePath: AssetImages.withdrawal,
                              title: 'Withdraw',
                              subtitle: 'Withdraw money from your deposit address',
                              backgroundColor: const Color(0xFF1896A5).withOpacity(.2),
                              iconColor: const Color(0xFF1896A5),
                              onPressed: () => navigationController.navigateTo(
                                AppRoutes.currencies,
                                arguments: const AssetCurrenciesScreenRouteArgument(
                                  isWithdrawal: true,
                                ),
                              ),
                            ),
                            OptionCard(
                              imagePath: AssetImages.bitcoinWallet,
                              title: 'Addresses',
                              subtitle: 'View deposit addresses and create new ones',
                              backgroundColor: const Color(0xFF7C8B96).withOpacity(.2),
                              iconColor: const Color(0xFF7C8B96),
                              onPressed: () => navigationController.navigateTo(AppRoutes.walletAddresses),
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
}
