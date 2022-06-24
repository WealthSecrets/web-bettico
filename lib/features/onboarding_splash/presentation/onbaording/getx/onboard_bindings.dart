import 'package:get/get.dart';

import '/features/onboarding_splash/domain/usecases/get_onboard.dart';
import '/features/onboarding_splash/domain/usecases/save_onboard.dart';
import '/features/onboarding_splash/presentation/onbaording/getx/onboard_controller.dart';

// class OnBoardBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(
//       () => OnboardController(
//         saveOnBaord: SaveOnBaord(
//           onBoardRepository: Get.find(),
//         ),
//         getOnBoard: GetOnBoard(
//           onBoardRepository: Get.find(),
//         ),
//       ),
//     );
//   }
// }

class OnBoardBindings {
  static void dependencies() {
    Get.lazyPut(
      () => OnboardController(
        saveOnBaord: SaveOnBaord(
          onBoardRepository: Get.find(),
        ),
        getOnBoard: GetOnBoard(
          onBoardRepository: Get.find(),
        ),
      ),
    );
  }
}
