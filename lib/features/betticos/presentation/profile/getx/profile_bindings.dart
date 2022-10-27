import 'package:betticos/features/betticos/domain/usecases/post/dislike_post.dart';
import 'package:betticos/features/betticos/domain/usecases/post/fetch_my_oddboxes.dart';
import 'package:betticos/features/betticos/domain/usecases/post/fetch_my_posts.dart';
import 'package:betticos/features/betticos/domain/usecases/post/like_post.dart';
import 'package:betticos/features/betticos/domain/usecases/resolve_user.dart';
import 'package:get/get.dart';

import '/features/auth/domain/usecases/update_user_profile_photo.dart';
import '/features/betticos/domain/usecases/follow/check_following.dart';
import '/features/betticos/domain/usecases/follow/follow_user.dart';
import '/features/betticos/domain/usecases/follow/get_my_followers.dart';
import '/features/betticos/domain/usecases/follow/get_my_followings.dart';
import '/features/betticos/domain/usecases/follow/unfollow_user.dart';
import '/features/betticos/domain/usecases/subscription/check_subscription.dart';
import '/features/betticos/domain/usecases/subscription/subscribe_to_user.dart';
import '../../../domain/usecases/update_user.dart';
import 'profile_controller.dart';

class ProfileBindings {
  static void dependencies() {
    Get.put<ProfileController>(
      ProfileController(
        updateUser: UpdateUser(
          authRepository: Get.find(),
        ),
        resolveUser: ResolveUser(
          betticosRepository: Get.find(),
        ),
        updateUserProfilePhoto: UpdateUserProfilePhoto(
          authRepository: Get.find(),
        ),
        followUser: FollowUser(
          betticosRepository: Get.find(),
        ),
        subscribeToUser: SubscribeToUser(
          betticosRepository: Get.find(),
        ),
        unfollowUser: UnfollowerUser(
          betticosRepository: Get.find(),
        ),
        getMyFollowers: GetMyFollowers(
          betticosRepository: Get.find(),
        ),
        getMyFollowings: GetMyFollowings(
          betticosRepository: Get.find(),
        ),
        checkSubscription: CheckSubscription(
          betticosRepository: Get.find(),
        ),
        checkFollowing: CheckFollowing(
          betticosRepository: Get.find(),
        ),
        fetchMyOddboxes: FetchMyOddboxes(
          betticosRepository: Get.find(),
        ),
        fetchMyPosts: FetchMyPosts(
          betticosRepository: Get.find(),
        ),
        likePost: LikePost(
          betticosRepository: Get.find(),
        ),
        dislikePost: DislikePost(
          betticosRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
