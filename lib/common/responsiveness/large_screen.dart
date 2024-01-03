import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({
    super.key,
    required this.initialRoute,
    required this.userToken,
    required this.user,
  });
  final String initialRoute;
  final String userToken;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Expanded(child: SizedBox()),
        Expanded(flex: 3, child: LeftSideBar(user: user, userToken: userToken)),
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
  }

  bool isLargeScreen(BuildContext context) => ResponsiveWidget.isLargeScreen(context);
}
