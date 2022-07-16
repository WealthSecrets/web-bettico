import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/register/screens/otp_verification_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_account_type_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_document_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
import '../../../features/auth/presentation/resetPassword/screens/reset_screen.dart';

Route<dynamic> onAuthGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.route:
      return _getPageRoute(LoginScreen(), settings);
    case RegistrationScreen.route:
      return _getPageRoute(const RegistrationScreen(), settings);
    case RegistrationPersonalInformationScreen.route:
      return _getPageRoute(
          const RegistrationPersonalInformationScreen(), settings);
    case RegistrationAccountTypeScreen.route:
      return _getPageRoute(const RegistrationAccountTypeScreen(), settings);
    case ForgotPasswordScreen.route:
      return _getPageRoute(const ForgotPasswordScreen(), settings);
    case ResetPasswordScreen.route:
      return _getPageRoute(const ResetPasswordScreen(), settings);
    case RegistrationUploadPhotoScreen.route:
      return _getPageRoute(const RegistrationUploadPhotoScreen(), settings);
    case OTPVerificationScreen.route:
      return _getPageRoute(const OTPVerificationScreen(), settings);
    case RegistrationDocumentScreen.route:
      return _getPageRoute(const RegistrationDocumentScreen(), settings);
    default:
      return _getPageRoute(LoginScreen(), settings);
  }
}

PageRoute<Widget> _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder<Widget> {
  _FadeRoute({required this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
  final Widget child;
  final String? routeName;
}
