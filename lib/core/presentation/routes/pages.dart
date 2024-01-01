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
import 'package:betticos/features/presentation.dart';
import 'package:get/get.dart';

class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.login,
      page: LoginScreen.new,
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.registration,
      page: RegistrationScreen.new,
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.accountType,
      page: RegistrationAccountTypeScreen.new,
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.forgot,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.reset,
      page: ResetScreen.new,
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
      page: RegistrationDocumentScreen.new,
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.timelinePost,
      page: () => const TimelinePostScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.walletConnect,
      page: ForgotWalletScreen.new,
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.livescore,
      page: () => const NewLiveScore(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.addressConnect,
      page: RegistrationWalletScreen.new,
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.personalInformation,
      page: () => const RegistrationPersonalInformationScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.home,
      page: () => const HomeBaseScreen(),
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
    GetPage<AppRoutes>(
      name: AppRoutes.professionalCategory,
      page: () => const ProfessionalAccountCategoryScreen(),
    ),
  ];
}
