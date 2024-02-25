import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimelineCard extends StatelessWidget {
  TimelineCard({
    super.key,
    required this.post,
    this.onTap,
    this.onComment,
    this.onLike,
    this.onDislike,
    this.onShare,
    this.onRepost,
    this.largeFonts = false,
    this.hideOptions = false,
    this.hideButtons = false,
    this.sponsored = false,
    this.avatarSize,
  });

  final bool largeFonts;
  final Post post;
  final bool hideOptions;
  final bool hideButtons;
  final bool sponsored;
  final double? avatarSize;
  final void Function()? onTap;
  final void Function()? onComment;
  final void Function()? onLike;
  final void Function()? onDislike;
  final void Function()? onShare;
  final void Function()? onRepost;

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
        padding: AppPaddings.lH.add(AppPaddings.mV),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => navigationController.navigateTo(
                AppRoutes.profile,
                arguments: ProfileScreenArgument(user: post.user, showBackButton: true),
              ),
              child: Container(
                height: avatarSize ?? 45,
                width: avatarSize ?? 45,
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
                      arguments: ProfileScreenArgument(user: post.user, showBackButton: true),
                    ),
                    child: _PostUserDetails(post: post, pController: pController),
                  ),
                  const AppSpacing(v: 6),
                  if (post.text != null && post.text!.isNotEmpty)
                    DetectableText(
                      trimLines: 7,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'more',
                      trimExpandedText: '...less',
                      text: post.text ?? '',
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
                  if (post.slipCode != null && post.isOddbox)
                    SelectableText.rich(
                      TextSpan(
                        style: TextStyle(color: context.colors.black, fontSize: largeFonts ? 18 : 12, wordSpacing: 0.5),
                        children: <TextSpan>[
                          if (post.isOddbox)
                            TextSpan(
                              text: '${'slip_code'.tr}: ',
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
                  if (post.text != null) const SizedBox(height: 10),
                  if (post.images != null && post.images!.isNotEmpty)
                    TimelineImageDivider(images: post.images!, token: bController.userToken.value),
                  if (hideButtons == false)
                    PostActionButtons(
                      item: post,
                      onLike: onLike,
                      onComment: onComment,
                      onDislike: onDislike,
                      onShare: onShare,
                      onRepost: onRepost,
                    ),
                  if (sponsored == true) ...<Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Ionicons.arrow_redo_circle, size: 10, color: context.colors.textDark),
                        Text(
                          ' Sponsored',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: context.colors.textDark),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (hideButtons == true && sponsored == false) const SizedBox(height: 16)
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
