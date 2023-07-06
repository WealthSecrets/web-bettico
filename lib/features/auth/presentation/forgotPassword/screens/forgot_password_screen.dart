import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/features/auth/presentation/forgotPassword/getx/forgot_controller.dart';

class ForgotPasswordScreen extends GetWidget<ForgotController> {
  const ForgotPasswordScreen({super.key});

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
            child: SizedBox(
              width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppPaddings.lH,
                  child: AppAnimatedColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (ResponsiveWidget.isSmallScreen(context))
                        Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            AssetSVGs.logo.path,
                            height: 80,
                            colorFilter: ColorFilter.mode(context.colors.secondary, BlendMode.srcIn),
                          ),
                        ),
                      if (ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 60),
                      Align(
                        child: RichText(
                          text: TextSpan(
                            text: 'forgot_password'.tr,
                            style: TextStyle(
                              color: context.colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      AppTextInput(
                        labelText: 'email_address'.tr.toUpperCase(),
                        initialValue: '',
                        backgroundColor: context.colors.primary.shade100,
                        prefixIcon: Icon(
                          Ionicons.mail_outline,
                          color: context.colors.hintLight,
                          size: 18,
                        ),
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        errorStyle: TextStyle(
                          color: context.colors.error,
                          fontSize: 12,
                        ),
                        validator: controller.validateEmail,
                        onChanged: controller.onEmailInputChanged,
                      ),
                      const SizedBox(height: 60),
                      AppButton(
                        enabled: controller.formIsValid,
                        padding: EdgeInsets.zero,
                        borderRadius: AppBorderRadius.largeAll,
                        backgroundColor: context.colors.primary,
                        onPressed: () => controller.forgot(context),
                        child: Text(
                          'verify_email'.tr.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed<void>(AppRoutes.login);
                        },
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: context.colors.text,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'remember_now'.tr,
                                  style: TextStyle(
                                    color: context.colors.text,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: 'sign_in'.tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offAllNamed<void>(AppRoutes.login);
                                    },
                                  style: TextStyle(
                                    color: context.colors.primary,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
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
