import 'package:get/get.dart';

import '/features/betticos/domain/usecases/subscription/get_my_members.dart';
import '/features/betticos/presentation/members/getx/members_controller.dart';

class MembersBindings {
  static void dependencies() {
    Get.put<MembersController>(
      MembersController(
        getMyMembers: GetMyMembers(
          betticosRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
