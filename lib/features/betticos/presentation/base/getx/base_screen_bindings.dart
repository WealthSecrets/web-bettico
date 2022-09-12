import 'package:betticos/features/betticos/domain/usecases/follow/get_my_followers.dart';
import 'package:betticos/features/betticos/domain/usecases/follow/get_my_followings.dart';
import 'package:betticos/features/betticos/domain/usecases/load_token.dart';
import 'package:betticos/features/p2p_betting/domain/usecases/bet/update_user_bonus.dart';
import 'package:get/get.dart';

import '/features/auth/domain/usecases/logout_user.dart';
import '/features/betticos/domain/usecases/load_user.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';

// class BaseBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put<BaseScreenController>(
//       BaseScreenController(
//         loadUser: LoadUser(
//           authRepository: Get.find(),
//         ),
//         loadToken: LoadToken(
//           authRepository: Get.find(),
//         ),
//         logoutUser: LogoutUser(
//           authRepository: Get.find(),
//         ),
//         getMyFollowers: GetMyFollowers(
//           betticosRepository: Get.find(),
//         ),
//         getMyFollowings: GetMyFollowings(
//           betticosRepository: Get.find(),
//         ),
//       ),
//       permanent: true,
//     );
//   }
// }

class BaseBindings {
  static void dependencies() {
    Get.put<BaseScreenController>(
      BaseScreenController(
        loadUser: LoadUser(
          authRepository: Get.find(),
        ),
        loadToken: LoadToken(
          authRepository: Get.find(),
        ),
        logoutUser: LogoutUser(
          authRepository: Get.find(),
        ),
        getMyFollowers: GetMyFollowers(
          betticosRepository: Get.find(),
        ),
        getMyFollowings: GetMyFollowings(
          betticosRepository: Get.find(),
        ),
        updateUserBonus: UpdateUserBonus(
          p2prepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
