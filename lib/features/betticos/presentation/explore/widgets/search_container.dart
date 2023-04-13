import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/presentation/explore/getx/explore_controller.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/images_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/latest_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/top_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/screens/users_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/search_field_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../profile/widgets/circle_indicator.dart';

class SearchContainer extends StatelessWidget {
  SearchContainer({Key? key}) : super(key: key);

  final ExploreController controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    final bool isCustomScreen = ResponsiveWidget.isCustomSize(context);
    return WillPopScope(
      onWillPop: () {
        controller.isOnSearchPage.value = false;
        return Future<bool>.value(true);
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    controller.isOnSearchPage.value = false;
                  },
                  child: Icon(Ionicons.chevron_back_sharp,
                      color: context.colors.textDark, size: 24),
                ),
                if (isSmallScreen || isCustomScreen) ...<Widget>[
                  const SizedBox(width: 8),
                  const Expanded(child: SearchFieldContainer()),
                ],
              ],
            ),
            bottom: TabBar(
              indicatorColor: context.colors.primary,
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 14),
              padding: AppPaddings.lH,
              unselectedLabelColor: Colors.grey,
              indicator: CircleTabIndicator(
                color: context.colors.primary,
                radius: 3,
              ),
              tabs: const <Tab>[
                Tab(text: 'Top'),
                Tab(text: 'Latests'),
                Tab(text: 'Users'),
                Tab(text: 'Images'),
                Tab(text: 'Hashtags'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              TopScreen(),
              LatestScreen(),
              UsersScreen(),
              ImagesScreen(),
              const Center(child: Icon(Ionicons.add)),
            ],
          ),
        ),
      ),
    );
  }
}
