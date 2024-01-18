import 'dart:async';

import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NewOtpVerificationScreen extends StatefulWidget {
  const NewOtpVerificationScreen({super.key});

  @override
  State<NewOtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<NewOtpVerificationScreen> {
  final RegisterController controller = Get.find<RegisterController>();
  final LoginController lController = Get.find<LoginController>();
  bool _showResendButton = false;

  int _counter = 59;
  late Timer _timer;

  // get arguments
  final OTPVerificationScreenArgument? args = Get.arguments as OTPVerificationScreenArgument?;
  final String? params = Get.parameters['type'];
  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(_startTimer);
    super.initState();
  }

  void _startTimer() {
    _counter = 59;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_counter > 0) {
          if (mounted) {
            setState(() => _counter--);
          }
        } else {
          _timer.cancel();
          if (mounted) {
            setState(() => _showResendButton = true);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String email = args != null && args!.user != null ? args!.user!.email ?? '' : controller.email.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: AppBackButton(onPressed: Get.back),
      ),
      backgroundColor: context.colors.background,
      body: AppLoadingBox(
        loading: controller.isVerifyingOTP.value || lController.isResendingEmail.value,
        child: Padding(
          padding: AppPaddings.lH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppAnimatedColumn(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'We sent you a code',
                    style: context.h5.copyWith(fontWeight: FontWeight.w600, color: context.colors.textInputText),
                  ),
                  const AppSpacing(v: 5),
                  SizedBox(
                    child: Text(
                      'Enter it below to verify $email',
                      style: context.body2.copyWith(fontWeight: FontWeight.w400, color: context.colors.darkenText),
                    ),
                  ),
                  const AppSpacing(v: 24),
                  AppPinCodeTextField(
                    length: 6,
                    onChanged: controller.onOTPCodeInputChanged,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textInputType: TextInputType.number,
                  ),
                  if (!_showResendButton) _Timer(counter: _counter),
                  Visibility(
                    visible: _showResendButton,
                    child: Align(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shadowColor: context.colors.primary,
                          foregroundColor: context.colors.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            _timer.cancel();
                            _counter = 59;
                            _showResendButton = false;
                          });
                          _startTimer();
                          if (params != null && params!.toLowerCase() == 'email') {
                            lController.resendOTPEmail(
                              context,
                              args != null && args!.user != null && args!.user!.email != null
                                  ? args!.user!.email!
                                  : controller.email.value,
                            );
                          } else {
                            lController.resendOTPSms(
                              context,
                              args != null && args!.user != null ? args!.user!.phone! : controller.phone.value,
                            );
                          }
                        },
                        child: Text(
                          'Resent code',
                          style: context.body1.copyWith(color: context.colors.primary, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                onPressed: () {
                  if (params != null && params!.toLowerCase() == 'email') {
                    controller.verifyUserEmailAddress(context, routeName: AppRoutes.newPasswordScreen, u: args?.user);
                  } else {
                    controller.verifyUserPhoneNumber(context, routeName: AppRoutes.newPasswordScreen, u: args?.user);
                  }
                },
                child: const Text(
                  'Verify Otp',
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const AppSpacing(v: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _Timer extends StatelessWidget {
  const _Timer({required this.counter});

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          'Resend code in: ',
          style: context.caption.copyWith(color: context.colors.text, fontWeight: FontWeight.w400),
        ),
        Text(
          '00:$counter',
          style: context.caption.copyWith(color: context.colors.text, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
