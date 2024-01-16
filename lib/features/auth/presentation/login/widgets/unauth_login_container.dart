import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ionicons/ionicons.dart';

class UnAuthLoginController extends GetWidget<LoginController> {
  UnAuthLoginController({super.key});

  final RegisterController rController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return Obx(
      () => Material(
        child: AppLoadingBox(
          loading: controller.isLoading.value,
          child: Padding(
            padding: isSmallScreen ? AppPaddings.lH : const EdgeInsets.symmetric(horizontal: 100),
            child: AppAnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(AssetImages.logo, height: 30, width: 30),
                const SizedBox(height: 16),
                Text(
                  'Login to join activities on Xviral.',
                  style: isSmallScreen
                      ? context.h6.copyWith(fontWeight: FontWeight.bold, color: Colors.black)
                      : context.h5.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (controller.isPhone.value)
                  AppTextInput(
                    hintText: 'email_address'.tr,
                    errorStyle: TextStyle(color: context.colors.error, fontSize: 12),
                    validator: controller.validateEmail,
                    onChanged: controller.onEmailInputChanged,
                  )
                else
                  AppPhoneInput(
                    prefixIcon: const Icon(Ionicons.call_outline, size: 18),
                    hintText: 'phone_number'.tr,
                    textInputType: TextInputType.phone,
                    validator: controller.validatePhone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    onChanged: (PhoneNumber number) =>
                        controller.onPhoneInputChanged(number.phoneNumber, number.isoCode),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedSwitcher(
                    reverseDuration: Duration.zero,
                    transitionBuilder: (Widget? child, Animation<double> animation) {
                      final Animation<double> offset = Tween<double>(begin: 0, end: 1.0).animate(animation);
                      return ScaleTransition(scale: offset, child: child);
                    },
                    switchInCurve: Curves.elasticOut,
                    duration: const Duration(milliseconds: 700),
                    child: RichText(
                      text: TextSpan(
                        text: controller.isPhone.value ? 'login_mobile'.tr : 'login_email'.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.togglePhoneVisibility(!controller.isPhone.value);
                          },
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  obscureText: true,
                  hintText: 'password'.tr,
                  showObscureTextToggle: true,
                  errorStyle: TextStyle(color: context.colors.error, fontSize: 12),
                  validator: controller.validatePassword,
                  onChanged: controller.onPasswordInputChanged,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: 'forgot_pass'.tr,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed<void>(AppRoutes.forgot);
                        },
                      style: TextStyle(
                        color: context.colors.error,
                        fontWeight: FontWeight.w800,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  enabled: controller.formIsValid,
                  padding: EdgeInsets.zero,
                  backgroundColor: context.colors.primary,
                  onPressed: () {
                    controller.login(context);
                  },
                  child: Text(
                    'sign_in'.tr,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Get.offNamed<void>(AppRoutes.signup);
                  },
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: context.body2,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'no_account'.tr,
                            style: TextStyle(
                              color: context.colors.text,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'register_now'.tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed<void>(AppRoutes.signup);
                              },
                            style: TextStyle(
                              color: context.colors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
