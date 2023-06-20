import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/core/presentation/widgets/app_empty_screen.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/presentation/profile/getx/profile_controller.dart';
import '/features/betticos/presentation/timeline/getx/timeline_controller.dart';
import '/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
import '/features/betticos/presentation/timeline/widgets/timeline_card.dart';

class MyPostsScreen extends GetWidget<ProfileController> {
  MyPostsScreen({Key? key, required this.userId, this.isOddboxes = false}) : super(key: key);
  final bool isOddboxes;
  final String userId;

  final TimelineController tController = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoadingMyOddboxes.value || controller.isLoadingMyPosts.value,
        child: (isOddboxes ? controller.myOddboxes.isEmpty : controller.myPosts.isEmpty)
            ? AppEmptyScreen(
                message: isOddboxes ? 'no_oddboxes'.tr : 'no_posts'.tr,
              )
            : ListView.builder(
                itemCount: isOddboxes ? controller.myOddboxes.length : controller.myPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  final Post post = isOddboxes ? controller.myOddboxes[index] : controller.myPosts[index];
                  return TimelineCard(
                    post: post,
                    onTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => PostDetailsScreen(post: post),
                        ),
                      );
                    },
                    onCommentTap: () => tController.navigateToAddPost(
                      context,
                      pstId: post.id,
                    ),
                    onLikeTap: () => controller.likeThePost(
                      context,
                      post.id,
                      userId,
                      isOddbox: isOddboxes,
                    ),
                    onDislikeTap: () => controller.dislikeThePost(
                      context,
                      post.id,
                      userId,
                      isOddbox: isOddboxes,
                    ),
                    sponsored: post.boosted == true,
                  );
                },
              ),
      ),
    );
  }
}
