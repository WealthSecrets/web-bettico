import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:get/get.dart';

class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(name: AppRoutes.login, page: LoginScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.registration, page: RegistrationScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.accountType, page: RegistrationAccountTypeScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.forgot, page: () => const ForgotPasswordScreen()),
    GetPage<AppRoutes>(name: AppRoutes.reset, page: ResetScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.profilePhoto, page: () => const RegistrationUploadPhotoScreen()),
    GetPage<AppRoutes>(name: AppRoutes.otpVerify, page: () => const OTPVerificationScreen()),
    GetPage<AppRoutes>(name: AppRoutes.documentScreen, page: RegistrationDocumentScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.timelinePost, page: () => const TimelinePostScreen()),
    GetPage<AppRoutes>(name: AppRoutes.personalInformation, page: () => const RegistrationPersonalInformationScreen()),
    GetPage<AppRoutes>(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage<AppRoutes>(name: AppRoutes.home, page: () => const HomeBaseScreen()),
    GetPage<AppRoutes>(name: AppRoutes.report, page: () => const ReportScreen()),
  ];
}
