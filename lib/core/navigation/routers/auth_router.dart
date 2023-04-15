import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import 'package:betticos/features/auth/presentation/forgotPassword/screens/forgot_wallet_screen.dart';
import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/otp_verification_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_account_type_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_document_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_wallet_screen.dart';
import 'package:betticos/features/auth/presentation/resetPassword/screens/reset_screen.dart';
import 'package:flutter/material.dart';

class AuthRouter {
  static Route<dynamic> router(RouteSettings settings) {
    return FadeInRoute<void>(
      builder: (BuildContext context) {
        return _widgetBuilder(settings, context);
      },
      settings: settings,
    );
  }

  static Widget _widgetBuilder(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case AuthRoutes.login:
        return LoginScreen();
      case AuthRoutes.registration:
        // final Uri settingsUri = Uri.parse(settings.name!);
        // final String? type = settingsUri.queryParameters['type'];
        return RegistrationScreen();
      case AuthRoutes.personalInformation:
        return const RegistrationPersonalInformationScreen();
      case AuthRoutes.forgot:
        return const ForgotPasswordScreen();
      case AuthRoutes.reset:
        return ResetScreen();
      case AuthRoutes.otpVerify:
        return const OTPVerificationScreen();
      case AuthRoutes.documentScreen:
        return RegistrationDocumentScreen();
      case AuthRoutes.uploadPhoto:
        return const RegistrationUploadPhotoScreen();
      case AuthRoutes.accountType:
        return RegistrationAccountTypeScreen();
      case AuthRoutes.walletConnect:
        return ForgotWalletScreen();
      case AuthRoutes.addressConnect:
        return RegistrationWalletScreen();
      default:
        return LoginScreen();
    }

    // if (settings.name == AuthRoutes.login) {
    //   return LoginScreen();
    // } else if (settings.name == AuthRoutes.registration) {
    //   return RegistrationScreen();
    // } else if(settings.name == AuthRoutes.personalInformation){
    //   return RegistrationPersonalInformationScreen()
    // }
  }
}
