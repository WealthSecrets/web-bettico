import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/auth/presentation/forgotPassword/getx/forgot_controller.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';

class ForgotWalletScreen extends GetWidget<RegisterController> {
  ForgotWalletScreen({Key? key}) : super(key: key);
  final ForgotController fController = Get.find<ForgotController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Transform.translate(
            offset: const Offset(10, 0),
            child: const AppBackButton(),
          ),
        ),
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: AppLoadingBox(
            loading: controller.isUpdatingUserRole.value,
            child: Center(
              child: SizedBox(
                width: ResponsiveWidget.isSmallScreen(context)
                    ? double.infinity
                    : 450,
                child: SingleChildScrollView(
                  padding: AppPaddings.bodyH,
                  child: AppAnimatedColumn(
                    direction: Axis.horizontal,
                    duration: const Duration(milliseconds: 1000),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'address_verification'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const AppSpacing(v: 47),
                      if (lController.walletAddress.value == '')
                        AppButton(
                          borderRadius: AppBorderRadius.largeAll,
                          backgroundColor: context.colors.primary,
                          onPressed: () {
                            if (Ethereum.isSupported) {
                              lController.initiateWalletConnect();
                            } else {
                              lController.connectWC();
                            }
                          },
                          child: const Text(
                            'Connect Wallet',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const AppSpacing(v: 49),
                      Container(
                        decoration: BoxDecoration(
                          color: context.colors.primary.shade50,
                          borderRadius: AppBorderRadius.smallAll,
                        ),
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Wallet Address: ' +
                                  lController.walletAddress.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: context.colors.primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const AppSpacing(v: 49),
                      if (lController.walletAddress.value != '')
                        AppButton(
                          borderRadius: AppBorderRadius.largeAll,
                          backgroundColor: context.colors.primary,
                          onPressed: () => fController.nextToRest(context),
                          child: Text(
                            'next'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const AppSpacing(v: 100)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
