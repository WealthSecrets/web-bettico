import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostActionButtons extends StatelessWidget {
  PostActionButtons({
    super.key,
    required this.item,
    required this.onLike,
    required this.onDislike,
    required this.onRepost,
    required this.onComment,
    required this.onShare,
  });

  final dynamic item;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onRepost;
  final VoidCallback onComment;
  final VoidCallback onShare;

  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AnimatedButton(
          count: item.likeUsers.length,
          isLiked: item.likeUsers.contains(user.id),
          iconOutline: AppAssetIcons.thumbsUp,
          iconSolid: AppAssetIcons.thumbsUpSolid,
          onTap: onLike,
        ),
        AnimatedButton(
          count: item.dislikeUsers.length,
          isLiked: item.dislikeUsers.contains(user.id),
          iconOutline: AppAssetIcons.thumbsDown,
          iconSolid: AppAssetIcons.thumbsDownSolid,
          onTap: onDislike,
          isDislikeButton: true,
        ),
        AnimatedButton(
          count: 0,
          isLiked: false,
          iconOutline: AppAssetIcons.refresh,
          iconSolid: AppAssetIcons.refresh,
          onTap: onRepost,
          isDislikeButton: true,
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: onComment,
              child: Image.asset(
                AppAssetIcons.chat,
                color: context.colors.icon,
                height: 15,
                width: 15,
              ),
            ),
            const SizedBox(width: 5),
            if (item.comments != null)
              Text(item.comments.toString(), style: TextStyle(color: context.colors.text, fontSize: 12)),
          ],
        ),
        AnimatedButton(
          count: item.shares.length,
          isLiked: item.shares.contains(user.id),
          iconOutline: AppAssetIcons.share,
          iconSolid: AppAssetIcons.share,
          onTap: onShare,
        ),
      ],
    );
  }
}
