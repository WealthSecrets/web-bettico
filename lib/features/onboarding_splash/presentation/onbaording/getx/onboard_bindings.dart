import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:get/get.dart';

class OnBoardBindings {
  static void dependencies() {
    Get.lazyPut(
      () => OnboardController(
        saveOnBaord: SaveOnBaord(onBoardRepository: Get.find()),
        getOnBoard: GetOnBoard(onBoardRepository: Get.find()),
      ),
    );
  }
}
