import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreContainer extends StatelessWidget {
  ExploreContainer({super.key});

  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    final bool isCustomScreen = ResponsiveWidget.isCustomSize(context);
    final bool isLargeScreen = ResponsiveWidget.isLargeScreen(context);
    final bool isMediumScreen = ResponsiveWidget.isMediumScreen(context);

    return Scaffold(
      body: Obx(
        () {
          final bool isPostsSelected = controller.selectedOption.value == Options.posts;

          return Column(
            children: <Widget>[
              if (!isSmallScreen) const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _selectableButtons,
              ),
              if (isLargeScreen || isMediumScreen) const SizedBox(height: 8),
              if (isSmallScreen && isPostsSelected) ...<Widget>[
                const SizedBox(height: 8),
                Padding(padding: AppPaddings.lH, child: const SearchFieldContainer()),
                const SizedBox(height: 8),
              ],
              if (isCustomScreen && isPostsSelected) ...<Widget>[
                const SizedBox(height: 8),
                const SearchFieldContainer(),
                const SizedBox(height: 8),
              ],
              Expanded(child: child()),
            ],
          );
        },
      ),
    );
  }

  Widget child() {
    final Options option = controller.selectedOption.value;
    switch (option) {
      case Options.posts:
        return ExploreScreen();
      case Options.anonymous:
        return ExploreScreen();
      case Options.games:
        return ExploreScreen();
    }
  }

  List<Widget> get _selectableButtons => <Widget>[
        SelectableButton(
          text: 'Posts',
          onPressed: controller.refreshPosts,
          selected: controller.selectedOption.value == Options.posts,
        ),
        SelectableButton(
          text: 'Anonymous',
          onPressed: () => controller.selectedOption.value = Options.anonymous,
          selected: controller.selectedOption.value == Options.anonymous,
        ),
        SelectableButton(
          text: 'Games',
          onPressed: () => controller.selectedOption.value = Options.games,
          selected: controller.selectedOption.value == Options.games,
        ),
      ];
}
