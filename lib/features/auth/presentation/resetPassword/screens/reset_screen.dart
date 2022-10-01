import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/auth/presentation/forgotPassword/getx/forgot_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/features/auth/presentation/resetPassword/getx/reset_controller.dart';

class ResetScreen extends GetWidget<ResetController> {
  ResetScreen({Key? key}) : super(key: key);
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
              width: ResponsiveWidget.isSmallScreen(context)
                  ? double.infinity
                  : 450,
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
                            color: context.colors.secondary,
                          ),
                        ),
                      if (ResponsiveWidget.isSmallScreen(context))
                        const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: 'Reset password ',
                            style: TextStyle(
                              color: context.colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      // AppTextInput(
                      //   obscureText: true,
                      //   labelText: 'RESET CODE',
                      //   showObscureTextToggle: true,
                      //   backgroundColor: context.colors.primary.shade100,
                      //   lableStyle: TextStyle(
                      //     color: context.colors.primary,
                      //     fontWeight: FontWeight.w700,
                      //     fontSize: 10,
                      //   ),
                      //   errorStyle: TextStyle(
                      //     color: context.colors.error,
                      //     fontSize: 12,
                      //   ),
                      //   textInputType: TextInputType.number,
                      //   validator: controller.validateResetCode,
                      //   onChanged: controller.onResetInputChanged,
                      // ),
                      AppTextInput(
                        obscureText: true,
                        labelText: 'NEW PASSWORD',
                        showObscureTextToggle: true,
                        backgroundColor: context.colors.primary.shade100,
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        errorStyle: TextStyle(
                          color: context.colors.error,
                          fontSize: 12,
                        ),
                        validator: controller.validatePassword,
                        onChanged: controller.onPasswordInputChanged,
                      ),
                      AppTextInput(
                        obscureText: true,
                        labelText: 'CONFRIM PASSWORD',
                        showObscureTextToggle: true,
                        backgroundColor: context.colors.primary.shade100,
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        errorStyle: TextStyle(
                          color: context.colors.error,
                          fontSize: 12,
                        ),
                        validator: controller.validateConfirmPassword,
                        onChanged: controller.onConfirmPasswordInputChanged,
                      ),
                      if (ResponsiveWidget.isSmallScreen(context))
                        const SizedBox(height: 10),
                      if (!ResponsiveWidget.isSmallScreen(context))
                        const SizedBox(height: 50),
                      AppButton(
                        enabled: controller.formIsValid,
                        padding: EdgeInsets.zero,
                        borderRadius: AppBorderRadius.largeAll,
                        backgroundColor: context.colors.primary,
                        onPressed: () =>
                            controller.reset(context, fController.email.value),
                        // onPressed: () => Get.toNamed<void>(AppRoutes.reset),
                        child: Text(
                          'reset password'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          navigationController.navigateTo(AppRoutes.forgot);
                        },
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Want to change email? ',
                                  style: TextStyle(
                                    color: context.colors.text,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Tap here',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      navigationController
                                          .navigateTo(AppRoutes.forgot);
                                    },
                                  style: TextStyle(
                                    color: context.colors.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
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
