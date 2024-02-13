import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:betticos/features/presentation.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class RepostCard extends StatelessWidget {
  RepostCard({
    super.key,
    required this.repost,
    this.onTap,
    this.onCommentTap,
    this.onLikeTap,
    this.onDislikeTap,
    this.onShareTap,
    this.largeFonts = false,
    this.hideOptions = false,
    this.hideButtons = false,
    this.sponsored = false,
  });

  final bool largeFonts;
  final RepostResponse repost;
  final bool hideOptions;
  final bool hideButtons;
  final bool sponsored;
  final void Function()? onTap;
  final void Function()? onCommentTap;
  final void Function()? onLikeTap;
  final void Function()? onDislikeTap;
  final void Function()? onShareTap;

  final BaseScreenController bController = Get.find<BaseScreenController>();
  final ProfileController pController = Get.find<ProfileController>();
  final ExploreController exploreController = Get.find<ExploreController>();
  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: AppPaddings.lA,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.colors.dividerColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => navigationController.navigateTo(
                AppRoutes.profile,
                arguments: ProfileScreenArgument(user: repost.post.user, showBackButton: true),
              ),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.largeAll,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                      // headers: <String, String>{'Authorization': 'Bearer ${bController.userToken.value}'},
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const AppSpacing(h: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => navigationController.navigateTo(
                      AppRoutes.profile,
                      arguments: ProfileScreenArgument(user: repost.post.user, showBackButton: true),
                    ),
                    child: _PostUserDetails(post: repost.post, pController: pController),
                  ),
                  const AppSpacing(v: 6),
                  if (repost.comment.isNotEmpty)
                    DetectableText(
                      trimLines: 7,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'more',
                      trimExpandedText: '...less',
                      text: repost.comment,
                      detectionRegExp: RegExp(
                        '(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent',
                        multiLine: true,
                      ),
                      callback: (bool readMore) {
                        debugPrint('Read more >>>>>>> $readMore');
                      },
                      onTap: (String tappedText) async {
                        if (tappedText.startsWith('#')) {
                          final String name = tappedText.replaceAll('#', '');
                          exploreController.textEditingController.value.text = name;
                          exploreController.setSelectedHashtag(name);
                          exploreController.navigateToSearchPage();
                          exploreController.getFilteredPosts(1);
                        } else if (tappedText.startsWith('@')) {
                        } else if (tappedText.startsWith('http')) {
                          // await navigationController.navigateTo(
                          //   AppRoutes.appwebview,
                          //   arguments: AppWebViewRouteArgument(
                          //     title: 'Xviral Webview',
                          //     url: tappedText,
                          //     navigationDelegate: (NavigationRequest navigation) async => NavigationDecision.navigate,
                          //   ),
                          // );
                        }
                      },
                      basicStyle: context.sub2.copyWith(color: context.colors.text, fontWeight: FontWeight.w300),
                      detectedStyle: context.sub2.copyWith(color: context.colors.primary, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                  const SizedBox(height: 8),
                  Container(
                    padding: AppPaddings.mA,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFCED5DC)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(image: AssetImage(AssetImages.profileImage), fit: BoxFit.cover),
                              ),
                            ),
                            if (repost.post.user.firstName != null || repost.post.user.lastName != null) ...<Widget>[
                              const SizedBox(width: 5),
                              Text(
                                '${repost.post.user.firstName ?? ''} ${repost.post.user.lastName ?? ''}',
                                style: context.caption.copyWith(
                                  color: context.colors.black,
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            const SizedBox(width: 5),
                            Text(
                              '@${repost.post.user.username} . ${timeago.format(repost.post.createdAt)}',
                              style:
                                  context.caption.copyWith(fontWeight: FontWeight.normal, color: context.colors.text),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (repost.post.text != null) ...<Widget>[
                          Text(
                            repost.post.text!,
                            style: context.caption.copyWith(color: context.colors.black, fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 10)
                        ],
                        if (repost.post.images != null && repost.post.images!.isNotEmpty)
                          TimelineImageDivider(
                            images: const <String>[
                              'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg',
                              'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg'
                            ],
                            token: bController.userToken.value,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PostUserDetails extends StatelessWidget {
  const _PostUserDetails({required this.post, required this.pController});

  final Post post;
  final ProfileController pController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Text(
                    post.user.firstName ?? post.user.lastName ?? '',
                    style: context.sub2.copyWith(color: context.colors.black, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 5),
                  if (post.user.role == 'admin') Image.asset(AssetImages.verified, height: 14, width: 14),
                  Text(
                    '@${post.user.username}',
                    style: context.sub2.copyWith(color: context.colors.darkenText, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Text(
              timeago.format(post.createdAt),
              style: context.sub2.copyWith(color: context.colors.darkenText, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        if (pController.myFollowingLikedPost(post.likeUsers))
          Row(
            children: <Widget>[
              Icon(Ionicons.thumbs_up, color: context.colors.primary, size: 14),
              const SizedBox(width: 5),
              Text(
                '${'liked_by'.tr} ${pController.myFollowingWhoLikedPost(post.likeUsers)}',
                style: context.sub1.copyWith(color: context.colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
      ],
    );
  }
}

class _AnimatedButton extends StatelessWidget {
  const _AnimatedButton({
    required this.count,
    required this.isLiked,
    required this.iconOutline,
    required this.iconSolid,
    this.onTap,
    this.isDislikeButton = false,
  });

  final int count;
  final bool isLiked;
  final String iconOutline;
  final String iconSolid;
  final Function()? onTap;
  final bool isDislikeButton;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 15,
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
      likeBuilder: (bool isLiked) => Image.asset(
        isLiked ? iconSolid : iconOutline,
        color: isLiked ? (isDislikeButton ? context.colors.error : context.colors.primary) : context.colors.icon,
        height: 15,
        width: 15,
      ),
      likeCount: count,
      isLiked: isLiked,
      countBuilder: (int? c, bool value, String text) {
        return Text(
          '$c',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: context.colors.text),
        );
      },
      onTap: (bool isLiked) async {
        onTap?.call();
        return !isLiked;
      },
    );
  }
}
