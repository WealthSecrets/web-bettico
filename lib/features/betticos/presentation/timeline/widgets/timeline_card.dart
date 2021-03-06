import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '/core/core.dart';
import '/core/presentation/utils/app_endpoints.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '/features/betticos/presentation/profile/getx/profile_controller.dart';
import '/features/betticos/presentation/profile/screens/profile_screen.dart';
import '/features/betticos/presentation/timeline/widgets/timeline_image_divider.dart';
import 'modal_fit.dart';

class TimelineCard extends StatelessWidget {
  TimelineCard({
    Key? key,
    required this.post,
    this.onTap,
    this.onCommentTap,
    this.onLikeTap,
    this.onDislikeTap,
    this.onShareTap,
    this.largeFonts = false,
  }) : super(key: key);
  final bool largeFonts;
  final Post post;
  final void Function()? onTap;
  final void Function()? onCommentTap;
  final void Function()? onLikeTap;
  final void Function()? onDislikeTap;
  final void Function()? onShareTap;

  final BaseScreenController bController = Get.find<BaseScreenController>();
  final ProfileController pController = Get.find<ProfileController>();
  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context)
            ? AppPaddings.lB.add(AppPaddings.lH)
            : AppPaddings.lB,
        padding: AppPaddings.lH.add(AppPaddings.lT),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ResponsiveWidget.isSmallScreen(context)
              ? const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black12,
                    offset: Offset(0, 1),
                  )
                ]
              : null,
          borderRadius: ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context)
              ? AppBorderRadius.smallAll
              : null,
          border: !ResponsiveWidget.isSmallScreen(context)
              ? Border.all(
                  color: context.colors.faintGrey,
                  width: 1,
                  style: BorderStyle.solid,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ProfileScreen(
                          user: post.user,
                          showBackButton: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${AppEndpoints.userImages}/${post.user.photo}',
                          headers: <String, String>{
                            'Authorization':
                                'Bearer ${bController.userToken.value}'
                          },
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ProfileScreen(
                          user: post.user,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${post.user.firstName} ${post.user.lastName}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            timeago.format(post.createdAt),
                            style: TextStyle(
                              color: context.colors.text,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '@${post.user.username}',
                        style: TextStyle(
                          color: context.colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      if (pController.myFollowingLikedPost(post.likeUsers))
                        Row(
                          children: <Widget>[
                            Icon(Ionicons.thumbs_up,
                                color: context.colors.primary, size: 14),
                            const SizedBox(width: 5),
                            Text(
                              '${'liked_by'.tr} ${pController.myFollowingWhoLikedPost(post.likeUsers)}',
                              style: context.sub1.copyWith(
                                color: context.colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                )),
                // if (user.id != post.user.id)
                GestureDetector(
                  onTap: () => showMaterialModalBottomSheet<String>(
                    context: context,
                    builder: (_) => ModalFit(
                      post: post,
                      ctx: context,
                    ),
                  ),
                  child: Icon(
                    Ionicons.ellipsis_vertical,
                    size: 16,
                    color: context.colors.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (post.text != null && post.text!.isNotEmpty)
              DetectableText(
                trimLines: 7,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'more',
                trimExpandedText: '...less',
                text: '${post.text}',
                detectionRegExp: RegExp(
                  '(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent',
                  multiLine: true,
                ),
                callback: (bool readMore) {
                  debugPrint('Read more >>>>>>> $readMore');
                },
                onTap: (String tappedText) async {
                  if (tappedText.startsWith('#')) {
                    debugPrint('DetectableText >>>>>>> #');
                  } else if (tappedText.startsWith('@')) {
                    debugPrint('DetectableText >>>>>>> @');
                  } else if (tappedText.startsWith('http')) {
                    _launchURL(tappedText);
                  }
                },
                basicStyle: largeFonts
                    ? TextStyle(
                        color: context.colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )
                    : TextStyle(
                        color: context.colors.black,
                        fontSize: 12,
                      ),
                detectedStyle: largeFonts
                    ? TextStyle(
                        fontWeight: FontWeight.w500,
                        wordSpacing: 0.5,
                        color: context.colors.primary,
                        fontSize: 16,
                      )
                    : TextStyle(
                        fontWeight: FontWeight.w500,
                        wordSpacing: 0.5,
                        color: context.colors.primary,
                        fontSize: 12,
                      ),
              ),
            if (post.slipCode != null && post.isOddbox)
              SelectableText.rich(
                TextSpan(
                  style: TextStyle(
                    color: context.colors.black,
                    fontSize: largeFonts ? 18 : 12,
                    wordSpacing: 0.5,
                  ),
                  children: <TextSpan>[
                    if (post.isOddbox)
                      TextSpan(
                        text: '${'slip_code'.tr}: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: context.colors.black,
                        ),
                      ),
                    if (post.isOddbox)
                      TextSpan(
                        text: post.slipCode,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: context.colors.primary,
                        ),
                      )
                  ],
                ),
              ),
            if (post.text != null) const SizedBox(height: 10),
            if (post.images != null && post.images!.isNotEmpty)
              TimelineImageDivider(
                images: post.images!,
                token: bController.userToken.value,
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
                    const SizedBox(width: 5),
                    Text(
                      post.comments.toString(),
                      style: TextStyle(
                        color: context.colors.text,
                        fontSize: 12,
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

  void _launchURL(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildAnimatedButton(BuildContext context, int count, bool isLiked,
      IconData iconOutline, IconData iconSolid, Function()? onTap,
      {bool isDislikeButton = false}) {
    return LikeButton(
      size: 22,
      circleColor: CircleColor(
          start: isDislikeButton
              ? const Color(0xFFFF2626)
              : const Color(0xFFFDB811),
          end: isDislikeButton
              ? const Color(0xFFBD1616)
              : const Color(0xFFFCAF0E)),
      bubblesColor: isDislikeButton
          ? const BubblesColor(
              dotPrimaryColor: Color(0xFFFF2626),
              dotSecondaryColor: Color(0xFFBD1616))
          : const BubblesColor(
              dotPrimaryColor: Color(0xFFFCA70B),
              dotSecondaryColor: Color(0xFFFC9906),
            ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? iconSolid : iconOutline,
          color: isLiked
              ? (isDislikeButton
                  ? context.colors.error
                  : context.colors.primary)
              : context.colors.text,
          size: 22,
        );
      },
      likeCount: count,
      isLiked: isLiked,
      countBuilder: (int? c, bool value, String text) {
        return Text(
          '$c',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: context.colors.text,
          ),
        );
      },
      onTap: (bool isLiked) async {
        if (onTap != null) {
          onTap();
        }

        return !isLiked;
      },
    );
  }
}
