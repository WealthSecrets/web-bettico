import 'package:get/get.dart';

import '../../../domain/usecases/reset_password.dart';
import 'reset_controller.dart';

// class ResetBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ResetController>(
//       () => ResetController(
//         resetPassword: ResetPassword(
//           authRepository: Get.find(),
//         ),
//       ),
//     );
//   }
// }

class ResetBindings {
  static void dependencies() {
    Get.lazyPut<ResetController>(
      () => ResetController(
        resetPassword: ResetPassword(
          authRepository: Get.find(),
        ),
      ),
    );
  }
}
