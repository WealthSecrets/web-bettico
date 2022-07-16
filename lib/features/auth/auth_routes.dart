import 'package:betticos/features/auth/presentation/register/screens/otp_verification_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_account_type_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_document_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
import 'package:flutter/material.dart';

import '../../core/presentation/utils/route_animation.dart';
import 'presentation/forgotPassword/screens/forgot_password_screen.dart';
import 'presentation/login/screens/login_screen.dart';
import 'presentation/register/screens/registration_screen.dart';
import 'presentation/resetPassword/screens/reset_screen.dart';

class AuthRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return FadeInRoute<void>(
      builder: (BuildContext context) {
        return _widgetBuilder(settings, context);
      },
      settings: settings,
    );
  }

  static Widget _widgetBuilder(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case RegistrationScreen.route:
        return const RegistrationScreen();

      case RegistrationAccountTypeScreen.route:
        return const RegistrationAccountTypeScreen();

      case ResetPasswordScreen.route:
        return const ResetPasswordScreen();

      case ForgotPasswordScreen.route:
        return const ForgotPasswordScreen();

      case LoginScreen.route:
        return LoginScreen();

      case RegistrationDocumentScreen.route:
        return const RegistrationDocumentScreen();

      case OTPVerificationScreen.route:
        return const OTPVerificationScreen();

      case RegistrationPersonalInformationScreen.route:
        return const RegistrationPersonalInformationScreen();

      case RegistrationUploadPhotoScreen.route:
        return const RegistrationUploadPhotoScreen();

      default:
        return LoginScreen();
    }
  }
}
