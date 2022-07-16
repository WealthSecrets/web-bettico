import 'package:betticos/features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/features/auth/presentation/resetPassword/getx/reset_controller.dart';

class ResetPasswordScreen extends GetWidget<ResetController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  static const String route = '/forgot-password/reset-password';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.lH,
                child: AppAnimatedColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        AssetSVGs.logo.path,
                        height: 130,
                        color: context.colors.secondary,
                      ),
                    ),
                    const AppSpacing(v: 10),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: 'Reset password ',
                          style: context.h6.copyWith(
                            color: context.colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const AppSpacing(v: 50),
                    AppTextInput(
                      obscureText: true,
                      labelText: 'PASSWORD',
                      showObscureTextToggle: true,
                      backgroundColor: context.colors.primary.shade100,
                      prefixIcon: Icon(
                        Ionicons.lock_closed_outline,
                        color: context.colors.hintLight,
                      ),
                      lableStyle: context.overline.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      errorStyle: context.captionError.copyWith(
                        color: context.colors.error,
                      ),
                      validator: controller.validatePassword,
                      onChanged: controller.onPasswordInputChanged,
                    ),
                    AppTextInput(
                      obscureText: true,
                      labelText: 'CONFRIM PASSWORD',
                      showObscureTextToggle: true,
                      backgroundColor: context.colors.primary.shade100,
                      prefixIcon: Icon(
                        Ionicons.lock_closed_outline,
                        color: context.colors.hintLight,
                      ),
                      lableStyle: context.overline.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      errorStyle: context.captionError.copyWith(
                        color: context.colors.error,
                      ),
                      validator: controller.validateConfirmPassword,
                      onChanged: controller.onConfirmPasswordInputChanged,
                    ),
                    const AppSpacing(v: 10),
                    AppButton(
                      enabled: controller.formIsValid,
                      padding: EdgeInsets.zero,
                      borderRadius: AppBorderRadius.largeAll,
                      backgroundColor: context.colors.primary,
                      onPressed: () => controller.reset(context),
                      // onPressed: () => Get.toNamed<void>(AppRoutes.reset),
                      child: const Text(
                        'RESET PASSWORD',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const AppSpacing(v: 10),
                    TextButton(
                      onPressed: () {},
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: context.body2,
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
                                    Get.toNamed<void>(
                                      ForgotPasswordScreen.route,
                                    );
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
                    const AppSpacing(v: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
