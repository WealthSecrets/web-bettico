import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/widgets/timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopScreen extends StatelessWidget {
  TopScreen({Key? key}) : super(key: key);

  final ExploreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isSearching.value,
          child: controller.top.isEmpty && !controller.isSearching.value
              ? const AppEmptyScreen(message: 'Oops! No results for keyword.')
              : ListView.builder(
                  padding: isSmallScreen
                      ? const EdgeInsets.symmetric(horizontal: 16)
                      : EdgeInsets.zero,
                  itemCount: controller.top.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Post post = controller.top[index];
                    return TimelineCard(
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
                    );
                  },
                ),
        ),
      ),
    );
  }
}
