import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/presentation/login/getx/login_controller.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class UnAuthLoginController extends GetWidget<LoginController> {
  UnAuthLoginController({Key? key}) : super(key: key);

  final RegisterController rController = Get.find<RegisterController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: AppAnimatedColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(AssetImages.logo, height: 30, width: 30),
            const SizedBox(height: 16),
            const Text(
              'Login to join activities on Xviral.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Stack(
              children: <Widget>[
                if (controller.isPhone.value)
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
                  )
                else
                  AppPhoneInput(
                    labelText: 'phone_number'.tr.toUpperCase(),
                    prefixIcon: Icon(
                      Ionicons.call_outline,
                      color: context.colors.hintLight,
                      size: 18,
                    ),
                    initialValue: '',
                    textInputType: TextInputType.phone,
                    backgroundColor: context.colors.primary.shade100,
                    lableStyle: TextStyle(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                    validator: controller.validatePhone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    onChanged: controller.onPhoneInputChanged,
                  ),
                const SizedBox(height: 8),
                Positioned(
                  right: 10,
                  child: AnimatedSwitcher(
                    reverseDuration: Duration.zero,
                    transitionBuilder:
                        (Widget? child, Animation<double> animation) {
                      final Animation<double> offset =
                          Tween<double>(begin: 0, end: 1.0).animate(animation);
                      return ScaleTransition(scale: offset, child: child);
                    },
                    switchInCurve: Curves.elasticOut,
                    duration: const Duration(milliseconds: 700),
                    child: RichText(
                      text: TextSpan(
                        text: controller.isPhone.value
                            ? 'login_mobile'.tr
                            : 'login_email'.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.togglePhoneVisibility(
                                !controller.isPhone.value);
                          },
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppTextInput(
              obscureText: true,
              labelText: 'password'.tr.toUpperCase(),
              showObscureTextToggle: true,
              backgroundColor: context.colors.primary.shade100,
              prefixIcon: Icon(
                Ionicons.lock_closed_outline,
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
              borderRadius: AppBorderRadius.largeAll,
              backgroundColor: context.colors.primary,
              onPressed: () => controller.login(context),
              child: Text(
                'sign_in'.tr.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Get.toNamed<void>(AppRoutes.signup);
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
                            Get.toNamed<void>(AppRoutes.signup);
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
    );
  }
}