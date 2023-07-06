import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/core/core.dart';
import '/core/presentation/utils/app_endpoints.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '/features/betticos/presentation/profile/screens/profile_screen.dart';

class Card extends StatelessWidget {
  Card({
    super.key,
    required this.post,
    this.onTap,
    this.onCommentTap,
    this.onLikeTap,
    this.onDislikeTap,
    this.onShareTap,
    this.largeFonts = false,
  });
  final bool largeFonts;
  final Post post;
  final void Function()? onTap;
  final void Function()? onCommentTap;
  final void Function()? onLikeTap;
  final void Function()? onDislikeTap;
  final void Function()? onShareTap;

  final BaseScreenController bController = Get.find<BaseScreenController>();
  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: AppPaddings.lB,
        padding: AppPaddings.lH.add(AppPaddings.lT),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(builder: (BuildContext context) => ProfileScreen(user: post.user)),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${AppEndpoints.userImages}/${post.user.photo}',
                          headers: <String, String>{'Authorization': 'Bearer ${bController.userToken.value}'},
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
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${post.user.firstName} ${post.user.lastName}',
                              style: context.body1
                                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const AppSpacing(h: 5),
                          Text(
                            timeago.format(post.createdAt),
                            style: context.caption.copyWith(color: context.colors.text),
                          ),
                        ],
                      ),
                      const AppSpacing(h: 8),
                      Text(
                        '@${post.user.username}',
                        style: context.sub1.copyWith(color: context.colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ),
                GestureDetector(onTap: () {}, child: const Icon(Ionicons.ellipsis_vertical, size: 20)),
              ],
            ),
            const AppSpacing(v: 10),
            if (post.text != null)
              RichText(
                text: TextSpan(
                  style: TextStyle(color: context.colors.black, fontSize: largeFonts ? 18 : 12, wordSpacing: 0.5),
                  children: <TextSpan>[
                    TextSpan(text: post.text),
                    if (post.isOddbox)
                      TextSpan(
                        text: '\n\n${'slip_code'.tr}: ',
                        style: TextStyle(fontWeight: FontWeight.w400, color: context.colors.black),
                      ),
                    if (post.isOddbox)
                      TextSpan(
                        text: post.slipCode,
                        style: TextStyle(fontWeight: FontWeight.w400, color: context.colors.primary),
                      )
                  ],
                ),
              ),
            const AppSpacing(v: 10),
            if (post.images != null && post.images!.isNotEmpty)
              Container(
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(image: AssetImage(post.images![0]), fit: BoxFit.cover),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildAnimatedButton(
                  context,
                  post.likeUsers.length,
                  post.likeUsers.contains(user.id),
                  Ionicons.thumbs_up_outline,
                  Ionicons.thumbs_up,
                  onLikeTap,
                ),
                _buildAnimatedButton(
                  context,
                  post.dislikeUsers.length,
                  post.dislikeUsers.contains(user.id),
                  Ionicons.thumbs_down_outline,
                  Ionicons.thumbs_down,
                  onDislikeTap,
                  isDislikeButton: true,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Ionicons.chatbox_outline,
                        color: context.colors.text,
                        size: 20,
                      ),
                      onPressed: onCommentTap,
                    ),
                    const AppSpacing(h: 5),
                    Text(
                      post.comments.toString(),
                      style: context.caption.copyWith(
                        color: context.colors.text,
                      ),
                    ),
                  ],
                ),
                _buildAnimatedButton(
                  context,
                  post.shares.length,
                  post.shares.contains(user.id),
                  Ionicons.arrow_redo_outline,
                  Ionicons.arrow_redo,
                  onShareTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(
    BuildContext context,
    int count,
    bool isLiked,
    IconData iconOutline,
    IconData iconSolid,
    Function()? onTap, {
    bool isDislikeButton = false,
  }) {
    return LikeButton(
      size: 22,
      circleColor: CircleColor(
        start: isDislikeButton ? const Color(0xFFFF2626) : const Color(0xFFFDB811),
        end: isDislikeButton ? const Color(0xFFBD1616) : const Color(0xFFFCAF0E),
      ),
      bubblesColor: isDislikeButton
          ? const BubblesColor(dotPrimaryColor: Color(0xFFFF2626), dotSecondaryColor: Color(0xFFBD1616))
          : const BubblesColor(
              dotPrimaryColor: Color(0xFFFCA70B),
              dotSecondaryColor: Color(0xFFFC9906),
            ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? iconSolid : iconOutline,
          color: isLiked ? (isDislikeButton ? context.colors.error : context.colors.primary) : context.colors.text,
          size: 22,
        );
      },
      likeCount: count,
      isLiked: isLiked,
      onTap: (bool isLiked) async {
        onTap?.call();
        return !isLiked;
      },
    );
  }
}
