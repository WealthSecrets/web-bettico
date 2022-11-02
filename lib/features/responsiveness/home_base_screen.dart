import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/responsiveness/left_side_bar.dart';
import 'package:betticos/features/responsiveness/top_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../core/presentation/helpers/responsiveness.dart';
import 'large_screen.dart';

class HomeBaseScreen extends StatelessWidget {
  HomeBaseScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
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
      body: ResponsiveWidget(
        largeScreen: const LargeScreen(),
        smallScreen: webNavigator(),
      ),
    );
  }
}
