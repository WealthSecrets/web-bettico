import 'package:get/get.dart';

import '../../../domain/usecases/forgot_password.dart';
import 'forgot_controller.dart';

class ForgotBindings {
  static void dependencies() {
    Get.put<ForgotController>(
      ForgotController(
        forgotPassword: ForgotPassword(
          authRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
