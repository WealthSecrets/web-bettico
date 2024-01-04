import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:get/get.dart';

class RegisterBindings {
  static void dependencies() {
    Get.put(
      RegisterController(
        registerUser: RegisterUser(authRepository: Get.find()),
        sendSms: SendSms(authRepository: Get.find()),
        verifySms: VerifySms(authRepository: Get.find()),
        verifyEmail: VerifyEmail(authRepository: Get.find()),
        updateProfile: UpdateProfile(authRepository: Get.find()),
        uploadIdentifcation: UploadIdentifcation(authRepository: Get.find()),
        updateUserProfilePhoto: UpdateUserProfilePhoto(authRepository: Get.find()),
        updateUserRole: UpdateUserRole(authRepository: Get.find()),
        verifyUser: VerifyUser(authRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
