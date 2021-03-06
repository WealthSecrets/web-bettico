import 'dart:js' as js;

import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/features/auth/presentation/login/getx/login_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  final RegisterController rController = Get.find<RegisterController>();

  List<Map<String, dynamic>> footerLinks = [
    <String, dynamic>{
      'text': 'Certik',
      'link':
          'https://drive.google.com/file/d/1CpaYubbMAY377_bBVHW7x1PBvv2kliVK/view'
    },
    <String, dynamic>{
      'text': 'Audit',
      'link':
          'https://drive.google.com/file/d/189LTkNlKGKJhOUvnktuAIrrJHnPn3UO3/view'
    },
    <String, dynamic>{
      'text': 'Whitepaper',
      'link':
          'https://drive.google.com/drive/folders/1vXyezl7lrtgpo8lmOlMkO7n9DLkuGDkW'
    },
    <String, dynamic>{'text': 'Store', 'link': 'https://wealthsecrets.store/'},
    <String, dynamic>{
      'text': 'Advertise',
      'link': 'https://www.wealthsecrets.io/advertiseRequest'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingBox(
        loading:
            controller.isLoading.value || controller.isResendingEmail.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? double.infinity
                      : 400,
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: AppPaddings.lH,
                          child: AppAnimatedColumn(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (ResponsiveWidget.isSmallScreen(context))
                                const SizedBox(height: 20),
                              if (!ResponsiveWidget.isSmallScreen(context))
                                const SizedBox(height: 100),
                              Align(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    if (Get.locale ==
                                        const Locale('en', 'US')) {
                                      Get.updateLocale(
                                          const Locale('zh', 'CN'));
                                    } else {
                                      Get.updateLocale(
                                          const Locale('en', 'US'));
                                    }
                                  },
                                  child: Text(
                                    Get.locale == const Locale('en', 'US')
                                        ? '????????'
                                        : '????????',
                                  ),
                                ),
                              ),
                              if (ResponsiveWidget.isSmallScreen(context))
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SvgPicture.asset(
                                    AssetSVGs.logo.path,
                                    height: 80,
                                    color: context.colors.secondary,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'signin_to'.tr,
                                    style: TextStyle(
                                      color: context.colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Bettico',
                                        style: TextStyle(
                                          color:
                                              context.colors.primary.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Stack(
                                children: <Widget>[
                                  if (controller.isPhone.value)
                                    AppTextInput(
                                      labelText:
                                          'email_address'.tr.toUpperCase(),
                                      initialValue: '',
                                      backgroundColor:
                                          context.colors.primary.shade100,
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
                                      labelText:
                                          'phone_number'.tr.toUpperCase(),
                                      prefixIcon: Icon(
                                        Ionicons.call_outline,
                                        color: context.colors.hintLight,
                                        size: 18,
                                      ),
                                      initialValue: '',
                                      textInputType: TextInputType.phone,
                                      backgroundColor:
                                          context.colors.primary.shade100,
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
                                      transitionBuilder: (Widget? child,
                                          Animation<double> animation) {
                                        final Animation<double> offset =
                                            Tween<double>(begin: 0, end: 1.0)
                                                .animate(animation);
                                        return ScaleTransition(
                                            scale: offset, child: child);
                                      },
                                      switchInCurve: Curves.elasticOut,
                                      duration:
                                          const Duration(milliseconds: 700),
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
                                backgroundColor:
                                    context.colors.primary.shade100,
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
                              const SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  const SizedBox(width: 50),
                                  Expanded(
                                    child: Divider(
                                      color: context.colors.dividerColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'OR',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Divider(
                                      color: context.colors.dividerColor,
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {},
                                    child: Image.asset(
                                      'assets/images/facebook.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => rController
                                        .registerWithGoogleAuth(context),
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  // TextButton(
                                  //   onPressed: () {},
                                  //   child: Image.asset(
                                  //     'assets/images/twitter.png',
                                  //     height: 40,
                                  //     width: 40,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () =>
                                    Get.toNamed<void>(AppRoutes.registration),
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
                                              Get.toNamed<void>(
                                                  AppRoutes.accountType);
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ...footerLinks
                        .map(
                          (Map<String, dynamic> footerLink) => TextButton(
                            onPressed: () {
                              js.context.callMethod('open',
                                  <String>[footerLink['link'] as String]);
                            },
                            child: Text(
                              footerLink['text'] as String,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
