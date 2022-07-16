import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/betticos/presentation/base/screens/base_screen.dart';
import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/responsiveness/large_timeline_screen.dart';
import 'package:betticos/features/responsiveness/large_update_screen.dart';
// import 'package:betticos/features/responsiveness/responsive_layout.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/register/screens/otp_verification_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_account_type_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_document_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
import '../../../features/auth/presentation/resetPassword/screens/reset_screen.dart';
import '../../../features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import '../../../features/betticos/presentation/profile/screens/profile_screen.dart';
import '../../../features/betticos/presentation/profile/screens/update_profile_screen.dart';
import '../../../features/betticos/presentation/report/screens/report_screen.dart';
import '../../../features/betticos/presentation/timeline/screens/timeline_post_screen.dart';
import '../../../features/onboarding_splash/presentation/onbaording/screens/onboarding_screen.dart';
import '../../../features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
import '../../../features/p2p_betting/presentation/livescore/screens/livescore_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_history_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ProfileScreen.route:
      return _getPageRoute(ProfileScreen(), settings);
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
    case UpdateProfileScreen.route:
      return _getPageRoute(const UpdateProfileScreen(), settings);
    case OTPVerificationScreen.route:
      return _getPageRoute(const OTPVerificationScreen(), settings);
    case RegistrationDocumentScreen.route:
      return _getPageRoute(const RegistrationDocumentScreen(), settings);
    case TimelinePostScreen.route:
      return _getPageRoute(const TimelinePostScreen(), settings);
    case MembersScreen.route:
      return _getPageRoute(MembersScreen(), settings);
    case OddstersScreen.route:
      return _getPageRoute(OddstersScreen(), settings);
    case OddsboxScreen.route:
      return _getPageRoute(OddsboxScreen(), settings);
    case OnboardingScreen.route:
      return _getPageRoute(const OnboardingScreen(), settings);
    case SplashScreen.route:
      return _getPageRoute(const SplashScreen(), settings);
    case ReportScreen.route:
      return _getPageRoute(const ReportScreen(), settings);
    case SettingsScreen.route:
      return _getPageRoute(SettingsScreen(), settings);
    case LiveScoreScreen.route:
      return _getPageRoute(LiveScoreScreen(), settings);
    case P2PBettingHistoryScreen.route:
      return _getPageRoute(const P2PBettingHistoryScreen(), settings);
    case P2PBettingScreen.route:
      return _getPageRoute(const P2PBettingScreen(), settings);
    case P2PBettingCongratScreen.route:
      return _getPageRoute(const P2PBettingCongratScreen(), settings);
    case TimelineScreen.route:
      return _getPageRoute(TimelineScreen(), settings);
    case LargeUdpateScreen.route:
      return _getPageRoute(const LargeUdpateScreen(), settings);
    case ReferralScreen.route:
      return _getPageRoute(ReferralScreen(), settings);
    case BaseScreen.route:
      return _getPageRoute(const BaseScreen(), settings);
    // case AppRoutes.responsiveLayout:
    //   return _getPageRoute(const ResponsiveLayout());
    default:
      return _getPageRoute(const LargeTimelineScreen(), settings);
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
