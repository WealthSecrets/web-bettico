import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LargeScreen extends StatelessWidget {
  LargeScreen({super.key, required this.initialRoute});

  final String initialRoute;

  final BaseScreenController baseScreenController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final String userToken = baseScreenController.userToken.value;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Expanded(child: SizedBox()),
          const Expanded(flex: 3, child: LeftSideBar()),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: context.colors.lightGrey),
                  left: BorderSide(color: context.colors.lightGrey),
                ),
              ),
              child: appNavigator(initialRoute),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 24),
                  const SearchFieldContainer(),
                  const SizedBox(height: 24),
                  const TrendsForYouScreen(),
                  const SizedBox(height: 24),
                  if (isLargeScreen(context) && userToken.isEmpty) const RightLoginContainer(),
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      );
    });
  }

  bool isLargeScreen(BuildContext context) => ResponsiveWidget.isLargeScreen(context);
}
