import 'dart:async';

import 'package:betticos/features/auth/presentation/login/getx/login_controller.dart';
import 'package:betticos/features/auth/presentation/register/arguments/otp_verification_screen_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/auth/presentation/register/getx/register_controller.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';
import '../widgets/app_pincode_textfield.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final RegisterController controller = Get.find<RegisterController>();
  final LoginController lController = Get.find<LoginController>();
  bool _showResendButton = false;

  int _counter = 59;
  late Timer _timer;

  // get arguments
  final OTPVerificationScreenArgument? args =
      Get.arguments as OTPVerificationScreenArgument?;
  final String? params = Get.parameters['type'];

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _counter = 59;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            _showResendButton = true;
          });
          _timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isVerifyingOTP.value,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              '${params != null && params!.toLowerCase() == 'email' ? 'email'.tr : 'phone'.tr} ${'verification'.tr}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          backgroundColor: context.colors.background,
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: ResponsiveWidget.isSmallScreen(context)
                    ? double.infinity
                    : 450,
                child: SingleChildScrollView(
                  padding: AppPaddings.bodyA,
                  child: AppAnimatedColumn(
                    direction: Axis.horizontal,
                    duration: const Duration(milliseconds: 1000),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 273.w,
                        child: Text(
                          '${'otp_msg_1'.tr} ${params != null && params!.toLowerCase() == 'email' ? 'email'.tr.toLowerCase() : 'phone_number'.tr.toLowerCase()} ${'otp_msg_2'.tr}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            height: 1.22,
                            fontSize: 16,
                            color: context.colors.textDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const AppSpacing(v: 66),
                      AppPinCodeTextField(
                        length: 6,
                        onChanged: controller.onOTPCodeInputChanged,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputType: TextInputType.number,
                      ),
                      const AppSpacing(v: 50),
                      AppButton(
                        borderRadius: AppBorderRadius.largeAll,
                        enabled: controller.otpCode.value.length == 6,
                        onPressed: () {
                          if (params != null &&
                              params!.toLowerCase() == 'email') {
                            controller.verifyUserEmailAddress(
                              context,
                              u: args?.user,
                            );
                          } else {
                            controller.verifyUserPhoneNumber(
                              context,
                              u: args?.user,
                            );
                          }
                        },
                        child: Text(
                          'next'.tr.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const AppSpacing(v: 22),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'didnt_receive'.tr,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const AppSpacing(v: 8),
                      _buildTimer(),
                      const AppSpacing(v: 16),
                      Visibility(
                        visible: _showResendButton,
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shadowColor: context.colors.primary,
                              backgroundColor: context.colors.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                _timer.cancel();
                                _counter = 59;
                                _showResendButton = false;
                              });
                              _startTimer();
                              if (params != null &&
                                  params!.toLowerCase() == 'email') {
                                lController.resendOTPEmail(
                                  context,
                                  args != null &&
                                          args!.user != null &&
                                          args!.user!.email != null
                                      ? args!.user!.email!
                                      : controller.email.value,
                                );
                              } else {
                                lController.resendOTPSms(
                                  context,
                                  args != null && args!.user != null
                                      ? args!.user!.phone!
                                      : controller.phone.value,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'send_again'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            if (args != null && args!.user != null) {
                              lController.reRouteOddster(
                                context,
                                args!.user!,
                                isSkipEmail: params != null &&
                                    params!.toLowerCase() == 'email',
                                isSkipPhone: params != null &&
                                    params!.toLowerCase() != 'phone',
                              );
                            } else {
                              if (params != null &&
                                  params!.toLowerCase() == 'email') {
                                Get.toNamed<void>(AppRoutes.accountType);
                              } else {
                                Get.offAllNamed<void>(AppRoutes.home);
                              }
                            }
                          },
                          child: Text(
                            'skip'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: context.colors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const AppSpacing(v: 50),
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

  Widget _buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'resend_code'.tr,
          style: TextStyle(
            color: context.colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          '00:$_counter',
          style: TextStyle(
            color: context.colors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
