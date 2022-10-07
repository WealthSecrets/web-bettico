// ignore_for_file: must_be_immutable, use_key_in_widget_ructors
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/core/presentation/widgets/app_empty_screen.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/presentation/timeline/getx/timeline_controller.dart';
import '/features/betticos/presentation/timeline/widgets/timeline_card.dart';

class OddsboxScreen extends KFDrawerContent {
  OddsboxScreen({Key? key}) : super(key: key);

  static const String route = '/oddsbox';

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: ResponsiveWidget.isSmallScreen(context) ? 0.5 : null,
            automaticallyImplyLeading: ResponsiveWidget.isSmallScreen(context) ? false : true,
            leading: ResponsiveWidget.isSmallScreen(context)
                ? IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: widget.onMenuPressed,
                  )
                : null,
            title: Text(
              'odd_boxes'.tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
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
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => PostDetailsScreen(post: post),
                            ),
                          );
                        },
                        onCommentTap: () => controller.navigateToAddPost(
                          context,
                          pstId: post.id,
                        ),
                        onLikeTap: () => controller.likeThePost(context, post.id, isOddbox: true),
                        onDislikeTap: () => controller.dislikeThePost(context, post.id, isOddbox: true),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
