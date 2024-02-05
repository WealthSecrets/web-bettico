import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendsForYouScreen extends StatefulWidget {
  const TrendsForYouScreen({super.key, this.isOnScreen = false});

  final bool isOnScreen;

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
        final _MainBody body = _MainBody(hashtags: hashtags, controller: controller, isOnScreen: widget.isOnScreen);
        return AppLoadingBox(
          loading: controller.isLoadingHashtags.value,
          child: widget.isOnScreen ? body : SizedBox(height: 380, child: body),
        );
      },
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody({required this.hashtags, required this.controller, required this.isOnScreen});

  final List<Hashtag> hashtags;
  final ExploreController controller;
  final bool isOnScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!isOnScreen) ...<Widget>[
          Text(
            'Viralz',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.colors.black),
          ),
          const SizedBox(height: 16),
        ],
        Expanded(
          child: hashtags.isNotEmpty
              ? ListView(
                  padding: isOnScreen ? AppPaddings.lH : EdgeInsets.zero,
                  children: hashtags.take(5).map(
                    (Hashtag hashtag) {
                      return TrendCard(
                        title: 'Tredning in Ghana',
                        hashtag: StringUtils.capitalizeFirst(hashtag.name.replaceAll('#', '')),
                        count: '${hashtag.count}',
                        isSelected: controller.selectedHashtag.value == hashtag.name.replaceAll('#', ''),
                        onPressed: () {
                          controller.textEditingController.value.text = hashtag.name.replaceAll('#', '');
                          controller.setSelectedHashtag(hashtag.name.replaceAll('#', ''));
                          controller.navigateToSearchPage();
                          controller.getFilteredPosts(1);
                        },
                      );
                    },
                  ).toList(),
                )
              : const AppEmptyScreen(message: 'No popular hashtags were found.'),
        ),
      ],
    );
  }
}
