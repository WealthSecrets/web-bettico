import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/selectable_button.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/post/post_model.dart';
import '../../timeline/widgets/timeline_card.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          if (!ResponsiveWidget.isSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SelectableButton(
                  text: 'Posts',
                  onPressed: () {},
                  selected: true,
                ),
                SelectableButton(text: 'Sports', onPressed: () {}),
                SelectableButton(text: 'Bets', onPressed: () {}),
                SelectableButton(text: 'Market Rates', onPressed: () {}),
              ],
            ),
          const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future<void>.sync(
                () => controller.pagingController.refresh(),
              ),
              child: PagedListView<int, Post>.separated(
                pagingController: controller.pagingController,
                padding: const EdgeInsets.only(top: 8),
                builderDelegate: PagedChildBuilderDelegate<Post>(
                  itemBuilder: (BuildContext context, Post post, int index) {
                    return Obx(
                      () => TimelineCard(
                        post: post,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PostDetailsScreen(post: post),
                            ),
                          );
                        },
                        onCommentTap: () {},
                        onLikeTap: () {},
                        onDislikeTap: () {},
                      ),
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
            ),
          ),
        ],
      ),
    );
  }
}
