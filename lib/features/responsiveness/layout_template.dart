import 'package:betticos/features/responsiveness/large_screen.dart';
import 'package:betticos/features/responsiveness/small_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({
    Key? key,
    // required this.child,
  }) : super(key: key);
  // final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) =>
          Scaffold(
        backgroundColor: Colors.white,
        body: sizingInformation.deviceScreenType == DeviceScreenType.desktop
            ? const HomeBaseScreen()
            : const SmallScreen(),
      ),
    );
  }
}
