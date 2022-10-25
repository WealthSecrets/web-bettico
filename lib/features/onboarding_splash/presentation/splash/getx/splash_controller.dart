import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
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

class SplashController extends GetxController {
  SplashController({
    required this.getOnBoard,
    required this.validateSession,
    required this.isAuthenticated,
  });

  final GetOnBoard getOnBoard;
  final ValidateSession validateSession;
  final IsAuthenticated isAuthenticated;

  RxBool isLoggedIn = false.obs;

  // Onboarding code commented for the web

  // void validateOnBoard(BuildContext context) async {
  //   await Get.updateLocale(const Locale('en', 'US'));
  //   final Either<Failure, bool> failureOrOnboarded =
  //       await getOnBoard(NoParams());
  //   failureOrOnboarded.fold((Failure failure) {
  //     debugPrint('Inside :validateOnBoard: method failed');
  //     navigationController.navigateTo(AppRoutes.onboard);
  //   }, (bool isOnboarded) {
  //     debugPrint('Inside :validateOnBoard: method passed');
  //     isUserAuthenticated(context);
  //   });
  // }

  void isUserAuthenticated(BuildContext context) async {
    debugPrint('isUserAuthenticated called');
    final Either<Failure, bool> failureOrUser =
        await isAuthenticated(NoParams());

    failureOrUser.fold((Failure failure) {
      navigationController.navigateTo(AppRoutes.login);
      Get.offAll<void>(webNavigator());
    }, (bool respone) {
      if (respone) {
        validateUserSession(context);
      } else {
        Get.offAllNamed<void>(AppRoutes.login);
        menuController.changeActiveItemTo(AppRoutes.timeline);
      }
    });
  }

  void validateUserSession(BuildContext context) async {
    final Either<Failure, User> failureOrUser =
        await validateSession(NoParams());

    failureOrUser.fold((Failure failure) {
      Get.offAllNamed<void>(AppRoutes.login);
      menuController.changeActiveItemTo(AppRoutes.timeline);
    }, (User user) {
      Get.offAllNamed<void>(AppRoutes.home);
      menuController.changeActiveItemTo(AppRoutes.timeline);
    });
  }
}
