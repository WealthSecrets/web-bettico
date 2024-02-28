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
    this.onLike,
    this.onDislike,
    this.onRepost,
    this.onComment,
    this.onShare,
  });

  final dynamic item;
  final void Function()? onLike;
  final void Function()? onDislike;
  final void Function()? onRepost;
  final void Function()? onComment;
  final void Function()? onShare;

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
                color: context.colors.darkenText,
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
