import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/presentation/login/getx/login_controller.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:get/get.dart';

class SocialButtonsRow extends StatelessWidget {
  SocialButtonsRow({super.key, this.mainAxisAlignment, this.size});

  final MainAxisAlignment? mainAxisAlignment;
  final double? size;

  final RegisterController rController = Get.find<RegisterController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Image.asset(AssetImages.facebook, height: size ?? 40, width: size ?? 40),
        ),
        const SizedBox(width: 15),
        TextButton(
          onPressed: () => rController.registerWithGoogleAuth(context),
          child: Image.asset(AssetImages.google, height: size ?? 40, width: size ?? 40),
        ),
        TextButton(
          onPressed: () {
            if (Ethereum.isSupported) {
              lController.initiateWalletConnect(
                (String wallet) => controller.loginWallet(context, wallet),
              );
            } else {
              lController.connectWC(
                (String wallet) => controller.loginWallet(context, wallet),
              );
            }
          },
          child: Image.asset(
            AssetImages.walletConnect,
            height: size != null ? size! + 25 : 65,
            width: size != null ? size! + 25 : 65,
          ),
        ),
      ],
    );
  }
}
