import 'package:betticos/common/common.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostsScreen extends GetWidget<ProfileController> {
  MyPostsScreen({super.key, required this.userId, this.isOddboxes = false});
  final bool isOddboxes;
  final String userId;

  final TimelineController tController = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoadingMyOddboxes.value || controller.isLoadingMyPosts.value,
        child: (isOddboxes ? controller.myOddboxes.isEmpty : controller.myPosts.isEmpty)
            ? AppEmptyScreen(message: isOddboxes ? 'no_oddboxes'.tr : 'no_posts'.tr)
            : ListView.builder(
                itemCount: isOddboxes ? controller.myOddboxes.length : controller.myPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  final Post post = isOddboxes ? controller.myOddboxes[index] : controller.myPosts[index];
                  return TimelineCard(
                    post: post,
                    onTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                      );
                    },
                    onCommentTap: () => tController.navigateToAddPost(context, pstId: post.id),
                    onLikeTap: () => controller.likeThePost(context, post.id, userId, isOddbox: isOddboxes),
                    onDislikeTap: () => controller.dislikeThePost(context, post.id, userId, isOddbox: isOddboxes),
                    sponsored: post.boosted == true,
                  );
                },
              ),
      ),
    );
  }
}
