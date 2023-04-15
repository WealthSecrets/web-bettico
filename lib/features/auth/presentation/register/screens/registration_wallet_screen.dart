import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slider_captcha/slider_capchar.dart';
import '/core/core.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';

class RegistrationWalletScreen extends GetWidget<RegisterController> {
  RegistrationWalletScreen({Key? key}) : super(key: key);
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final SliderController sController = SliderController();
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
                      SliderCaptcha(
                        controller: sController,
                        titleStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        image: Image.asset(
                          'assets/images/nightmode.jpg',
                          fit: BoxFit.fitWidth,
                        ),
                        colorBar: const Color.fromARGB(255, 255, 255, 255),
                        colorCaptChar: const Color.fromARGB(255, 248, 248, 248),
                        onConfirm: (bool value) async {
                          if (value) {
                            await navigationController
                                .navigateTo('/account_type');
                          } else {
                            sController.create();
                          }
                        },
                      ),
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
