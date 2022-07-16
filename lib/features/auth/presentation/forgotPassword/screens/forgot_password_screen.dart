import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/features/auth/presentation/forgotPassword/getx/forgot_controller.dart';

class ForgotPasswordScreen extends GetWidget<ForgotController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const String route = '/forgot-password';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Transform.translate(
              offset: const Offset(10, 0),
              child: const AppBackButton(),
            ),
          ),
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
                        height: 80,
                        color: context.colors.secondary,
                      ),
                    ),
                    const AppSpacing(v: 60),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: 'forgot_password'.tr,
                          style: context.h6.copyWith(
                            color: context.colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const AppSpacing(v: 60),
                    AppTextInput(
                      labelText: 'email_address'.tr.toUpperCase(),
                      initialValue: '',
                      backgroundColor: context.colors.primary.shade100,
                      prefixIcon: Icon(
                        Ionicons.mail_outline,
                        color: context.colors.hintLight,
                        size: 18,
                      ),
                      lableStyle: context.overline.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      errorStyle: context.captionError.copyWith(
                        color: context.colors.error,
                      ),
                      validator: controller.validateEmail,
                      onChanged: controller.onEmailInputChanged,
                    ),
                    const AppSpacing(v: 60),
                    AppButton(
                      enabled: controller.formIsValid,
                      padding: EdgeInsets.zero,
                      borderRadius: AppBorderRadius.largeAll,
                      backgroundColor: context.colors.primary,
                      onPressed: () => controller.forgot(context),
                      child: Text(
                        'verify_email'.tr.toUpperCase(),
                        style: context.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
                                text: 'remember_now'.tr,
                                style: context.caption.copyWith(
                                  color: context.colors.text,
                                ),
                              ),
                              TextSpan(
                                text: 'sign_in'.tr,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed<void>(LoginScreen.route);
                                  },
                                style: context.caption.copyWith(
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
