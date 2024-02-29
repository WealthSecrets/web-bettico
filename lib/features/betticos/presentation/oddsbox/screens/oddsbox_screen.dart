import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OddsboxScreen extends StatefulWidget {
  const OddsboxScreen({super.key});

  @override
  State<OddsboxScreen> createState() => _OddsboxScreenState();
}

class _OddsboxScreenState extends State<OddsboxScreen> {
  final TimelineController controller = Get.find<TimelineController>();

  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(() {
      controller.getAllSubscribedOddboxes(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isOddboxLoading.value,
        child: Scaffold(
          body: controller.oddboxes.isEmpty
              ? AppEmptyScreen(message: 'no_oddboxes'.tr)
              : Obx(
                  () => ListView.builder(
                    itemCount: controller.oddboxes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Post post = controller.oddboxes[index];
                      return TimelineCard(
                        post: post,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                          );
                        },
                        onComment: () => controller.navigateToAddPost(context, p: post, isAreply: true),
                        onLike: () => controller.likeThePost(context, post.id),
                        onDislike: () => controller.dislikeThePost(context, post.id),
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
                        onBookmark: () => controller.bookmarkThePost(context, post.id),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
