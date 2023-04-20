import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/app_empty_screen.dart';
import 'package:betticos/features/betticos/data/models/post/hashtag_model.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashtagsScreen extends StatelessWidget {
  HashtagsScreen({Key? key}) : super(key: key);

  final ExploreController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double size = 40;
    double titleFontSize = 18;
    double subtitleFontSize = 14;
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    final bool isCustomScreen = ResponsiveWidget.isCustomSize(context);
    final bool isMediumScreen = ResponsiveWidget.isMediumScreen(context);

    if (isSmallScreen) {
      size = 30;
      titleFontSize = 12;
      subtitleFontSize = 10;
    } else if (isCustomScreen) {
      size = 30;
      titleFontSize = 14;
      subtitleFontSize = 12;
    } else if (isMediumScreen) {
      size = 35;
      titleFontSize = 16;
      subtitleFontSize = 14;
    }

    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isSearching.value,
          child: controller.filteredHashtags.isEmpty && !controller.isSearching.value
              ? AppEmptyScreen(message: 'Oops! No results found for ${controller.selectedHashtag.value}')
              : ListView.separated(
                  padding: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
                  itemCount: controller.filteredHashtags.length,
                  separatorBuilder: (_, int index) => Divider(color: context.colors.text),
                  itemBuilder: (BuildContext context, int index) {
                    final Hashtag hashtag = controller.filteredHashtags[index];
                    final String name = hashtag.name.replaceAll('#', '');
                    return ListTile(
                      onTap: () {
                        controller.tabController.animateTo(0);
                        controller.textEditingController.value.text = name;
                        controller.setSelectedHashtag(name);
                        controller.navigateToSearchPage();
                        controller.getFilteredPosts(1);
                      },
                      leading: Container(
                        height: size,
                        width: size,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: context.colors.lightGrey,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '#',
                            style: TextStyle(
                              fontSize: size - 18,
                              fontWeight: FontWeight.bold,
                              color: context.colors.black,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                          color: context.colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${hashtag.count} Posts',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.normal,
                          color: context.colors.text,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
