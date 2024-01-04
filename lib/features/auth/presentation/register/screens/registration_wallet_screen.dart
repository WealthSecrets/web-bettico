import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slider_captcha/slider_captcha.dart';
import '/core/core.dart';

class RegistrationWalletScreen extends GetWidget<RegisterController> {
  RegistrationWalletScreen({super.key});

  final SliderController sController = SliderController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Transform.translate(offset: const Offset(10, 0), child: const AppBackButton()),
        ),
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: AppLoadingBox(
            loading: controller.isUpdatingUserRole.value,
            child: Center(
              child: SizedBox(
                width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
                child: SingleChildScrollView(
                  padding: AppPaddings.bodyH,
                  child: AppAnimatedColumn(
                    direction: Axis.horizontal,
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
                        image: Image.asset('assets/images/nightmode.jpg', fit: BoxFit.fitWidth),
                        colorBar: const Color.fromARGB(255, 255, 255, 255),
                        colorCaptChar: const Color.fromARGB(255, 248, 248, 248),
                        onConfirm: (bool value) async {
                          if (value) {
                            await navigationController.navigateTo(AppRoutes.accountType);
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
