import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
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
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 3,
          child: LeftSideBar(
            user: user,
            userToken: userToken,
          ),
        ),
        Expanded(
          flex: 8,
          child: webNavigator(initialRoute),
        ),
        Expanded(
          flex: 5,
          child: LoginScreen(),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
