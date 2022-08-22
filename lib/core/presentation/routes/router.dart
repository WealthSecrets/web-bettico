import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/auth/presentation/register/arguments/otp_verification_argument.dart';
import 'package:betticos/features/auth/presentation/register/arguments/user_argument.dart';
import 'package:betticos/features/betticos/presentation/base/screens/base_screen.dart';
import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/responsiveness/home_base_screen.dart';
import 'package:betticos/features/responsiveness/large_timeline_screen.dart';
import 'package:betticos/features/responsiveness/large_update_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/register/screens/otp_verification_screen.dart';
import '../../../features/auth/presentation/register/screens/registratino_personal_information_screen.dart';
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
// import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.profile:
      return _getPageRoute(ProfileScreen(), settings);
    case AppRoutes.login:
      return _getPageRoute(LoginScreen(), settings);
    case AppRoutes.registration:
      return _getPageRoute(const RegistrationScreen(), settings);
    case AppRoutes.personalInformation:
      final UserArgument? args = settings.arguments as UserArgument?;
      return _getPageRoute(
          RegistrationPersonalInformationScreen(
            user: args?.user,
          ),
          settings);
    case AppRoutes.accountType:
      return _getPageRoute(const RegistrationAccountTypeScreen(), settings);
    case AppRoutes.forgot:
      return _getPageRoute(const ForgotPasswordScreen(), settings);
    case AppRoutes.reset:
      return _getPageRoute(const ResetScreen(), settings);
    case AppRoutes.profilePhoto:
      return _getPageRoute(const RegistrationUploadPhotoScreen(), settings);
    case AppRoutes.updateProfile:
      return _getPageRoute(const UpdateProfileScreen(), settings);
    case AppRoutes.otpVerify:
      final OTPVerificationArgument? args =
          settings.arguments as OTPVerificationArgument?;
      return _getPageRoute(
          OTPVerificationScreen(
            otpReceiverType: args!.otpReceiverType,
            user: args.user,
          ),
          settings);
    case AppRoutes.documentScreen:
      return _getPageRoute(const RegistrationDocumentScreen(), settings);
    case AppRoutes.timelinePost:
      return _getPageRoute(const TimelinePostScreen(), settings);
    case AppRoutes.members:
      return _getPageRoute(MembersScreen(), settings);
    case AppRoutes.oddsters:
      return _getPageRoute(OddstersScreen(), settings);
    case AppRoutes.oddboxes:
      return _getPageRoute(OddsboxScreen(), settings);
    case AppRoutes.onboard:
      return _getPageRoute(const OnboardingScreen(), settings);
    case AppRoutes.home:
      return _getPageRoute(const HomeBaseScreen(), settings);
    case AppRoutes.splash:
      return _getPageRoute(const SplashScreen(), settings);
    case AppRoutes.report:
      return _getPageRoute(const ReportScreen(), settings);
    case AppRoutes.settings:
      return _getPageRoute(SettingsScreen(), settings);
    case AppRoutes.livescore:
      return _getPageRoute(LiveScoreScreen(), settings);
    case AppRoutes.p2pBettingHistory:
      return _getPageRoute(const P2PBettingHistoryScreen(), settings);
    // case AppRoutes.p2pBetting:
    //   return _getPageRoute(const P2PBettingScreen(), settings);
    case AppRoutes.p2pSuccess:
      return _getPageRoute(const P2PBettingCongratScreen(), settings);
    case AppRoutes.timeline:
      return _getPageRoute(TimelineScreen(), settings);
    case AppRoutes.updates:
      return _getPageRoute(const LargeUdpateScreen(), settings);
    case AppRoutes.referral:
      return _getPageRoute(ReferralScreen(), settings);
    case AppRoutes.base:
      return _getPageRoute(const BaseScreen(), settings);
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
