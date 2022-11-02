import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/responsiveness/left_side_bar.dart';
import 'package:betticos/features/responsiveness/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/presentation/helpers/responsiveness.dart';
import 'large_screen.dart';

class HomeBaseScreen extends StatelessWidget {
  HomeBaseScreen({Key? key}) : super(key: key);
  // baseScreenController
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final BaseScreenController baseScreenController =
      Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? topNavigationBar(context, scaffoldKey)
          : null,
      drawer: ResponsiveWidget.isSmallScreen(context)
          ? Drawer(
              child: LeftSideBar(),
            )
          : null,
      body: AppLoadingBox(
        loading: baseScreenController.isLoggingOut.value,
        child: ResponsiveWidget(
          largeScreen: const LargeScreen(),
          smallScreen: webNavigator(),
        ),
      ),
    );
  }
}
