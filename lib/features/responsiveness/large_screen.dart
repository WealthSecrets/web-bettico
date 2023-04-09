import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/core/presentation/widgets/search_field.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/right_side_bar/screens/right_login_container.dart';
import 'package:betticos/features/betticos/presentation/right_side_bar/screens/trends_for_you_screens.dart';
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
          flex: 3,
          child: LeftSideBar(
            user: user,
            userToken: userToken,
          ),
        ),
        Expanded(
          flex: 6,
          child: webNavigator(initialRoute),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: const <Widget>[
              SizedBox(height: 24),
              SearchField(hintText: 'Search Xviral'),
              SizedBox(height: 24),
              TrendsForYouScreen(),
              SizedBox(height: 24),
              RightLoginContainer(),
            ],
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
