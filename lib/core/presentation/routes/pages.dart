import 'package:betticos/core/presentation/web_controllers/menu_bindings.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/domain/enums/otp_receiver_type.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_account_type_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import 'package:betticos/features/betticos/presentation/report/getx/report_bindings.dart';
import 'package:betticos/features/betticos/presentation/report/screens/report_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/getx/card_bindings.dart';
import 'package:betticos/features/p2p_betting/data/models/sportmonks/livescore/livescore.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_bindings.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/livescore_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_binding.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_history_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import 'package:betticos/features/settings/presentation/settings/getx/settings_bindings.dart';
import 'package:betticos/features/settings/presentation/settings/screens/settings_screen.dart';
import 'package:get/get.dart';
import '/features/auth/presentation/forgotPassword/getx/forgot_bindings.dart';
import '/features/auth/presentation/login/getx/login_bindings.dart';
import '/features/auth/presentation/login/screens/login_screen.dart';
import '/features/auth/presentation/register/getx/register_bindings.dart';
import '/features/auth/presentation/register/screens/otp_verification_screen.dart';
import '/features/auth/presentation/register/screens/registration_document_screen.dart';
import '/features/auth/presentation/register/screens/registration_screen.dart';
import '/features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
import '/features/auth/presentation/resetPassword/getx/reset_bindings.dart';
import '/features/auth/presentation/resetPassword/screens/reset_screen.dart';
import '/features/betticos/presentation/base/getx/base_screen_bindings.dart';
import '/features/betticos/presentation/base/screens/base_screen.dart';
import '/features/betticos/presentation/members/getx/members_bindings.dart';
import '/features/betticos/presentation/oddsters/getx/oddsters_bindings.dart';
import '/features/betticos/presentation/profile/getx/profile_bindings.dart';
import '/features/betticos/presentation/profile/screens/profile_screen.dart';
import '/features/betticos/presentation/profile/screens/update_profile_screen.dart';
import '/features/betticos/presentation/timeline/getx/timeline_bindings.dart';
import '/features/betticos/presentation/timeline/screens/timeline_post_screen.dart';
import '/features/onboarding_splash/presentation/onbaording/getx/onboard_bindings.dart';
import '/features/onboarding_splash/presentation/onbaording/screens/onboarding_screen.dart';
import '/features/onboarding_splash/presentation/splash/getx/splash_bindings.dart';
import '/features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
import '/main_bindings.dart';
import '../../../features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import '../../../features/betticos/presentation/referral/getx/referral_bindings.dart';
import '../../../features/responsiveness/home_base_screen.dart';

class Pages {
  static final List<GetPage<String>> pages = <GetPage<String>>[
    GetPage<String>(
      name: BaseScreen.route,
      page: () => const BaseScreen(),
      bindings: <Bindings>[
        MainBindings(),
        MenuBindings(),
        SettingsBindings(),
        BaseBindings(),
        ProfileBindings(),
        TimelineBindings(),
        MembersBindings(),
        OddstersBindings(),
        ReferralBindings(),
        CardBindings(),
        ReportBindings(),
        LiveScoreBindings(),
        P2PBetBindings(),
      ],
    ),
    GetPage<String>(
      name: ProfileScreen.route,
      page: () => ProfileScreen(),
      binding: ProfileBindings(),
    ),
    GetPage<String>(
      name: LoginScreen.route,
      page: () => LoginScreen(),
      bindings: <Bindings>[
        MainBindings(),
        BaseBindings(),
        LoginBindings(),
        RegisterBindings(),
      ],
    ),
    GetPage<String>(
      name: RegistrationScreen.route,
      page: () => const RegistrationScreen(),
      binding: RegisterBindings(),
    ),
    GetPage<String>(
      name: RegistrationPersonalInformationScreen.route,
      page: () => const RegistrationPersonalInformationScreen(),
      bindings: <Bindings>[RegisterBindings(), LoginBindings()],
    ),
    GetPage<String>(
      name: RegistrationAccountTypeScreen.route,
      page: () => const RegistrationAccountTypeScreen(),
      binding: RegisterBindings(),
    ),
    GetPage<String>(
      name: ForgotPasswordScreen.route,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotBindings(),
    ),
    GetPage<String>(
      name: ResetScreen.route,
      page: () => ResetScreen(),
      binding: ResetBindings(),
    ),
    GetPage<String>(
      name: RegistrationUploadPhotoScreen.route,
      page: () => const RegistrationUploadPhotoScreen(),
      binding: RegisterBindings(),
    ),
    GetPage<String>(
      name: UpdateProfileScreen.route,
      page: () => UpdateProfileScreen(
        user: User.empty(),
      ),
      binding: ProfileBindings(),
    ),
    GetPage<String>(
      name: OTPVerificationScreen.route,
      page: () => const OTPVerificationScreen(
        otpReceiverType: OTPReceiverType.email,
      ),
      binding: LoginBindings(),
    ),
    GetPage<String>(
      name: RegistrationDocumentScreen.route,
      page: () => RegistrationDocumentScreen(),
      bindings: <Bindings>[RegisterBindings(), LoginBindings()],
    ),
    GetPage<String>(
      name: TimelinePostScreen.route,
      page: () => const TimelinePostScreen(),
      binding: TimelineBindings(),
    ),
    GetPage<String>(
      name: OnboardingScreen.route,
      page: () => const OnboardingScreen(),
      bindings: <Bindings>[SettingsBindings(), OnBoardBindings()],
    ),
    GetPage<String>(
      name: SplashScreen.route,
      page: () => const SplashScreen(),
      bindings: <Bindings>[SettingsBindings(), SplashBindings()],
    ),
    GetPage<String>(
      name: HomeBaseScreen.route,
      page: () => const HomeBaseScreen(),
      bindings: <Bindings>[
        MainBindings(),
        SplashBindings(),
        SettingsBindings(),
        BaseBindings(),
        ProfileBindings(),
        TimelineBindings(),
        MembersBindings(),
        OddstersBindings(),
        ReferralBindings(),
        CardBindings(),
        ReportBindings(),
        LiveScoreBindings(),
        P2PBetBindings(),
      ],
    ),
    GetPage<String>(
      name: ReportScreen.route,
      page: () => const ReportScreen(),
      binding: ReportBindings(),
    ),
    GetPage<String>(
      name: SettingsScreen.route,
      page: () => SettingsScreen(),
      binding: SettingsBindings(),
    ),
    GetPage<String>(
      name: LiveScoreScreen.route,
      page: () => LiveScoreScreen(),
      binding: LiveScoreBindings(),
    ),
    GetPage<String>(
      name: P2PBettingHistoryScreen.route,
      page: () => const P2PBettingHistoryScreen(),
      binding: P2PBetBindings(),
    ),
    GetPage<String>(
      name: P2PBettingScreen.route,
      page: () => P2PBettingScreen(
        liveScore: LiveScore.empty(),
      ),
      binding: P2PBetBindings(),
    ),
    GetPage<String>(
      name: P2PBettingCongratScreen.route,
      page: () => const P2PBettingCongratScreen(),
    ),
  ];
}
