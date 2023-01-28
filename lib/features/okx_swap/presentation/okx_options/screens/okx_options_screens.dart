import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/option_card.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';

class OkxOptionsScreen extends StatefulWidget {
  const OkxOptionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OkxOptionsScreen> createState() => _OkxOptionsScreenState();
}

class _OkxOptionsScreenState extends State<OkxOptionsScreen> {
  final LiveScoreController lController = Get.find<LiveScoreController>();
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
        child: Obx(
          () => AppLoadingBox(
            loading: lController.isConnectingWallet.value,
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
                    Obx(
                      () => Image.asset(
                        AssetImages.wallet,
                        height: 24,
                        color: lController.walletAddress.isEmpty
                            ? Colors.grey
                            : context.colors.success,
                      ),
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
                  onPressed: () async {
                    if (lController.walletAddress.isEmpty) {
                      if (Ethereum.isSupported) {
                        lController.initiateWalletConnect();
                      } else {
                        await lController.connectWC();
                      }
                    } else {
                      await navigationController
                          .navigateTo(AppRoutes.convertCrypto);
                    }
                  },
                ),
                OptionCard(
                  imagePath: AssetImages.deposit,
                  title: 'Deposit',
                  subtitle: 'Send money into your deposit address',
                  backgroundColor: const Color(0xFF1896A5).withOpacity(.2),
                  iconColor: const Color(0xFF1896A5),
                  onPressed: () async {
                    await navigationController.navigateTo(AppRoutes.currencies);
                  },
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
                  onPressed: () async {
                    if (lController.walletAddress.isEmpty) {
                      if (Ethereum.isSupported) {
                        lController.initiateWalletConnect();
                      } else {
                        await lController.connectWC();
                      }
                    } else {
                      await navigationController
                          .navigateTo(AppRoutes.walletAddresses);
                    }
                  },
                ),
                const Spacer(),
                Obx(
                  () => AppButton(
                    padding: EdgeInsets.zero,
                    borderRadius: AppBorderRadius.largeAll,
                    backgroundColor: lController.walletAddress.value.isEmpty
                        ? context.colors.success
                        : context.colors.error,
                    onPressed: () async {
                      if (lController.walletAddress.isNotEmpty) {
                        WidgetUtils.showDeleteConnectionDialogue(
                          context,
                          onPressed: () async {
                            lController.disconnect();
                            Get.back<void>();
                          },
                        );
                      } else {
                        if (Ethereum.isSupported) {
                          lController.initiateWalletConnect();
                        } else {
                          await lController.connectWC();
                        }
                      }
                    },
                    child: Text(
                      lController.walletAddress.isEmpty
                          ? 'CONNECT WALLET'
                          : 'DISCONNECT WALLET',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
