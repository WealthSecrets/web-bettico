import 'package:betticos/features/auth/domain/usecases/login_user_wallet.dart';
import 'package:betticos/features/auth/domain/usecases/resend_email.dart';
import 'package:betticos/features/auth/domain/usecases/send_sms.dart';
import 'package:get/get.dart';

import '/features/auth/domain/usecases/login_user.dart';
import 'login_controller.dart';

class LoginBindings {
  static void dependencies() {
    Get.put<LoginController>(
      LoginController(
        loginUser: LoginUser(
          authRepository: Get.find(),
        ),
        loginUserWallet: LoginUserWallet(
          authRepository: Get.find(),
        ),
        resendEmail: ResendEmail(
          authRepository: Get.find(),
        ),
        sendSms: SendSms(
          authRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
