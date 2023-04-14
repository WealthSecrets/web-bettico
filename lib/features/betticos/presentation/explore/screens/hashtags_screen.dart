import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/data/models/post/hashtag_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/trend_card.dart';

class HashtagsScreen extends StatelessWidget {
  HashtagsScreen({Key? key}) : super(key: key);

  final ExploreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isSearching.value,
          child: controller.hashtags.isEmpty && !controller.isSearching.value
              ? AppEmptyScreen(
                  message:
                      'Oops! No results found for ${controller.selectedHashtag.value}')
              : ListView.builder(
                  padding: isSmallScreen
                      ? const EdgeInsets.symmetric(horizontal: 16)
                      : EdgeInsets.zero,
                  itemCount: controller.hashtags.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Hashtag hashtag = controller.hashtags[index];
                    return TrendCard(
                      title: 'Tredning in Ghana',
                      hashtag: StringUtils.capitalizeFirst(
                          hashtag.name.replaceAll('#', '')),
                      count: '${hashtag.count}',
                      isSelected: controller.selectedHashtag.value ==
                          hashtag.name.replaceAll('#', ''),
                      onPressed: () {
                        controller.setSelectedHashtag(
                            hashtag.name.replaceAll('#', ''));
                        controller.navigateToSearchPage();
                        controller.getFilteredPosts(1);
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
