import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ExploreScreen extends GetWidget<ExploreController> {
  ExploreScreen({super.key});

  final BaseScreenController bController = Get.find<BaseScreenController>();
  final TimelineController tController = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(
        () => controller.pagingController.refresh(),
      ),
      child: PagedListView<int, Post>.separated(
        pagingController: controller.pagingController,
        padding: const EdgeInsets.only(top: 8),
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (BuildContext context, Post post, int index) {
            return Obx(
              () {
                return TimelineCard(
                  post: post,
                  onTap: () {
                    if (bController.isLoggedIn) {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                      );
                    } else {
                      WidgetUtils.showUnAuthorizedLoginContainer(context);
                    }
                  },
                  onCommentTap: () => tController.navigateToAddPost(
                    context,
                    pstId: post.id,
                  ),
                  onLikeTap: () {
                    if (bController.isLoggedIn) {
                      tController.likeThePost(context, post.id);
                    }
                  },
                  onDislikeTap: () {
                    if (bController.isLoggedIn) {
                      tController.dislikeThePost(context, post.id);
                    }
                  },
                );
              },
            );
          },
          firstPageErrorIndicatorBuilder: (BuildContext context) => ErrorIndicator(
            error: controller.pagingController.value.error as Failure,
            onTryAgain: () => controller.pagingController.refresh(),
          ),
          noItemsFoundIndicatorBuilder: (BuildContext context) => const EmptyListIndicator(),
          newPageProgressIndicatorBuilder: (BuildContext context) => const Center(child: LoadingLogo()),
          firstPageProgressIndicatorBuilder: (BuildContext context) => const Center(child: LoadingLogo()),
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox.shrink(),
      ),
    );
  }
}
