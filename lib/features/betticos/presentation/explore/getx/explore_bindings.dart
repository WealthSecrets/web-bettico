import 'package:betticos/features/betticos/domain/usecases/post/explore_posts.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:get/get.dart';

class ExploreBindings {
  static void dependencies() {
    Get.put<ExploreController>(
      ExploreController(
          explorePosts: ExplorePosts(betticosRepository: Get.find())),
      permanent: true,
    );
  }
}
