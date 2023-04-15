import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/onboarding_splash/domain/usecases/get_onboard.dart';
import '/features/onboarding_splash/domain/usecases/save_onboard.dart';

class OnboardController extends GetxController {
  OnboardController({
    required this.saveOnBaord,
    required this.getOnBoard,
  });
  final SaveOnBaord saveOnBaord;
  final GetOnBoard getOnBoard;

  RxInt currentIndex = 0.obs;

  void saveOnBoarded() async {
    final Either<Failure, void> failureOrIsDark = await saveOnBaord(NoParams());
    failureOrIsDark.fold((Failure failure) {}, (_) {
      navigationController.navigateTo('/login');
    });
  }
}
