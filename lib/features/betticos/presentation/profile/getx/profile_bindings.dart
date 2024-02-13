import 'package:betticos/features/domain.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileBindings {
  static void dependencies() {
    Get.put<ProfileController>(
      ProfileController(
        updateUser: UpdateUser(authRepository: Get.find()),
        resolveUser: ResolveUser(betticosRepository: Get.find()),
        updateUserProfilePhoto: UpdateUserProfilePhoto(authRepository: Get.find()),
        followUser: FollowUser(betticosRepository: Get.find()),
        subscribeToUser: SubscribeToUser(betticosRepository: Get.find()),
        unfollowUser: UnfollowerUser(betticosRepository: Get.find()),
        getMyFollowers: GetMyFollowers(betticosRepository: Get.find()),
        getMyFollowings: GetMyFollowings(betticosRepository: Get.find()),
        checkSubscription: CheckSubscription(betticosRepository: Get.find()),
        checkFollowing: CheckFollowing(betticosRepository: Get.find()),
        fetchMyOddboxes: FetchMyOddboxes(betticosRepository: Get.find()),
        fetchMyPosts: FetchMyPosts(betticosRepository: Get.find()),
        likePost: LikePost(betticosRepository: Get.find()),
        dislikePost: DislikePost(betticosRepository: Get.find()),
        fetchMyLikedPosts: FetchMyLikedPosts(betticosRepository: Get.find()),
        fetchUserReposts: FetchUserReposts(betticosRepository: Get.find()),
      ),
      permanent: true,
    );
  }
}
