// import 'package:betticos/common/common.dart';
// import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

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
      Get.back();
      // navigationController.navigateTo(AppRoutes.professionalCategory);
    });
  }
}
