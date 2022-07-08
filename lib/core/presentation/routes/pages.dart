import 'package:betticos/features/auth/presentation/register/screens/registration_account_type_screen.dart';
// import 'package:betticos/features/betticos/presentation/report/getx/report_bindings.dart';
import 'package:betticos/features/betticos/presentation/report/screens/report_screen.dart';
// import 'package:betticos/features/betticos/presentation/timeline/getx/card_bindings.dart';
// import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_bindings.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/livescore_screen.dart';
// import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_binding.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_history_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
// import 'package:betticos/features/settings/presentation/settings/getx/settings_bindings.dart';
import 'package:betticos/features/settings/presentation/settings/screens/settings_screen.dart';
import 'package:get/get.dart';

import '/core/presentation/routes/app_routes.dart';
// import '/features/auth/presentation/forgotPassword/getx/forgot_bindings.dart';
// import '/features/auth/presentation/login/getx/login_bindings.dart';
import '/features/auth/presentation/login/screens/login_screen.dart';
// import '/features/auth/presentation/register/getx/register_bindings.dart';
import '/features/auth/presentation/register/screens/otp_verification_screen.dart';
import '/features/auth/presentation/register/screens/registratino_personal_information_screen.dart';
import '/features/auth/presentation/register/screens/registration_document_screen.dart';
import '/features/auth/presentation/register/screens/registration_screen.dart';
import '/features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
// import '/features/auth/presentation/resetPassword/getx/reset_bindings.dart';
import '/features/auth/presentation/resetPassword/screens/reset_screen.dart';
// import '/features/betticos/presentation/base/getx/base_screen_bindings.dart';
import '/features/betticos/presentation/base/screens/base_screen.dart';
// import '/features/betticos/presentation/members/getx/members_bindings.dart';
import '/features/betticos/presentation/members/screens/members_screen.dart';
import '/features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
// import '/features/betticos/presentation/oddsters/getx/oddsters_bindings.dart';
// import '/features/betticos/presentation/profile/getx/profile_bindings.dart';
import '/features/betticos/presentation/profile/screens/profile_screen.dart';
import '/features/betticos/presentation/profile/screens/update_profile_screen.dart';
// import '/features/betticos/presentation/timeline/getx/timeline_bindings.dart';
import '/features/betticos/presentation/timeline/screens/timeline_post_screen.dart';
// import '/features/onboarding_splash/presentation/onbaording/getx/onboard_bindings.dart';
import '/features/onboarding_splash/presentation/onbaording/screens/onboarding_screen.dart';
// import '/features/onboarding_splash/presentation/splash/getx/splash_bindings.dart';
import '/features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
// import '/main_bindings.dart';
import '../../../features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
// import '../../../features/betticos/presentation/referral/getx/referral_bindings.dart';
import '../../../features/responsiveness/responsive_layout.dart';
import '../../../features/responsiveness/test_page.dart';

class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.base,
      page: () => const BaseScreen(),
      // bindings: <Bindings>[
      // MainBindings(),
      // SettingsBindings(),
      // BaseBindings(),
      // ProfileBindings(),
      // TimelineBindings(),
      // MembersBindings(),
      // OddstersBindings(),
      // ReferralBindings(),
      // CardBindings(),
      // ReportBindings(),
      // LiveScoreBindings(),
      // P2PBetBindings(),
      // ],
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      // binding: ProfileBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      // bindings: <Bindings>[
      // MainBindings(),
      // BaseBindings(),
      // LoginBindings(),
      // RegisterBindings(),
      // ],
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.registration,
      page: () => const RegistrationScreen(),
      // binding: RegisterBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.personalInformation,
      page: () => const RegistrationPersonalInformationScreen(),
      // bindings: <Bindings>[RegisterBindings(), LoginBindings()],
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.accountType,
      page: () => const RegistrationAccountTypeScreen(),
      // binding: RegisterBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.forgot,
      page: () => const ForgotPasswordScreen(),
      // binding: ForgotBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.reset,
      page: () => const ResetScreen(),
      // binding: ResetBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.profilePhoto,
      page: () => const RegistrationUploadPhotoScreen(),
      // binding: RegisterBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.updateProfile,
      page: () => const UpdateProfileScreen(),
      // binding: ProfileBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.otpVerify,
      page: () => const OTPVerificationScreen(),
      // binding: LoginBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.documentScreen,
      page: () => const RegistrationDocumentScreen(),
      // bindings: <Bindings>[RegisterBindings(), LoginBindings()],
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.timelinePost,
      page: () => const TimelinePostScreen(),
      // binding: TimelineBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.members,
      page: () => MembersScreen(),
      // binding: MembersBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.oddboxes,
      page: () => OddsboxScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.onboard,
      page: () => const OnboardingScreen(),
      // binding: OnBoardBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      // bindings: <Bindings>[SettingsBindings(), SplashBindings()],
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.testPage,
      page: () => const TestPage(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.responsiveLayout,
      page: () => const ResponsiveLayout(),
      // bindings: <Bindings>[
      // MainBindings(),
      // SplashBindings(),
      // SettingsBindings(),
      // BaseBindings(),
      // ProfileBindings(),
      // TimelineBindings(),
      // MembersBindings(),
      // OddstersBindings(),
      // ReferralBindings(),
      // CardBindings(),
      // ReportBindings(),
      // LiveScoreBindings(),
      // P2PBetBindings(),
      // ],
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.report,
      page: () => const ReportScreen(),
      // binding: ReportBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.settings,
      page: () => SettingsScreen(),
      // binding: SettingsBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.livescore,
      page: () => LiveScoreScreen(),
      // binding: LiveScoreBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.p2pBettingHistory,
      page: () => const P2PBettingHistoryScreen(),
      // binding: P2PBetBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.p2pBetting,
      page: () => const P2PBettingScreen(),
      // binding: P2PBetBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.p2pSuccess,
      page: () => const P2PBettingCongratScreen(),
    ),
  ];
}
