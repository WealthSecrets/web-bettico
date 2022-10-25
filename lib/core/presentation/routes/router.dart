import 'package:betticos/features/auth/presentation/register/arguments/otp_verification_argument.dart';
import 'package:betticos/features/auth/presentation/register/arguments/user_argument.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_wallet_screen.dart';
import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/new_livescore_screen.dart';
import 'package:betticos/features/responsiveness/not_found_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/forgotPassword/screens/forgot_wallet_screen.dart';
import '../../../features/auth/presentation/register/screens/otp_verification_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_account_type_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_document_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_screen.dart';
import '../../../features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
import '../../../features/auth/presentation/resetPassword/screens/reset_screen.dart';
import '../../../features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import '../../../features/betticos/presentation/profile/screens/profile_screen.dart';
import '../../../features/betticos/presentation/report/screens/report_screen.dart';
import '../../../features/betticos/presentation/timeline/screens/timeline_post_screen.dart';
import '../../../features/onboarding_splash/presentation/onbaording/screens/onboarding_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_history_screen.dart';
import '../../../features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.profile:
      return _getPageRoute(const ProfileScreen(), settings);
    case AppRoutes.registration:
      return _getPageRoute(RegistrationScreen(), settings);
    case AppRoutes.personalInformation:
      final UserArgument? args = settings.arguments as UserArgument?;
      return _getPageRoute(
          RegistrationPersonalInformationScreen(
            user: args?.user,
          ),
          settings);
    case AppRoutes.accountType:
      return _getPageRoute(RegistrationAccountTypeScreen(), settings);
    case AppRoutes.walletConnect:
      return _getPageRoute(ForgotWalletScreen(), settings);
    case AppRoutes.addressConnect:
      return _getPageRoute(RegistrationWalletScreen(), settings);
    case AppRoutes.forgot:
      return _getPageRoute(const ForgotPasswordScreen(), settings);
    case AppRoutes.reset:
      return _getPageRoute(ResetScreen(), settings);
    case AppRoutes.profilePhoto:
      return _getPageRoute(const RegistrationUploadPhotoScreen(), settings);
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
      return _getPageRoute(const MembersScreen(), settings);
    case AppRoutes.oddsters:
      return _getPageRoute(const OddstersScreen(), settings);
    case AppRoutes.oddboxes:
      return _getPageRoute(const OddsboxScreen(), settings);
    case AppRoutes.onboard:
      return _getPageRoute(const OnboardingScreen(), settings);
    // case AppRoutes.splash:
    //   return _getPageRoute(const SplashScreen(), settings);
    case AppRoutes.report:
      return _getPageRoute(const ReportScreen(), settings);
    case AppRoutes.settings:
      return _getPageRoute(const SettingsScreen(), settings);
    case AppRoutes.livescore:
      return _getPageRoute(const NewLiveScore(), settings);
    case AppRoutes.p2pBettingHistory:
      return _getPageRoute(const P2PBettingHistoryScreen(), settings);
    case AppRoutes.p2pSuccess:
      return _getPageRoute(const P2PBettingCongratScreen(), settings);
    case AppRoutes.timeline:
      return _getPageRoute(const TimelineScreen(), settings);
    case AppRoutes.referral:
      return _getPageRoute(const ReferralScreen(), settings);
    default:
      debugPrint('Checking the route name: ${settings.name}');
      return _getPageRoute(const NotFoundScreen(), settings);
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
