import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'members_controller.dart';

class MembersBindings {
  static void dependencies() {
    Get.put<MembersController>(
      MembersController(getMyMembers: GetMyMembers(betticosRepository: Get.find())),
      permanent: true,
    );
  }
}
