import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/selectable_button.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/explore_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/market_rate_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/search_field_container.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/sports_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreContainer extends StatelessWidget {
  ExploreContainer({Key? key}) : super(key: key);

  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: <Widget>[
            if (!ResponsiveWidget.isSmallScreen(context))
              const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _selectableButtons,
            ),
            if (controller.selectedOption.value == Options.rates)
              const SizedBox(height: 16),
            if (ResponsiveWidget.isSmallScreen(context) &&
                controller.selectedOption.value == Options.posts) ...<Widget>[
              const SizedBox(height: 8),
              Padding(
                padding: AppPaddings.lH,
                child: const SearchFieldContainer(),
              ),
            ],
            if (ResponsiveWidget.isCustomSize(context) &&
                controller.selectedOption.value == Options.posts) ...<Widget>[
              const SizedBox(height: 8),
              const SearchFieldContainer(),
            ],
            Expanded(
              child: child(),
            ),
          ],
        ),
      ),
    );
  }

  Widget child() {
    final Options option = controller.selectedOption.value;
    switch (option) {
      case Options.posts:
        return const ExploreScreen();
      case Options.sports:
        return const SportsContainer();
      case Options.rates:
        return const MarketRateScreen();
    }
  }

  List<Widget> get _selectableButtons => <Widget>[
        SelectableButton(
          text: 'Posts',
          onPressed: () => controller.refreshPosts(),
          selected: controller.selectedOption.value == Options.posts,
        ),
        SelectableButton(
          text: 'Sports',
          onPressed: () {
            controller.selectedOption.value = Options.sports;
          },
          selected: controller.selectedOption.value == Options.sports,
        ),
        SelectableButton(
          text: 'Market Rates',
          onPressed: () {
            controller.selectedOption.value = Options.rates;
          },
          selected: controller.selectedOption.value == Options.rates,
        ),
      ];
}
