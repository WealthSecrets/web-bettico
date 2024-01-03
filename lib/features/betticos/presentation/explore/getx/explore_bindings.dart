import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';
import 'explore_controller.dart';

class ExploreBindings {
  static void dependencies() {
    Get.put<ExploreController>(
      ExploreController(
        explorePosts: ExplorePosts(betticosRepository: Get.find()),
        fetchHashtags: FetchHashtags(betticosRepository: Get.find()),
        searchPosts: SearchPosts(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
