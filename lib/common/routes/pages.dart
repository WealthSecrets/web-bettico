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
    GetPage<AppRoutes>(name: AppRoutes.otpVerify, page: () => const NewOtpVerificationScreen()),
    GetPage<AppRoutes>(name: AppRoutes.documentScreen, page: RegistrationDocumentScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.timelinePost, page: () => const TimelinePostScreen()),
    GetPage<AppRoutes>(name: AppRoutes.personalInformation, page: () => const RegistrationPersonalInformationScreen()),
    GetPage<AppRoutes>(name: AppRoutes.newWelcome, page: () => const NewWelcomeScreen()),
    GetPage<AppRoutes>(name: AppRoutes.newRegistration, page: NewRegistrationScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.newPasswordScreen, page: NewPasswordScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.newUsername, page: NewUsernameScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.newProfilePhoto, page: NewPhotoUploadScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.interests, page: RegistrationInterestsScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.bio, page: RegistrationBioScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.followAccounts, page: RegistrationFollowAccountsScreen.new),
    GetPage<AppRoutes>(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage<AppRoutes>(name: AppRoutes.home, page: () => const HomeBaseScreen()),
    GetPage<AppRoutes>(name: AppRoutes.report, page: () => const ReportScreen()),
  ];
}
