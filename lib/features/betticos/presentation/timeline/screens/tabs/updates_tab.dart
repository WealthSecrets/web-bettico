import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class UpdatesTab extends StatelessWidget {
  UpdatesTab({super.key});

  final TimelineController controller = Get.find<TimelineController>();

  @override
  Widget build(BuildContext context) {
    final List<Post> topPosts = controller.getTopUsers();
    return topPosts.isEmpty
        ? AppEmptyScreen(message: 'no_records'.tr)
        : ListView.separated(
            padding: AppPaddings.lA,
            itemCount: topPosts.length,
            itemBuilder: (BuildContext context, int index) {
              return _UserListRow(controller: controller, user: topPosts[index].user);
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
  }
}

class _UserListRow extends StatelessWidget {
  _UserListRow({required this.controller, required this.user});

  final TimelineController controller;
  final User user;

  final BaseScreenController baseScreenController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    final double averageUserPosts = controller.getUserPercentage(user.id);
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(builder: (BuildContext context) => ProfileScreen(user: user)),
            );
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${user.photo}',
                  headers: <String, String>{'Authorization': 'Bearer ${baseScreenController.userToken.value}'},
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const AppSpacing(h: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text('@${user.username}', style: TextStyle(color: context.colors.grey, fontSize: 10)),
              const AppSpacing(v: 5),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  controller.getUsersTotalWins(user.id).toString(),
                  style: TextStyle(fontSize: 12, color: context.colors.text),
                ),
                Icon(Ionicons.caret_up_sharp, size: 24, color: context.colors.success),
              ],
            ),
            Text(
              '${averageUserPosts.toStringAsFixed(2)}%',
              style: TextStyle(
                color: averageUserPosts >= 50 ? context.colors.success : context.colors.error,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  controller.getUserTotalLosses(user.id).toString(),
                  style: TextStyle(fontSize: 12, color: context.colors.text),
                ),
                Icon(Ionicons.caret_down_sharp, size: 24, color: context.colors.error),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
