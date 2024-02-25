import 'package:betticos/common/common.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';

enum NotificationType { reaction, post, follow }

class AllNotificationScreens extends StatelessWidget {
  const AllNotificationScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppPaddings.lH,
      children: <Widget>[
        ReactionNotificationScreen(
          reactionType: ReactionType.like,
        ),
        TimelineCard(post: Post.mock(), avatarSize: 35),
        ReactionNotificationScreen(
          reactionType: ReactionType.follows,
        ),
      ],
    );
  }
}
