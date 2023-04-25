import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:flutter/material.dart';

import 'left_side_bar.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({
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
          flex: 1,
          child: LeftSideBar(
            user: user,
            userToken: userToken,
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: context.colors.lightGrey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                left: BorderSide(
                  color: context.colors.lightGrey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: webNavigator(initialRoute),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  bool isLargeScreen(BuildContext context) => ResponsiveWidget.isLargeScreen(context);
}
