import 'package:betticos/features/betticos/domain/usecases/post/delete_post.dart';
import 'package:betticos/features/betticos/domain/usecases/post/dislike_post.dart';
import 'package:betticos/features/betticos/domain/usecases/post/like_post.dart';
import 'package:betticos/features/betticos/domain/usecases/subscription/fetch_subscribed_oddboxes.dart';
import 'package:get/get.dart';
import '/features/betticos/domain/usecases/feeling/add_feeling.dart';
import '/features/betticos/domain/usecases/post/add_post.dart';
import '/features/betticos/domain/usecases/post/fetch_following_posts.dart';
import '/features/betticos/domain/usecases/post/fetch_paginated_posts.dart';
import '/features/betticos/domain/usecases/post/fetch_post_comments.dart';
import '/features/betticos/domain/usecases/post/update_post.dart';
import '/features/betticos/domain/usecases/reply/add_reply.dart';
import '/features/betticos/presentation/timeline/getx/timeline_controller.dart';

class TimelineBindings {
  static void dependencies() {
    Get.put<TimelineController>(
      TimelineController(
        addPost: AddPost(
          betticosRepository: Get.find(),
        ),
        fetchSubscribedOddboxes: FetchSubscribedOddboxes(
          betticosRepository: Get.find(),
        ),
        likePost: LikePost(
          betticosRepository: Get.find(),
        ),
        dislikePost: DislikePost(
          betticosRepository: Get.find(),
        ),
        fetchFollowingPosts: FetchFollowingPosts(
          betticosRepository: Get.find(),
        ),
        fetchPostComments: FetchPostComments(
          betticosRepository: Get.find(),
        ),
        addFeeling: AddFeeling(
          betticosRepository: Get.find(),
        ),
        addReply: AddReply(
          betticosRepository: Get.find(),
        ),
        updatePost: UpdatePost(
          betticosRepository: Get.find(),
        ),
        fetchPaginatedPosts: FetchPaginatedPosts(
          betticosRepository: Get.find(),
        ),
        // notificationService: NotificationService(),
        deletePost: DeletePost(
          betticosRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
