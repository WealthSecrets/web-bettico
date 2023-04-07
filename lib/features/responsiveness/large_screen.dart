import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:flutter/material.dart';

import 'left_side_bar.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        const Expanded(
          flex: 3,
          child: LeftSideBar(),
        ),
        Expanded(
          flex: 8,
          child: webNavigator(initialRoute),
        ),
        Expanded(
          flex: 5,
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
