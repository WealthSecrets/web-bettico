import 'package:betticos/features/auth/presentation/forgotPassword/screens/forgot_wallet_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/otp_verification_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_account_type_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_personal_information_screen.dart';
import 'package:betticos/features/auth/presentation/register/screens/registration_wallet_screen.dart';
import 'package:betticos/features/betticos/presentation/report/screens/report_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/livescore_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_betting_history_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_congratulations_screen.dart';
import 'package:get/get.dart';
import '/core/presentation/routes/app_routes.dart';
import '/features/auth/presentation/login/screens/login_screen.dart';
import '/features/auth/presentation/register/screens/registration_document_screen.dart';
import '/features/auth/presentation/register/screens/registration_screen.dart';
import '/features/auth/presentation/register/screens/registration_upload_photo_screen.dart';
import '/features/auth/presentation/resetPassword/screens/reset_screen.dart';
import '/features/betticos/presentation/timeline/screens/timeline_post_screen.dart';
import '/features/onboarding_splash/presentation/onbaording/screens/onboarding_screen.dart';
import '/features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
import '../../../features/auth/presentation/forgotPassword/screens/forgot_password_screen.dart';
import '../../../features/responsiveness/home_base_screen.dart';

class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.registration,
      page: () => RegistrationScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.accountType,
      page: () => RegistrationAccountTypeScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.forgot,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.reset,
      page: () => ResetScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.profilePhoto,
      page: () => const RegistrationUploadPhotoScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.otpVerify,
      page: () => const OTPVerificationScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.documentScreen,
      page: () => RegistrationDocumentScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.timelinePost,
      page: () => const TimelinePostScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.walletConnect,
      page: () => ForgotWalletScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.livescore,
      page: () => const LiveScoreScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.addressConnect,
      page: () => RegistrationWalletScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.personalInformation,
      page: () => const RegistrationPersonalInformationScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.onboard,
      page: () => const OnboardingScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.home,
      page: () => HomeBaseScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.report,
      page: () => const ReportScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.p2pBettingHistory,
      page: () => const P2PBettingHistoryScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.p2pSuccess,
      page: () => const P2PBettingCongratScreen(),
    ),
  ];
}


// Get.toNamed<void>();
// Navigator.of(context).pushNamed();
