import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PostType { posts, oddboxes, likedPosts, bookmarks, comments }

class MyPostsScreen extends GetWidget<ProfileController> {
  MyPostsScreen({super.key, required this.userId, required this.type, this.oddbox = false});
  final PostType type;
  final String userId;
  final bool oddbox;

  final TimelineController tController = Get.find<TimelineController>();
  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final List<Post> posts = getPosts();
        final String message = getMessage();
        final bool isLoggedInUser = user.id == userId;
        return AppLoadingBox(
          loading: controller.isLoadingMyOddboxes.value ||
              controller.isLoadingMyPosts.value ||
              controller.isLoadingMyLikedPosts.value,
          child: posts.isEmpty || hideContent(isLoggedInUser)
              ? AppEmptyScreen(
                  title: hideContent(isLoggedInUser) ? 'Bookmarks Hidden' : null,
                  message: hideContent(isLoggedInUser) ? "User's bookmarks are private." : message,
                )
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
                      onRepost: () => WidgetUtils.showOptionsBottomSheet(
                        context,
                        title: 'Choose Action',
                        iconColor: context.colors.primary,
                        iconSize: 18,
                        options: <OptionArgument>[
                          OptionArgument(
                            icon: AppAssetIcons.refresh,
                            title: 'Repost',
                            onPressed: () => tController.addNewRepost(context, postId: post.id),
                          ),
                          OptionArgument(
                            icon: AppAssetIcons.editPencil,
                            title: 'Quote',
                            onPressed: () {
                              Navigator.of(context).pop();
                              tController.navigateToAddPost(context, p: post, isAreply: false);
                            },
                          ),
                        ],
                      ),
                      sponsored: post.boosted == true,
                      onBookmark: () => tController.bookmarkThePost(context, post.id),
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
        return controller.myBookmarks;
      case PostType.comments:
        return controller.myComments;
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
      case PostType.comments:
        return 'No comments were found.';
    }
  }

  bool hideContent(bool isLoggedInUser) {
    switch (type) {
      case PostType.posts:
      case PostType.oddboxes:
      case PostType.likedPosts:
      case PostType.comments:
        return false;
      case PostType.bookmarks:
        return !isLoggedInUser;
    }
  }
}
