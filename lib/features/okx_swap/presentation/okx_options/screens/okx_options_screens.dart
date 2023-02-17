import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/presentation/address/asset_currencies_screen.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/no_trading_account.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/no_trading_api_key.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/option_card.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OkxOptionsScreen extends StatefulWidget {
  const OkxOptionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OkxOptionsScreen> createState() => _OkxOptionsScreenState();
}

class _OkxOptionsScreenState extends State<OkxOptionsScreen> {
  final RegisterController registerController = Get.find<RegisterController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
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
            loading: lController.isConnectingWallet.value ||
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
                              subtitle:
                                  'Convert or swap any token within seconds.',
                              backgroundColor:
                                  const Color(0xFFAA7503).withOpacity(.2),
                              iconColor: const Color(0xFFAA7503),
                              onPressed: () => navigationController
                                  .navigateTo(AppRoutes.convertCrypto),
                            ),
                            OptionCard(
                              imagePath: AssetImages.deposit,
                              title: 'Deposit',
                              subtitle: 'Send money into your deposit address',
                              backgroundColor:
                                  const Color(0xFF1896A5).withOpacity(.2),
                              iconColor: const Color(0xFF1896A5),
                              onPressed: () => navigationController
                                  .navigateTo(AppRoutes.currencies),
                            ),
                            OptionCard(
                              imagePath: AssetImages.withdrawal,
                              title: 'Withdraw',
                              subtitle:
                                  'Withdraw money from your deposit address',
                              backgroundColor:
                                  const Color(0xFF1896A5).withOpacity(.2),
                              iconColor: const Color(0xFF1896A5),
                              onPressed: () => navigationController.navigateTo(
                                AppRoutes.currencies,
                                arguments:
                                    const AssetCurrenciesScreenRouteArgument(
                                  isWithdrawal: true,
                                ),
                              ),
                            ),
                            OptionCard(
                              imagePath: AssetImages.bitcoinWallet,
                              title: 'Addresses',
                              subtitle:
                                  'View deposit addresses and create new ones',
                              backgroundColor:
                                  const Color(0xFF7C8B96).withOpacity(.2),
                              iconColor: const Color(0xFF7C8B96),
                              onPressed: () => navigationController
                                  .navigateTo(AppRoutes.walletAddresses),
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
