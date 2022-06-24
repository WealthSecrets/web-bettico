import 'package:get/get.dart';

import '../../../domain/usecases/forgot_password.dart';
import 'forgot_controller.dart';

// class ForgotBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ForgotController>(
//       () => ForgotController(
//         forgotPassword: ForgotPassword(
//           authRepository: Get.find(),
//         ),
//       ),
//     );
//   }
// }

class ForgotBindings {
  static void dependencies() {
    Get.lazyPut<ForgotController>(
      () => ForgotController(
        forgotPassword: ForgotPassword(
          authRepository: Get.find(),
        ),
      ),
    );
  }
}
