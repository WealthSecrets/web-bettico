import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/trends/screens/trends_for_you_screens.dart';
import 'package:flutter/material.dart';

import 'left_side_bar.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({
    Key? key,
    required this.initialRoute,
    required this.userToken,
    required this.user,
  }) : super(key: key);
  final String initialRoute;
  final String userToken;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 4,
          child: LeftSideBar(
            user: user,
            userToken: userToken,
          ),
        ),
        Expanded(
          flex: 8,
          child: webNavigator(initialRoute),
        ),
        const Expanded(
          flex: 4,
          child: TrendsForYouScreen(),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
