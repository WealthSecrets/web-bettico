import 'package:flutter/material.dart';

const int largeScreenSize = 1008;
const int mediumScreenSize = 800;
const int smallScreenSize = 360;
const int customScreenSize = 641;

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    required this.mediumScreen,
    required this.smallScreen,
    this.customScreen,
  }) : super(key: key);

  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;
  final Widget? customScreen;

  // static methods
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < customScreenSize;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumScreenSize && MediaQuery.of(context).size.width < largeScreenSize;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeScreenSize;
  }

  static bool isCustomSize(BuildContext context) {
    return MediaQuery.of(context).size.width >= customScreenSize &&
        MediaQuery.of(context).size.width <= mediumScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        if (maxWidth >= largeScreenSize) {
          return largeScreen;
        } else if (maxWidth < largeScreenSize && maxWidth >= mediumScreenSize) {
          return mediumScreen;
        } else if (maxWidth >= customScreenSize && maxWidth < mediumScreenSize) {
          return customScreen ?? mediumScreen;
        } else if (maxWidth < customScreenSize && maxWidth >= smallScreenSize) {
          return smallScreen;
        } else {
          return smallScreen;
        }
      },
    );
  }
}
