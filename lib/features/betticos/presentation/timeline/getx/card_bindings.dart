import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';

import 'card_controller.dart';

class CardBindings {
  static void dependencies() {
    Get.put<CardController>(
      CardController(
        blockUser: BlockUser(betticosRepository: Get.find()),
        deletePost: DeletePost(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
