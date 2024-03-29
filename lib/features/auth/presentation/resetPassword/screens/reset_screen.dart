import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResetScreen extends GetWidget<ResetController> {
  ResetScreen({super.key});

  final ForgotController fController = Get.find<ForgotController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SizedBox(
              width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppPaddings.lH,
                  child: AppAnimatedColumn(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (ResponsiveWidget.isSmallScreen(context))
                        Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            AssetSVGs.logo.path,
                            height: 130,
                            colorFilter: ColorFilter.mode(context.colors.secondary, BlendMode.srcIn),
                          ),
                        ),
                      if (ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 10),
                      Align(
                        child: RichText(
                          text: TextSpan(
                            text: 'Reset password',
                            style: TextStyle(color: context.colors.black, fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      AppTextInput(
                        obscureText: true,
                        labelText: 'NEW PASSWORD',
                        showObscureTextToggle: true,
                        backgroundColor: context.colors.primary.shade100,
                        lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                        errorStyle: TextStyle(color: context.colors.error, fontSize: 12),
                        validator: controller.validatePassword,
                        onChanged: controller.onPasswordInputChanged,
                      ),
                      AppTextInput(
                        obscureText: true,
                        labelText: 'CONFRIM PASSWORD',
                        showObscureTextToggle: true,
                        backgroundColor: context.colors.primary.shade100,
                        lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                        errorStyle: TextStyle(color: context.colors.error, fontSize: 12),
                        validator: controller.validateConfirmPassword,
                        onChanged: controller.onConfirmPasswordInputChanged,
                      ),
                      if (ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 10),
                      if (!ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 50),
                      AppButton(
                        enabled: controller.formIsValid,
                        padding: EdgeInsets.zero,
                        borderRadius: AppBorderRadius.largeAll,
                        backgroundColor: context.colors.primary,
                        onPressed: () => controller.reset(context, fController.email.value),
                        child: Text(
                          'reset password'.toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => Get.offNamed<void>(AppRoutes.forgot),
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Want to change forgot email? ',
                                  style: TextStyle(color: context.colors.text),
                                ),
                                TextSpan(
                                  text: 'Tap here',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offNamed<void>(AppRoutes.forgot);
                                    },
                                  style: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
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
