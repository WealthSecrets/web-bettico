import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final Either<Failure, bool> failureOrUser = await isAuthenticated(NoParams());

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
    final Either<Failure, User> failureOrUser = await validateSession(NoParams());

    failureOrUser.fold((Failure failure) {
      Get.offAllNamed<void>(AppRoutes.login);
      menuController.changeActiveItemTo(AppRoutes.timeline);
    }, (User user) {
      Get.offAllNamed<void>(AppRoutes.home);
      menuController.changeActiveItemTo(AppRoutes.timeline);
    });
  }
}
