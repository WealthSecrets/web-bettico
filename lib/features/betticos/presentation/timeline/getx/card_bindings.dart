import 'package:betticos/features/betticos/domain/usecases/post/delete_post.dart';
import 'package:get/get.dart';

import '/features/betticos/domain/usecases/block_user.dart';
import '/features/betticos/presentation/timeline/getx/card_controller.dart';

class CardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<CardController>(
      CardController(
        blockUser: BlockUser(
          betticosRepository: Get.find(),
        ),
        deletePost: DeletePost(
          betticosRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
