// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/social_buttons_row.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/features/auth/presentation/login/getx/login_controller.dart';
import '../../../../responsiveness/constants/web_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  final RegisterController rController = Get.find<RegisterController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();

  List<Map<String, dynamic>> footerLinks = <Map<String, dynamic>>[
    <String, dynamic>{
      'text': 'Certik',
      'link': 'https://drive.google.com/file/d/1CpaYubbMAY377_bBVHW7x1PBvv2kliVK/view'
    },
    <String, dynamic>{
      'text': 'Audit',
      'link': 'https://drive.google.com/file/d/189LTkNlKGKJhOUvnktuAIrrJHnPn3UO3/view'
    },
    <String, dynamic>{
      'text': 'Whitepaper',
      'link': 'https://drive.google.com/file/d/1dNU6GwTT_WyFglyZuA7gnJsc7-8Mx3lP/view?usp=sharing'
    },
    <String, dynamic>{'text': 'Buy WSC', 'link': 'https://staking.wealthsecrets.io/swap'},
    <String, dynamic>{'text': 'Store', 'link': 'https://wealthsecrets.store/'},
    // <String, dynamic>{
    //   'text': 'Advertise',
    //   'link': 'https://www.wealthsecrets.io/advertiseRequest'
    // },
    <String, dynamic>{
      'text': 'Terms & Condition',
      'link':
          'https://docs.google.com/document/d/1Vn14jjtxqu9YIJTw8e0AQxpdFImu8zNL/edit?usp=sharing&ouid=110662449020690083700&rtpof=true&sd=true'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingBox(
        loading: controller.isLoading.value || controller.isResendingEmail.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FooterView(
              footer: Footer(
                backgroundColor: Colors.grey.shade100,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      js.context.callMethod('open', <String>['https://www.wealthsecrets.io/']);
                                    },
                                    child: const Text(
                                      'About us',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      js.context.callMethod('open', <String>['https://www.wealthsecrets.io/']);
                                    },
                                    child: const Text(
                                      'FAQs',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      js.context.callMethod('open', <String>[
                                        'https://drive.google.com/file/d/155bueJQq6C47kYlvfDso5ufGVK9rM9g0/view?usp=sharing'
                                      ]);
                                    },
                                    child: const Text(
                                      'Terms & conditions',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      js.context.callMethod('open', <String>[
                                        'https://drive.google.com/file/d/1FPK_-ptXwR3c4T8V3sSO4EI7xX2x5-dH/view?usp=sharing'
                                      ]);
                                    },
                                    child: const Text(
                                      'Privacy Policy',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      js.context.callMethod('open', <String>[
                                        'https://drive.google.com/file/d/1Wo5WX4sHvsjsdpYUM3jWmc6CijUKSb9-/view?usp=sharing'
                                      ]);
                                    },
                                    child: const Text(
                                      'Gaming Policy',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      js.context.callMethod('open', <String>[
                                        'https://drive.google.com/file/d/1fegkWTvJJS7pjU9cbKCXWYgAEPixlLg5/view?usp=sharing'
                                      ]);
                                    },
                                    child: const Text(
                                      'AML/KYC Policy',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed<void>(AppRoutes.livescore);
                                      menuController.changeActiveItemTo(AppRoutes.livescore);
                                    },
                                    child: const Text(
                                      'Live Games',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      js.context.callMethod('open', <String>[
                                        'https://drive.google.com/file/d/1Wo5WX4sHvsjsdpYUM3jWmc6CijUKSb9-/view?usp=sharing'
                                      ]);
                                    },
                                    child: const Text(
                                      '18+',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 500,
                    child: SingleChildScrollView(
                      padding: AppPaddings.lH,
                      child: AppAnimatedColumn(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 100),
                          if (ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                if (Get.locale == const Locale('en', 'US')) {
                                  Get.updateLocale(const Locale('zh', 'CN'));
                                } else {
                                  Get.updateLocale(const Locale('en', 'US'));
                                }
                              },
                              child: Text(
                                Get.locale == const Locale('en', 'US') ? '🇨🇳' : '🇺🇸',
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          if (ResponsiveWidget.isSmallScreen(context))
                            Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(AssetImages.logo, height: 50),
                            ),
                          if (ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 80),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: 'signin_to'.tr,
                                style: TextStyle(
                                  color: context.colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Xviral',
                                    style: TextStyle(
                                      color: context.colors.primary.shade700,
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
                                  onChanged: (PhoneNumber phone) =>
                                      controller.onPhoneInputChanged(phone.phoneNumber, phone.isoCode),
                                ),
                              const SizedBox(height: 8),
                              Positioned(
                                right: 10,
                                child: AnimatedSwitcher(
                                  reverseDuration: Duration.zero,
                                  transitionBuilder: (Widget? child, Animation<double> animation) {
                                    final Animation<double> offset =
                                        Tween<double>(begin: 0, end: 1.0).animate(animation);
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
                          const SizedBox(height: 16),
                          SocialButtonsRow(),
                          const SizedBox(height: 16),
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
                        ],
                      ),
                    ),
                  ),
                )
              ]),
        ),
      );
    });
  }
}
