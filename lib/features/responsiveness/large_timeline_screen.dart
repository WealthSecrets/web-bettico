import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../features/betticos/data/models/post/post_model.dart';
import '../../../../features/betticos/presentation/timeline/widgets/timeline_card.dart';
import '../../core/core.dart';

class LargeTimelineScreen extends StatefulWidget {
  const LargeTimelineScreen({Key? key}) : super(key: key);

  @override
  State<LargeTimelineScreen> createState() => _LargeTimelineScreenState();
}

class _LargeTimelineScreenState extends State<LargeTimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(
        () => timelineController.pagingController.value.refresh(),
      ),
      child: Obx(
        () => PagedListView<int, Post>.separated(
          pagingController: timelineController.pagingController.value,
          padding: AppPaddings.lT,
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (BuildContext context, Post post, int index) {
              return Obx(
                () => TimelineCard(
                  post: post,
                  onTap: () {
                    // Navigator.of(context).push<void>(
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => PostDetailsScreen(
                    //       post: post,
                    //     ),
                    //   ),
                    // );
                  },
                  onCommentTap: () => timelineController.navigateToAddPost(
                    context,
                    pstId: post.id,
                  ),
                  onLikeTap: () =>
                      timelineController.likeThePost(context, post.id),
                  onDislikeTap: () =>
                      timelineController.dislikeThePost(context, post.id),
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (BuildContext context) =>
                ErrorIndicator(
              error: timelineController.pagingController.value.error as Failure,
              onTryAgain: () =>
                  timelineController.pagingController.value.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (BuildContext context) =>
                const EmptyListIndicator(),
            newPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: LoadingLogo(),
            ),
            firstPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: LoadingLogo(),
            ),
            // padding: AppPaddings.homeA,
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox.shrink(),
        ),
      ),
    );
  }
}
