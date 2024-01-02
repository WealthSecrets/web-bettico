import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'base_screen_controller.dart';

class BaseBindings {
  static void dependencies() {
    Get.put<BaseScreenController>(
      BaseScreenController(
        loadUser: LoadUser(authRepository: Get.find()),
        loadToken: LoadToken(authRepository: Get.find()),
        logoutUser: LogoutUser(authRepository: Get.find()),
        getMyFollowers: GetMyFollowers(betticosRepository: Get.find()),
        getMyFollowings: GetMyFollowings(betticosRepository: Get.find()),
        updateUserBonus: UpdateUserBonus(p2prepository: Get.find()),
        updateUserDevice: UpdateUserDevice(betticosRepository: Get.find()),
        getSetup: GetSetup(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
