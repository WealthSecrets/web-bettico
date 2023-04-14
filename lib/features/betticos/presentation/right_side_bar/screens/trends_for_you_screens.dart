import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/data/models/post/hashtag_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

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
                                return _TrendCard(
                                  title: 'Tredning in Ghana',
                                  hashtag: StringUtils.capitalizeFirst(
                                      hashtag.name.replaceAll('#', '')),
                                  count: '${hashtag.count}',
                                  isSelected:
                                      controller.selectedHashtag.value ==
                                          hashtag.name.replaceAll('#', ''),
                                  onPressed: () {
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

class _TrendCard extends StatelessWidget {
  const _TrendCard({
    Key? key,
    required this.title,
    required this.hashtag,
    required this.count,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String hashtag;
  final String count;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final TextStyle trendStyle = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: isSelected ? context.colors.faintGrey : context.colors.textDark,
    );
    const SizedBox space = SizedBox(height: 1);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: AppPaddings.mB,
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          color: isSelected ? context.colors.primary : Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: AppBorderRadius.smallAll,
          border: isSelected
              ? null
              : Border.all(
                  color: context.colors.faintGrey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
        ),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: trendStyle,
                ),
                space,
                Text(
                  hashtag,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : context.colors.black,
                  ),
                ),
                space,
                Text(
                  '$count Posts',
                  style: trendStyle,
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Icon(
                Ionicons.ellipsis_vertical_sharp,
                color:
                    isSelected ? context.colors.faintGrey : context.colors.text,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
