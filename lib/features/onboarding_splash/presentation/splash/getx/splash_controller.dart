import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/betticos/presentation/base/screens/base_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/errors/failure.dart';
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

  void isUserAuthenticated(BuildContext context) async {
    debugPrint('isUserAuthenticated called');
    final Either<Failure, bool> failureOrUser = await isAuthenticated(NoParams());

    failureOrUser.fold((Failure failure) {
      Get.offAllNamed<void>(LoginScreen.route);
    }, (bool respone) {
      if (respone) {
        validateUserSession(context);
      } else {
        Get.offAllNamed<void>(LoginScreen.route);
      }
    });
  }

  void validateUserSession(BuildContext context) async {
    final Either<Failure, User> failureOrUser = await validateSession(NoParams());

    failureOrUser.fold((Failure failure) {
      Get.offAllNamed<void>(LoginScreen.route);
    }, (User user) {
      if (ResponsiveWidget.isSmallScreen(context)) {
        Get.offAllNamed<void>(BaseScreen.route);
      } else {
        Get.offAllNamed<void>(TimelineScreen.route);
      }
    });
  }
}
