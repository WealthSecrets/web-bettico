import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/timeline/getx/timeline_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../data/models/post/post_model.dart';
import '../../widgets/timeline_card.dart';
import '../post_detail_screen.dart';

class TimelineTab extends StatelessWidget {
  TimelineTab({Key? key}) : super(key: key);

  final TimelineController controller = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(
        () => controller.pagingController.value.refresh(),
      ),
      child: Obx(
        () => PagedListView<int, Post>.separated(
          pagingController: controller.pagingController.value,
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (BuildContext context, Post post, int index) {
              return Obx(
                () => TimelineCard(
                  post: post,
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PostDetailsScreen(post: post),
                      ),
                    );
                  },
                  onCommentTap: () => controller.navigateToAddPost(
                    context,
                    pstId: post.id,
                  ),
                  onLikeTap: () => controller.likeThePost(context, post.id),
                  onDislikeTap: () => controller.dislikeThePost(context, post.id),
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (BuildContext context) => ErrorIndicator(
              error: controller.pagingController.value.error as Failure,
              onTryAgain: () => controller.pagingController.value.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (BuildContext context) => const EmptyListIndicator(),
            newPageProgressIndicatorBuilder: (BuildContext context) => const Center(
              child: LoadingLogo(),
            ),
            firstPageProgressIndicatorBuilder: (BuildContext context) => const Center(
              child: LoadingLogo(),
            ),
            // padding: AppPaddings.homeA,
          ),
          separatorBuilder: (BuildContext context, int index) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
