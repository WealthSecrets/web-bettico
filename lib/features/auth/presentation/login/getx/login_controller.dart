import 'package:betticos/core/presentation/web_controllers/menu_controller.dart';
import 'package:betticos/features/auth/presentation/register/arguments/user_argument.dart';
import 'package:betticos/features/auth/presentation/register/screens/otp_verification_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import 'package:betticos/features/betticos/presentation/base/screens/base_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart' as validator;

import '/core/core.dart';
import '/features/auth/data/models/responses/twilio/twilio_response.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/enums/otp_receiver_type.dart';
import '/features/auth/domain/requests/login_request/login_request.dart';
import '/features/auth/domain/requests/resend_email/resend_email_request.dart';
import '/features/auth/domain/requests/sms/send_sms_request.dart';
import '/features/auth/domain/usecases/login_user.dart';
import '/features/auth/domain/usecases/resend_email.dart';
import '/features/auth/domain/usecases/send_sms.dart';
import '/features/auth/presentation/register/arguments/otp_verification_argument.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';

class LoginController extends GetxController {
  LoginController({
    required this.loginUser,
    required this.resendEmail,
    required this.sendSms,
  });
  final LoginUser loginUser;
  final ResendEmail resendEmail;
  final SendSms sendSms;

  RxBool isObscured = true.obs;
  RxBool isPhone = true.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString password = ''.obs;
  RxBool isLoggedIn = false.obs;

  // loading state
  RxBool isLoading = false.obs;
  RxBool isResendingEmail = false.obs;
  RxBool isSendingSms = false.obs;

  final BaseScreenController controller = Get.find<BaseScreenController>();
  final MenuController menuController = Get.find<MenuController>();

  void togglePasswordVisibility() {
    isObscured(!isObscured.value);
  }

  void togglePhoneVisibility(bool bool) {
    isPhone(!isPhone.value);
    email('');
    phone('');
  }

  void login(BuildContext context) async {
    isLoading(true);

    final Either<Failure, User> failureOrUser = await loginUser(
      LoginRequest(
        email: email.value,
        phone: phone.value,
        password: password.value,
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (User user) {
        isLoading(false);
        controller.user(user);
        reRouteOddster(context, user);
      },
    );
  }

  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  void reRouteOddster(BuildContext context, User user, {bool? isSkipEmail, bool? isSkipPhone}) {
    if (user.username == null) {
      Get.toNamed<void>(
        RegistrationPersonalInformationScreen.route,
        arguments: UserArgument(user: user),
      );
    } else {
      if (ResponsiveWidget.isSmallScreen(context)) {
        Get.toNamed<void>(BaseScreen.route);
      } else {
        Get.offAll<void>(TimelineScreen.route);
        menuController.changeActiveItemTo(TimelineScreen.route);
      }
    }
  }

  void resendOTPEmail(BuildContext context, String email) async {
    isResendingEmail(true);

    final Either<Failure, User> fialureOrSuccess = await resendEmail(
      ResendEmailRequest(email: email),
    );

    fialureOrSuccess.fold((Failure failure) {
      isResendingEmail(false);
      AppSnacks.show(context, message: failure.message);
    }, (User user) {
      isResendingEmail(false);
      Get.toNamed<void>(
        OTPVerificationScreen.route,
        arguments: OTPVerificationArgument(
          otpReceiverType: OTPReceiverType.email,
          user: user,
        ),
      );
    });
  }

  void resendOTPSms(BuildContext context, String phone) async {
    isSendingSms(true);
    final Either<Failure, TwilioResponse> fialureOrSuccess = await sendSms(
      SendSmsRequest(phone: phone),
    );

    fialureOrSuccess.fold((Failure failure) {
      isSendingSms(false);
      Get.offAll<void>(OTPVerificationScreen.route);
    }, (TwilioResponse value) {
      isSendingSms(false);
      Get.offAll<void>(
        OTPVerificationScreen.route,
        arguments: OTPVerificationArgument(
          otpReceiverType: OTPReceiverType.phoneNumber,
          user: controller.user.value,
        ),
      );
    });
  }

  void onEmailInputChanged(String value) {
    email(value.trim());
  }

  void onPhoneInputChanged(String value) {
    phone(value.trim());
  }

  void onPasswordInputChanged(String value) {
    password(value.trim());
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty) {
      errorMessage = 'Please enter email address';
    }

    if (!validator.isEmail(email.trim())) {
      errorMessage = 'Invalid email';
    }

    return errorMessage;
  }

  String? validatePhone(String? phone) {
    String? errorMessage;
    if (phone!.isEmpty) {
      errorMessage = 'Please enter your phone number.';
    }
    return errorMessage;
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isEmpty) {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }

  bool get formIsValid =>
      validateEmail(email.value) == null ||
      validatePhone(phone.value) == null && validatePassword(password.value) == null;
}
