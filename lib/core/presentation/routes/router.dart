import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/betticos/presentation/base/screens/base_screen.dart';
import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/responsiveness/large_timeline_screen.dart';
import 'package:betticos/features/responsiveness/large_update_screen.dart';
import 'package:betticos/features/responsiveness/responsive_layout.dart';
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
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.profile:
      return _getPageRoute(ProfileScreen());
    case AppRoutes.login:
      return _getPageRoute(LoginScreen());
    case AppRoutes.registration:
      return _getPageRoute(const RegistrationScreen());
    case AppRoutes.personalInformation:
      return _getPageRoute(const RegistrationPersonalInformationScreen());
    case AppRoutes.accountType:
      return _getPageRoute(const RegistrationAccountTypeScreen());
    case AppRoutes.forgot:
      return _getPageRoute(const ForgotPasswordScreen());
    case AppRoutes.reset:
      return _getPageRoute(const ResetScreen());
    case AppRoutes.profilePhoto:
      return _getPageRoute(const RegistrationUploadPhotoScreen());
    case AppRoutes.updateProfile:
      return _getPageRoute(const UpdateProfileScreen());
    case AppRoutes.otpVerify:
      return _getPageRoute(const OTPVerificationScreen());
    case AppRoutes.documentScreen:
      return _getPageRoute(const RegistrationDocumentScreen());
    case AppRoutes.timelinePost:
      return _getPageRoute(const TimelinePostScreen());
    case AppRoutes.members:
      return _getPageRoute(MembersScreen());
    case AppRoutes.oddsters:
      return _getPageRoute(OddstersScreen());
    case AppRoutes.oddboxes:
      return _getPageRoute(OddsboxScreen());
    case AppRoutes.onboard:
      return _getPageRoute(const OnboardingScreen());
    case AppRoutes.splash:
      return _getPageRoute(const SplashScreen());
    case AppRoutes.report:
      return _getPageRoute(const ReportScreen());
    case AppRoutes.settings:
      return _getPageRoute(SettingsScreen());
    case AppRoutes.livescore:
      return _getPageRoute(LiveScoreScreen());
    case AppRoutes.p2pBettingHistory:
      return _getPageRoute(const P2PBettingHistoryScreen());
    case AppRoutes.p2pBetting:
      return _getPageRoute(const P2PBettingScreen());
    case AppRoutes.p2pSuccess:
      return _getPageRoute(const P2PBettingCongratScreen());
    case AppRoutes.timeline:
      return _getPageRoute(TimelineScreen());
    case AppRoutes.updates:
      return _getPageRoute(const LargeUdpateScreen());
    case AppRoutes.referral:
      return _getPageRoute(ReferralScreen());
    case AppRoutes.base:
      return _getPageRoute(const BaseScreen());
    case AppRoutes.responsiveLayout:
      return _getPageRoute(const ResponsiveLayout());
    default:
      return _getPageRoute(const LargeTimelineScreen());
  }
}

PageRoute<Widget> _getPageRoute(Widget child) {
  return MaterialPageRoute<Widget>(builder: (BuildContext context) => child);
}
