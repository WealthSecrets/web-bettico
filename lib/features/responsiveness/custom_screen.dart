import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:flutter/material.dart';

import 'left_side_bar.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({super.key, required this.initialRoute, required this.userToken, required this.user});

  final String initialRoute;
  final String userToken;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Expanded(child: SizedBox()),
        Expanded(child: LeftSideBar(user: user, userToken: userToken)),
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
            child: webNavigator(initialRoute),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  bool isLargeScreen(BuildContext context) => ResponsiveWidget.isLargeScreen(context);
}
