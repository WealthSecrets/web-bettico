import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/widgets/timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestScreen extends StatelessWidget {
  LatestScreen({super.key});

  final ExploreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isSearching.value,
          child: controller.latest.isEmpty && !controller.isSearching.value
              ? AppEmptyScreen(message: 'Oops! No results found for ${controller.selectedHashtag.value}')
              : ListView.builder(
                  padding: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
                  itemCount: controller.latest.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Post post = controller.latest[index];
                    return TimelineCard(
                      post: post,
                      onTap: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(builder: (BuildContext context) => PostDetailsScreen(post: post)),
                        );
                      },
                      onCommentTap: () {},
                      onLikeTap: () {},
                      onDislikeTap: () {},
                    );
                  },
                ),
        ),
      ),
    );
  }
}
