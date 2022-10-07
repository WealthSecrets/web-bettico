import 'package:flutter/material.dart';

// import 'large_timeline_screen.dart';
import 'left_side_bar.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 5,
          child: LeftSideBar(),
        ),
        // Expanded(
        //   flex: 8,
        //   child: webNavigator(),
        // ),
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
}
