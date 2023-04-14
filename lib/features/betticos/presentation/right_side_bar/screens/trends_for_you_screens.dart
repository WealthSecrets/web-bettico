import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/data/models/post/hashtag_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../explore/widgets/trend_card.dart';

class TrendsForYouScreen extends StatefulWidget {
  const TrendsForYouScreen({Key? key}) : super(key: key);

  @override
  State<TrendsForYouScreen> createState() => _TrendsForYouScreenState();
}

class _TrendsForYouScreenState extends State<TrendsForYouScreen> {
  final ExploreController controller = Get.find<ExploreController>();

  @override
  void initState() {
    super.initState();
    controller.getAllHashtags();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final List<Hashtag> hashtags = controller.hashtags;
        return AppLoadingBox(
          loading: controller.isLoadingHashtags.value,
          child: SizedBox(
            height: 380,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Viralz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: hashtags.isNotEmpty
                        ? ListView(
                            children: hashtags.take(5).map(
                              (Hashtag hashtag) {
                                return TrendCard(
                                  title: 'Tredning in Ghana',
                                  hashtag: StringUtils.capitalizeFirst(
                                      hashtag.name.replaceAll('#', '')),
                                  count: '${hashtag.count}',
                                  isSelected:
                                      controller.selectedHashtag.value ==
                                          hashtag.name.replaceAll('#', ''),
                                  onPressed: () {
                                    controller
                                            .textEditingController.value.text =
                                        hashtag.name.replaceAll('#', '');
                                    controller.setSelectedHashtag(
                                        hashtag.name.replaceAll('#', ''));
                                    controller.navigateToSearchPage();
                                    controller.getFilteredPosts(1);
                                  },
                                );
                              },
                            ).toList(),
                          )
                        : const AppEmptyScreen(
                            message: 'No popular hashtags were found.'),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
