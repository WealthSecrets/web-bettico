import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
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
    this.onBookmark,
  });

  final dynamic item;
  final void Function()? onLike;
  final void Function()? onDislike;
  final void Function()? onRepost;
  final void Function()? onComment;
  final void Function()? onShare;
  final void Function()? onBookmark;

  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    final bool isRepost = item is Repost;
    final bool condition = isRepost ? item.post.reposts.contains(user.id) : item.reposts.contains(user.id);
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
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: onRepost,
              child: Image.asset(
                AppAssetIcons.refresh,
                color: condition ? context.colors.primary : context.colors.darkenText,
                height: 15,
                width: 15,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              isRepost ? '${item.post.reposts.length}' : '${item.reposts.length}',
              style: TextStyle(color: context.colors.text, fontSize: 12),
            ),
          ],
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
          count: item.bookmarks.length,
          isLiked: item.bookmarks.contains(user.id),
          iconOutline: AppAssetIcons.bookmarks,
          iconSolid: AppAssetIcons.bookmarksSolid,
          onTap: onBookmark,
        ),
      ],
    );
  }
}
