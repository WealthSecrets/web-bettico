import 'package:betticos/common/common.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepostsScreen extends GetWidget<ProfileController> {
  RepostsScreen({super.key});

  final TimelineController tController = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final List<Repost> reposts = controller.myReposts;
        return AppLoadingBox(
          loading: controller.isLoadingMyReposts.value,
          child: reposts.isEmpty
              ? const AppEmptyScreen(message: 'No reposts were found.')
              : ListView.builder(
                  itemCount: reposts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Repost repost = reposts[index];
                    final Post post = repost.post;
                    return RepostCard(
                      repost: repost,
                      onTap: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                        );
                      },
                      onComment: () => tController.navigateToAddPost(context, pstId: post.id),
                      onLike: () {
                        tController.likeThePost(context, post.id, isOddbox: post.isOddbox);
                        controller.removeFromLikedPost(post.id);
                      },
                      onDislike: () {
                        tController.dislikeThePost(context, post.id, isOddbox: post.isOddbox);
                        controller.removeFromLikedPost(post.id);
                      },
                      sponsored: post.boosted == true,
                    );
                  },
                ),
        );
      },
    );
  }
}
