import 'dart:async';

import 'package:betticos/features/auth/presentation/login/getx/login_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/auth/domain/enums/otp_receiver_type.dart';
import '/features/auth/presentation/register/getx/register_controller.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';
import '../../../data/models/user/user.dart';
import '../widgets/app_pincode_textfield.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    Key? key,
    required this.otpReceiverType,
    this.user,
  }) : super(key: key);

  final OTPReceiverType otpReceiverType;
  final User? user;

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
    return Obx(
      () => AppLoadingBox(
        loading: controller.isVerifyingOTP.value,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text(
              '${widget.otpReceiverType == OTPReceiverType.email ? 'email'.tr : 'phone'.tr} ${'verification'.tr}',
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
                          '${'otp_msg_1'.tr} ${widget.otpReceiverType == OTPReceiverType.email ? 'email'.tr.toLowerCase() : 'phone_number'.tr.toLowerCase()} ${'otp_msg_2'.tr}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            height: 1.22,
                            fontSize: 16,
                            color: context.colors.hintLight,
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
                          // final OTPReceiverType? type = widget.otpReceiverType;
                          // if (type != null) {
                          if (widget.otpReceiverType == OTPReceiverType.email) {
                            controller.verifyUserEmailAddress(
                              context,
                              u: widget.user,
                            );
                          } else {
                            controller.verifyUserPhoneNumber(
                              context,
                              u: widget.user,
                            );
                          }
                          // }
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
                      if (widget.otpReceiverType == OTPReceiverType.phoneNumber)
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
                      _buildTimer(),
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
                              if (widget.otpReceiverType ==
                                  OTPReceiverType.email) {
                                lController.resendOTPEmail(
                                  context,
                                  widget.user != null
                                      ? widget.user!.email
                                      : controller.email.value,
                                );
                              } else {
                                lController.resendOTPSms(
                                  context,
                                  widget.user != null
                                      ? widget.user!.phone!
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
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            if (widget.user != null) {
                              lController.reRouteOddster(
                                context,
                                widget.user!,
                                isSkipEmail: widget.otpReceiverType ==
                                    OTPReceiverType.email,
                                isSkipPhone: widget.otpReceiverType !=
                                    OTPReceiverType.email,
                              );
                            } else {
                              navigationController
                                  .navigateTo(AppRoutes.accountType);
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
