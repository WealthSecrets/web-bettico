import 'package:betticos/common/common.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PostType { posts, oddboxes, likedPosts, bookmarks }

class MyPostsScreen extends GetWidget<ProfileController> {
  MyPostsScreen({super.key, required this.userId, required this.type, this.oddbox = false});
  final PostType type;
  final String userId;
  final bool oddbox;

  final TimelineController tController = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final List<Post> posts = getPosts();
        final String message = getMessage();
        return AppLoadingBox(
          loading: controller.isLoadingMyOddboxes.value ||
              controller.isLoadingMyPosts.value ||
              controller.isLoadingMyLikedPosts.value,
          child: posts.isEmpty
              ? AppEmptyScreen(message: message)
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Post post = posts[index];
                    return TimelineCard(
                      post: post,
                      onTap: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                        );
                      },
                      onComment: () => tController.navigateToAddPost(context, p: post, isAreply: true),
                      onLike: () {
                        if (type == PostType.posts || type == PostType.oddboxes) {
                          controller.likeThePost(context, post.id, userId, isOddbox: oddbox);
                        } else {
                          tController.likeThePost(context, post.id);
                          controller.removeFromLikedPost(post.id);
                        }
                      },
                      onDislike: () {
                        if (type == PostType.posts || type == PostType.oddboxes) {
                          controller.dislikeThePost(context, post.id, userId, isOddbox: oddbox);
                        } else {
                          tController.dislikeThePost(context, post.id);
                          controller.removeFromLikedPost(post.id);
                        }
                      },
                      sponsored: post.boosted == true,
                    );
                  },
                ),
        );
      },
    );
  }

  List<Post> getPosts() {
    switch (type) {
      case PostType.posts:
        return controller.myPosts;
      case PostType.oddboxes:
        return controller.myOddboxes;
      case PostType.likedPosts:
        return controller.myLikedPosts;
      case PostType.bookmarks:
        return controller.myLikedPosts;
    }
  }

  String getMessage() {
    switch (type) {
      case PostType.posts:
        return 'No posts were found.';
      case PostType.oddboxes:
        return 'No oddboxes were found.';
      case PostType.likedPosts:
        return 'No liked posts were found.';
      case PostType.bookmarks:
        return 'No bookmarks were found.';
    }
  }
}
