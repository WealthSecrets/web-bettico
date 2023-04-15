import 'package:betticos/core/presentation/base_screens/app_navigator.dart';
import 'package:betticos/core/presentation/helpers/responsiveness.dart';
// import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/search_field_container.dart';
import 'package:betticos/features/betticos/presentation/right_side_bar/screens/right_login_container.dart';
import 'package:betticos/features/betticos/presentation/right_side_bar/screens/trends_for_you_screens.dart';
import 'package:betticos/features/responsiveness/home_base_screen.dart';
import 'package:flutter/material.dart';

import 'left_side_bar.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({
    Key? key,
    required this.initialRoute,
    required this.userToken,
    required this.user,
    this.arguments,
  }) : super(key: key);
  final String initialRoute;
  final String userToken;
  final User user;
  final AppBaseScreenArguments? arguments;

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
          child: AppNavigator(initialRoute: initialRoute, arguments: arguments),
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
                if (isLargeScreen(context)) const RightLoginContainer(),
              ],
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  bool isLargeScreen(BuildContext context) =>
      ResponsiveWidget.isLargeScreen(context);
}
