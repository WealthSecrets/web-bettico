import 'package:betticos/features/auth/domain/usecases/update_user_role.dart';
import 'package:betticos/features/auth/domain/usecases/verify_user.dart';
import 'package:get/get.dart';

import '/features/auth/domain/usecases/register_user.dart';
import '/features/auth/domain/usecases/send_sms.dart';
import '/features/auth/domain/usecases/update_profile.dart';
import '/features/auth/domain/usecases/update_user_profile_photo.dart';
import '/features/auth/domain/usecases/upload_identification.dart';
import '/features/auth/domain/usecases/verify_email.dart';
import '/features/auth/domain/usecases/verify_sms.dart';
import '/features/auth/presentation/register/getx/register_controller.dart';

// class RegisterBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<RegisterController>(
//       () => RegisterController(
//         registerUser: RegisterUser(
//           authRepository: Get.find(),
//         ),
//         sendSms: SendSms(
//           authRepository: Get.find(),
//         ),
//         verifySms: VerifySms(
//           authRepository: Get.find(),
//         ),
//         verifyEmail: VerifyEmail(
//           authRepository: Get.find(),
//         ),
//         updateProfile: UpdateProfile(
//           authRepository: Get.find(),
//         ),
//         uploadIdentifcation: UploadIdentifcation(
//           authRepository: Get.find(),
//         ),
//         updateUserProfilePhoto: UpdateUserProfilePhoto(
//           authRepository: Get.find(),
//         ),
//         updateUserRole: UpdateUserRole(
//           authRepository: Get.find(),
//         ),
//       ),
//     );
//   }
// }

class RegisterBindings {
  static void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        registerUser: RegisterUser(
          authRepository: Get.find(),
        ),
        sendSms: SendSms(
          authRepository: Get.find(),
        ),
        verifySms: VerifySms(
          authRepository: Get.find(),
        ),
        verifyEmail: VerifyEmail(
          authRepository: Get.find(),
        ),
        updateProfile: UpdateProfile(
          authRepository: Get.find(),
        ),
        uploadIdentifcation: UploadIdentifcation(
          authRepository: Get.find(),
        ),
        updateUserProfilePhoto: UpdateUserProfilePhoto(
          authRepository: Get.find(),
        ),
        updateUserRole: UpdateUserRole(
          authRepository: Get.find(),
        ),
        verifyUser: VerifyUser(
          authRepository: Get.find(),
        ),
      ),
    );
  }
}
