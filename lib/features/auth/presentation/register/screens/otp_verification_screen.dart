// import 'dart:async';

import 'dart:async';

import 'package:betticos/features/auth/presentation/login/getx/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/core/core.dart';
// import 'package:flutter/gestures.dart';
import '/features/auth/domain/enums/otp_receiver_type.dart';
import '/features/auth/presentation/register/arguments/otp_verification_argument.dart';
import '/features/auth/presentation/register/getx/register_controller.dart';
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
    final OTPVerificationArgument? args =
        ModalRoute.of(context)?.settings.arguments as OTPVerificationArgument?;

    return Obx(
      () => AppLoadingBox(
        loading: controller.isVerifyingOTP.value,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text(
              '${args?.otpReceiverType == OTPReceiverType.email ? 'email'.tr : 'phone'.tr} ${'verification'.tr}',
              style: context.body1.copyWith(
                color: Colors.black,
                // fontFamily: AppFonts.julius,
              ),
            ),
          ),
          backgroundColor: context.colors.background,
          body: SafeArea(
            child: SizedBox.expand(
              child: SingleChildScrollView(
                padding: AppPaddings.bodyA,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppAnimatedColumn(
                      direction: Axis.horizontal,
                      duration: const Duration(milliseconds: 1000),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 273.w,
                          child: Text(
                            '${'otp_msg_1'.tr} ${args?.otpReceiverType == OTPReceiverType.email ? 'email'.tr.toLowerCase() : 'phone_number'.tr.toLowerCase()} ${'otp_msg_2'.tr}',
                            style: context.body1.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.22,
                            ),
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
                          // enabled: cubit.state.otpCode.length == 6,
                          borderRadius: AppBorderRadius.largeAll,
                          enabled: true,
                          onPressed: () {
                            final OTPReceiverType? type = args?.otpReceiverType;
                            if (type != null) {
                              if (type == OTPReceiverType.email) {
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
                            }
                          },
                          child: Text('next'.tr.toUpperCase()),
                        ),
                        const AppSpacing(v: 22),
                        if (args?.otpReceiverType ==
                            OTPReceiverType.phoneNumber)
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'didnt_receive'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        _buildTimer(),
                        Visibility(
                          visible: _showResendButton,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shadowColor: context.colors.primary,
                                primary: context.colors.primary,
                              ),
                              onPressed: () {
                                final OTPReceiverType? type =
                                    args?.otpReceiverType;
                                setState(() {
                                  _timer.cancel();
                                  _counter = 59;
                                  _showResendButton = false;
                                });
                                _startTimer();
                                if (type == OTPReceiverType.email) {
                                  lController.resendOTPEmail(
                                    context,
                                    args != null && args.user != null
                                        ? args.user!.email
                                        : controller.email.value,
                                  );
                                } else {
                                  lController.resendOTPSms(
                                    context,
                                    args != null && args.user != null
                                        ? args.user!.phone!
                                        : controller.phone.value,
                                  );
                                }
                              },
                              child: Text(
                                'send_again'.tr,
                                style: TextStyle(
                                  color: context.colors.primary,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              if (args != null && args.user != null) {
                                lController.reRouteOddster(
                                  context,
                                  args.user!,
                                  isSkipEmail: args.otpReceiverType ==
                                      OTPReceiverType.email,
                                  isSkipPhone: args.otpReceiverType !=
                                      OTPReceiverType.email,
                                );
                              } else {
                                Get.toNamed<void>(AppRoutes.accountType);
                              }
                            },
                            child: Text(
                              'skip'.tr,
                              textAlign: TextAlign.center,
                              style: context.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colors.primary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const AppSpacing(v: 50),
                      ],
                    ),
                  ],
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
          ),
        ),
        Text(
          '00:$_counter',
          style: TextStyle(
            color: context.colors.primary,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
