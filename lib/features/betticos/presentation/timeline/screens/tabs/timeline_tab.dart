import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/data/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TimelineTab extends StatelessWidget {
  TimelineTab({super.key});

  final TimelineController controller = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(
        () => controller.pagingController.value.refresh(),
      ),
      child: Obx(
        () {
          return CustomScrollView(
            slivers: <Widget>[
              PagedSliverList<int, CombinedItem<dynamic>>.separated(
                pagingController: controller.pagingController.value,
                builderDelegate: PagedChildBuilderDelegate<CombinedItem<dynamic>>(
                  itemBuilder: (BuildContext context, CombinedItem<dynamic> item, int index) {
                    if (item.isPost) {
                      final Post post = item.item as Post;
                      return TimelineCard(
                        post: post,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                          );
                        },
                        onComment: () => controller.navigateToAddPost(context, p: post, isAreply: true),
                        sponsored: post.boosted == true,
                        onLike: () => controller.likeThePost(context, post.id),
                        onDislike: () => controller.dislikeThePost(context, post.id),
                        onBookmark: () => controller.bookmarkThePost(context, post.id),
                        onRepost: () => WidgetUtils.showOptionsBottomSheet(
                          context,
                          title: 'Choose Action',
                          iconColor: context.colors.primary,
                          iconSize: 18,
                          options: <OptionArgument>[
                            OptionArgument(
                              icon: AppAssetIcons.refresh,
                              title: 'Repost',
                              onPressed: () => controller.addNewRepost(context, postId: post.id),
                            ),
                            OptionArgument(
                              icon: AppAssetIcons.editPencil,
                              title: 'Quote',
                              onPressed: () {
                                Navigator.of(context).pop();
                                controller.navigateToAddPost(context, p: post, isAreply: false);
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      final Repost repost = item.item as Repost;
                      return RepostCard(
                        repost: repost,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => PostDetailsScreen(post: repost.post),
                            ),
                          );
                        },
                        onLike: () => controller.likeTheRepost(context, repost.id),
                        onDislike: () => controller.dislikeTheRepost(context, repost.id),
                        onComment: () {},
                        onShare: () {},
                        onRepost: () => WidgetUtils.showOptionsBottomSheet(
                          context,
                          title: 'Choose Action',
                          iconSize: 18,
                          iconColor: context.colors.primary,
                          options: <OptionArgument>[
                            OptionArgument(
                              icon: AppAssetIcons.refresh,
                              title: 'Repost',
                              onPressed: () => controller.addNewRepost(context, postId: repost.post.id),
                            ),
                            OptionArgument(
                              icon: AppAssetIcons.editPencil,
                              title: 'Quote',
                              onPressed: () {
                                Navigator.of(context).pop();
                                controller.navigateToAddPost(context, p: repost.post, isAreply: false);
                              },
                            ),
                          ],
                        ),
                        sponsored: repost.boosted == true,
                      );
                    }
                  },
                  firstPageErrorIndicatorBuilder: (BuildContext context) => ErrorIndicator(
                    error: controller.pagingController.value.error as Failure,
                    onTryAgain: () => controller.pagingController.value.refresh(),
                  ),
                  noItemsFoundIndicatorBuilder: (BuildContext context) => const EmptyListIndicator(),
                  newPageProgressIndicatorBuilder: (BuildContext context) => const Center(child: LoadingLogo()),
                  firstPageProgressIndicatorBuilder: (BuildContext context) => const Center(child: LoadingLogo()),
                ),
                separatorBuilder: (_, __) => Divider(color: context.colors.dividerColor, thickness: 0.5),
              ),
              SliverToBoxAdapter(
                child: Builder(
                  builder: (BuildContext context) {
                    final int? itemCount = controller.pagingController.value.itemList?.length;
                    final int pageIndex = (itemCount! - 1) ~/ 100;
                    if ((pageIndex + 1) % 20 == 0) {
                      return Container(
                        color: Colors.grey,
                        height: 50,
                        child: const Center(child: Text('Widget after every 20 posts')),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
