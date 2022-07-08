import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:betticos/features/responsiveness/responsive_layout.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/errors/failure.dart';
import '/core/presentation/routes/app_routes.dart';
import '/core/usecase/usecase.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/auth/domain/usecases/is_authenticated.dart';
import '/features/auth/domain/usecases/validate_session.dart';
import '/features/onboarding_splash/domain/usecases/get_onboard.dart';
import '../../../../../core/presentation/helpers/responsiveness.dart';

class SplashController extends GetxController {
  SplashController({
    required this.getOnBoard,
    required this.validateSession,
    required this.isAuthenticated,
  });

  static SplashController instance = Get.find();

  final GetOnBoard getOnBoard;
  final ValidateSession validateSession;
  final IsAuthenticated isAuthenticated;

  RxBool isLoggedIn = false.obs;

  // @override
  // void onInit() {
  //   Future<void>.delayed(const Duration(seconds: 1), () {
  //     validateOnBoard();
  //   });

  //   super.onInit();
  // }

  void validateOnBoard(BuildContext context) async {
    await Get.updateLocale(const Locale('en', 'US'));
    final Either<Failure, bool> failureOrOnboarded =
        await getOnBoard(NoParams());
    failureOrOnboarded.fold((Failure failure) {
      debugPrint('Inside :validateOnBoard: method failed');
      navigationController.navigateTo(AppRoutes.onboard);
      Get.offAll<void>(webNavigator());
    }, (bool isOnboarded) {
      debugPrint('Inside :validateOnBoard: method passed');
      isUserAuthenticated(context);
    });
  }

  void isUserAuthenticated(BuildContext context) async {
    final Either<Failure, bool> failureOrUser =
        await isAuthenticated(NoParams());

    failureOrUser.fold((Failure failure) {
      debugPrint('Inside :isUserAuthenticated: method failed');
      navigationController.navigateTo(AppRoutes.login);
      Get.offAll<void>(webNavigator());
    }, (bool respone) {
      debugPrint('Inside :isUserAuthenticated: method passed');
      if (respone) {
        validateUserSession(context);
      } else {
        navigationController.navigateTo(AppRoutes.login);
        Get.offAll<void>(webNavigator());
      }
    });
  }

  void validateUserSession(BuildContext context) async {
    final Either<Failure, User> failureOrUser =
        await validateSession(NoParams());

    failureOrUser.fold((Failure failure) {
      debugPrint('Inside :validateUserSession: method failed');
      navigationController.navigateTo(AppRoutes.login);
      Get.offAll<void>(webNavigator());
    }, (User user) {
      if (ResponsiveWidget.isSmallScreen(context)) {
        navigationController.navigateTo(AppRoutes.base);
        Get.offAll<void>(webNavigator());
      } else {
        // navigationController.navigateTo(AppRoutes.responsiveLayout);

        Get.offAll<void>(const ResponsiveLayout());
        navigationController.navigateTo(AppRoutes.timeline);
        menuController.changeActiveItemTo(AppRoutes.timeline);
      }
    });
  }
}
