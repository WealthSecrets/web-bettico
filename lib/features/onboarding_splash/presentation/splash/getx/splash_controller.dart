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

  RxString device = ''.obs;

  void isUserAuthenticated(BuildContext context) async {
    final Either<Failure, bool> failureOrUser =
        await isAuthenticated(NoParams());

    failureOrUser.fold((Failure failure) {
      Get.offAllNamed<void>(AppRoutes.login);
      menuController.changeActiveItemTo(AppRoutes.timeline);
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
