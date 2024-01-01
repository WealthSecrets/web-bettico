import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/responses/auth_response/auth_response.dart';
import 'package:betticos/features/auth/data/models/responses/twilio/twilio_response.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/requests/login_request/login_request.dart';
import 'package:betticos/features/auth/domain/requests/login_wallet_request/login_wallet_request.dart';
import 'package:betticos/features/auth/domain/requests/resend_email/resend_email_request.dart';
import 'package:betticos/features/auth/domain/requests/sms/send_sms_request.dart';
import 'package:betticos/features/auth/domain/usecases/login_user.dart';
import 'package:betticos/features/auth/domain/usecases/login_user_wallet.dart';
import 'package:betticos/features/auth/domain/usecases/resend_email.dart';
import 'package:betticos/features/auth/domain/usecases/send_sms.dart';
import 'package:betticos/features/auth/presentation/register/arguments/otp_verification_screen_argument.dart';
import 'package:betticos/features/auth/presentation/register/arguments/user_argument.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LoginController extends GetxController {
  LoginController({
    required this.loginUser,
    required this.loginUserWallet,
    required this.resendEmail,
    required this.sendSms,
  });
  final LoginUser loginUser;
  final LoginUserWallet loginUserWallet;
  final ResendEmail resendEmail;
  final SendSms sendSms;

  RxBool isObscured = true.obs;
  RxBool isPhone = true.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString password = ''.obs;
  RxBool isLoggedIn = false.obs;
  // RxString walletAddress = ''.obs;

  // loading state
  RxBool isLoading = false.obs;
  RxBool isResendingEmail = false.obs;
  RxBool isSendingSms = false.obs;

  final BaseScreenController controller = Get.find<BaseScreenController>();
  final SettingsController settingsController = Get.find<SettingsController>();
  final WalletConnectProvider wc = WalletConnectProvider.binance();

  @override
  void onInit() {
    super.onInit();
    settingsController.getLanguagePreference();
  }

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

    final Either<Failure, AuthResponse> failureOrUser = await loginUser(
      LoginRequest(email: email.value, phone: phone.value, password: password.value),
    );

    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.show(context, message: failure.message);
      },
      (AuthResponse response) {
        isLoading(false);
        controller.user(response.user);
        controller.userToken(response.token);
        // reRouteOddster(context, user);
        Navigator.of(context).pop();
      },
    );
  }

  void loginWallet(BuildContext context, String address) async {
    isLoading(true);

    final Either<Failure, AuthResponse> failureOrUser = await loginUserWallet(
      LoginWalletRequest(wallet: address),
    );

    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        Get.toNamed<void>(
          AppRoutes.walletConnectRegistration,
        );
      },
      (AuthResponse response) {
        isLoading(false);
        reRouteOddster(context, response.user, token: response.token);
      },
    );
  }

  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  void reRouteOddster(BuildContext context, User user, {bool? isSkipEmail, bool? isSkipPhone, String? token}) {
    if (isSkipEmail ?? false) {
      if (!user.hasRole) {
        Get.toNamed<void>(AppRoutes.accountType);
      } else if (!user.isPersonalInfoProvided) {
        Get.toNamed<void>(AppRoutes.personalInformation);
      } else {
        subRerouting(user, context, token: token);
      }
    } else {
      subRerouting(user, context, token: token);
    }
  }

  void subRerouting(User user, BuildContext context, {String? token}) {
    if (user.role == 'oddster' && !user.hasIdentification) {
      Get.toNamed<void>(AppRoutes.documentScreen, arguments: UserArgument(user: user));
    } else if (user.role == 'oddster' && !user.hasProfileImage) {
      Get.toNamed<void>(AppRoutes.profilePhoto);
    } else {
      Get.until((_) => Get.currentRoute == AppRoutes.home);
      controller.user(user);
      if (token != null && token.isNotEmpty) {
        controller.userToken(token);
      }
      AppSnacks.show(
        context,
        message: 'Yay!, welcome to Xviral',
        backgroundColor: context.colors.success,
        leadingIcon: const Icon(Ionicons.checkmark_circle_sharp, color: Colors.white),
      );
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
      navigationController.navigateTo(
        AppRoutes.otpVerifyEmail,
        arguments: OTPVerificationScreenArgument(
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
      navigationController.navigateTo(AppRoutes.otpVerify);
      Get.offAll<void>(AppRoutes.otpVerify);
    }, (TwilioResponse value) {
      isSendingSms(false);
      navigationController.navigateTo(
        AppRoutes.otpVerifyPhone,
        arguments: OTPVerificationScreenArgument(
          user: controller.user.value,
        ),
      );
    });
  }

  void onEmailInputChanged(String value) {
    email(value.trim());
  }

  void onPhoneInputChanged(String? number, String? isoCode) {
    if (number != null) {
      phone.value = number;
    }
    if (isoCode != null) {}
  }

  void onPasswordInputChanged(String value) {
    password(value.trim());
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty) {
      errorMessage = 'Please enter email or username';
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
