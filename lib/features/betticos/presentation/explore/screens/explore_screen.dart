import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/post/post_model.dart';
import '../../timeline/widgets/timeline_card.dart';

class ExploreScreen extends GetWidget<ExploreController> {
  ExploreScreen({Key? key}) : super(key: key);

  final BaseScreenController bController = Get.find<BaseScreenController>();

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
                final String userToken = bController.userToken.value;
                return TimelineCard(
                  post: post,
                  onTap: () {
                    if(user.)
                  },
                  onCommentTap: () {},
                  onLikeTap: () {},
                  onDislikeTap: () {},
                );
              },
            );
          },
          firstPageErrorIndicatorBuilder: (BuildContext context) =>
              ErrorIndicator(
            error: controller.pagingController.value.error as Failure,
            onTryAgain: () => controller.pagingController.refresh(),
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
        ),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox.shrink(),
      ),
    );
  }
}
