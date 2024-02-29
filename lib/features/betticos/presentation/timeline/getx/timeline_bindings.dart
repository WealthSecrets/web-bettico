import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';
import 'timeline_controller.dart';

class TimelineBindings {
  static void dependencies() {
    Get.put<TimelineController>(
      TimelineController(
        addPost: AddPost(
          betticosRepository: Get.find(),
        ),
        fetchSubscribedOddboxes: FetchSubscribedOddboxes(betticosRepository: Get.find()),
        likePost: LikePost(betticosRepository: Get.find()),
        dislikePost: DislikePost(betticosRepository: Get.find()),
        fetchFollowingPosts: FetchFollowingPosts(betticosRepository: Get.find()),
        fetchPostComments: FetchPostComments(betticosRepository: Get.find()),
        addFeeling: AddFeeling(betticosRepository: Get.find()),
        addReply: AddReply(betticosRepository: Get.find()),
        updatePost: UpdatePost(betticosRepository: Get.find()),
        fetchPaginatedPosts: FetchPaginatedPosts(betticosRepository: Get.find()),
        deletePost: DeletePost(betticosRepository: Get.find()),
        likeRepost: LikeRepost(betticosRepository: Get.find()),
        dislikeRepost: DislikeRepost(betticosRepository: Get.find()),
        fetchPaginatedReposts: FetchPaginatedReposts(betticosRepository: Get.find()),
        addRepost: AddRepost(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
