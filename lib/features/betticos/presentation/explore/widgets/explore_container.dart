import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/widgets/search_field.dart';
import 'package:betticos/core/presentation/widgets/selectable_button.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/explore_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreContainer extends StatelessWidget {
  ExploreContainer({Key? key}) : super(key: key);

  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (ResponsiveWidget.isSmallScreen(context))
            const SizedBox(height: 56),
          if (!ResponsiveWidget.isSmallScreen(context)) ...<Widget>[
            const SizedBox(height: 24),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _selectableButtons,
              ),
            ),
          ],
          if (ResponsiveWidget.isSmallScreen(context))
            Obx(
              () => SizedBox(
                height: 30,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) {
                    if (index == 0 || index == _selectableButtons.length + 1) {
                      return const SizedBox(width: 16);
                    }
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: _selectableButtons[index - 1],
                    );
                  },
                  itemCount: _selectableButtons.length + 2,
                ),
              ),
            ),
          if (ResponsiveWidget.isSmallScreen(context)) ...<Widget>[
            const SizedBox(height: 8),
            Padding(
              padding: AppPaddings.lH,
              child: searchField,
            ),
          ],
          if (ResponsiveWidget.isCustomSize(context)) ...<Widget>[
            const SizedBox(height: 8),
            searchField,
          ],
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () {
                final Options option = controller.selectedOption.value;
                switch (option) {
                  case Options.posts:
                    return const ExploreScreen();
                  case Options.sports:
                    return const SportsScreen();
                  case Options.bets:
                    return const ExploreScreen();
                  case Options.rates:
                    return const ExploreScreen();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _selectableButtons => <Widget>[
        SelectableButton(
          text: 'Posts',
          onPressed: controller.refreshPosts,
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
          text: 'Bets',
          onPressed: () {
            controller.selectedOption.value = Options.bets;
          },
          selected: controller.selectedOption.value == Options.bets,
        ),
        SelectableButton(
          text: 'Market Rates',
          onPressed: () {
            controller.selectedOption.value = Options.rates;
          },
          selected: controller.selectedOption.value == Options.rates,
        ),
      ];

  SearchField get searchField => const SearchField(
        hintText: 'Search Xviral',
      );
}
