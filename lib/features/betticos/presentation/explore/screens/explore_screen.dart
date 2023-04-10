import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/search_field.dart';
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
          if (ResponsiveWidget.isSmallScreen(context))
            const SizedBox(height: 56),
          if (!ResponsiveWidget.isSmallScreen(context)) ...<Widget>[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _selectableButtons,
            ),
          ],
          if (ResponsiveWidget.isSmallScreen(context))
            SizedBox(
              height: 30,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) {
                  if (index == 0 || index == _selectableButtons.length + 1) {
                    return const SizedBox(width: 16);
                  }
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: _selectableButtons[index - 1],
                  );
                },
                itemCount: _selectableButtons.length + 2,
              ),
            ),
          if (ResponsiveWidget.isSmallScreen(context)) ...<Widget>[
            const SizedBox(height: 8),
            Padding(
              padding: AppPaddings.lH,
              child: searchField,
            ),
          ],
          if (ResponsiveWidget.isCustomSize(context)) ...<Widget>[
            const SizedBox(height: 8),
            searchField,
          ],
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

  List<Widget> get _selectableButtons => <Widget>[
        SelectableButton(
          text: 'Posts',
          onPressed: () {},
          selected: controller.selectedOption.value == Options.posts,
        ),
        SelectableButton(
          text: 'Sports',
          onPressed: () {},
          selected: controller.selectedOption.value == Options.sports,
        ),
        SelectableButton(
          text: 'Bets',
          onPressed: () {},
          selected: controller.selectedOption.value == Options.bets,
        ),
        SelectableButton(
          text: 'Market Rates',
          onPressed: () {},
          selected: controller.selectedOption.value == Options.posts,
        ),
      ];

  SearchField get searchField => const SearchField(
        hintText: 'Search Xviral',
      );
}
