import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/profile_screen.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/presentation/utils/app_endpoints.dart';
import '../../core/presentation/widgets/app_empty_screen.dart';
import '../auth/data/models/user/user.dart';
import '../betticos/data/models/post/post_model.dart';

class LargeUdpateScreen extends StatelessWidget {
  const LargeUdpateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Post> topPosts = timelineController.getTopUsers();
    return topPosts.isEmpty
        ? AppEmptyScreen(message: 'no_records'.tr)
        : ListView.separated(
            padding: AppPaddings.lA,
            itemCount: topPosts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Ionicons.chevron_back_outline,
                        color: context.colors.primary,
                      ),
                    )
                  ],
                );
              }
              return _buildListUserRow(topPosts[index - 1].user, context);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
  }

  Widget _buildListUserRow(User user, BuildContext context) {
    final double averageUserPosts =
        timelineController.getUserPercentage(user.id);
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProfileScreen(user: user),
              ),
            );
            // navigationController.navigateTo(routeName)
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${user.photo}',
                  headers: <String, String>{
                    'Authorization':
                        'Bearer ${baseScreenController.userToken.value}'
                  },
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // const AppSpacing(h: 10),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(
                '@${user.username}',
                style: TextStyle(
                  color: context.colors.grey,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  timelineController.getUsersTotalWins(user.id).toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.text,
                  ),
                ),
                Icon(
                  Ionicons.caret_up_sharp,
                  size: 24,
                  color: context.colors.success,
                ),
              ],
            ),
            Text(
              '${averageUserPosts.toStringAsFixed(2)}%',
              style: TextStyle(
                color: averageUserPosts >= 50
                    ? context.colors.success
                    : context.colors.error,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  timelineController.getUserTotalLosses(user.id).toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.text,
                  ),
                ),
                Icon(
                  Ionicons.caret_down_sharp,
                  size: 24,
                  color: context.colors.error,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
