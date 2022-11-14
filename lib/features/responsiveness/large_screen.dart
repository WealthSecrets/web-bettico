import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'large_timeline_screen.dart';
import 'left_side_bar.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Checking current route: ${Get.currentRoute}');
    return Row(
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        const Expanded(
          flex: 5,
          child: LeftSideBar(),
        ),
        Expanded(
          flex: 8,
          child: webNavigator(),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  // list of pages
}
