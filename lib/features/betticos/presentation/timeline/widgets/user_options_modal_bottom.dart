import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/presentation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class UserOptionsModalBottom extends StatelessWidget {
  UserOptionsModalBottom({super.key, required this.ctx, this.post, this.user});
  final BuildContext ctx;
  final Post? post;
  final User? user;

  final CardController controller = Get.find<CardController>();
  final ReportController rController = Get.find<ReportController>();
  final AdsController adsController = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(() {
        final User loggedInUser = Get.find<BaseScreenController>().user.value;
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (loggedInUser.id != post!.user.id)
                InkWell(
                  child: Padding(
                    padding: AppPaddings.bodyH.add(AppPaddings.lV),
                    child: Row(
                      children: <Widget>[
                        Icon(Ionicons.person_remove_outline, color: context.colors.text, size: 24),
                        const AppSpacing(h: 16),
                        Text(
                          post != null
                              ? '${'unfollow'.tr}  @${post!.user.username}'
                              : '${'unfollow'.tr}  @${user!.username}',
                          style: context.body2.copyWith(color: context.colors.text, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Get.back<void>(),
                ),
              if (loggedInUser.id != post!.user.id)
                InkWell(
                  onTap: () => Get.back<void>(),
                  child: Padding(
                    padding: AppPaddings.bodyH.add(AppPaddings.lV),
                    child: Row(
                      children: <Widget>[
                        Icon(Ionicons.volume_mute_outline, color: context.colors.text, size: 24),
                        const AppSpacing(h: 16),
                        Text(
                          post != null ? '${'mute'.tr} @${post!.user.username}' : '${'mute'.tr}  @${user!.username}',
                          style: context.body2.copyWith(color: context.colors.text, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              if (loggedInUser.id != post!.user.id)
                InkWell(
                  onTap: () {
                    Get.back<void>();
                    if (user != null) {
                      controller.blockTheUser(context, user!.id);
                    } else if (post != null) {
                      controller.blockTheUser(context, post!.user.id);
                    }
                  },
                  child: Padding(
                    padding: AppPaddings.bodyH.add(AppPaddings.lV),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Ionicons.ban_outline,
                          color: context.colors.text,
                          size: 24,
                        ),
                        const AppSpacing(h: 16),
                        Text(
                          post != null ? '${'block'.tr} @${post!.user.username}' : '${'block'.tr} @${user!.username}',
                          style: context.body2.copyWith(color: context.colors.text, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              if (loggedInUser.id != post!.user.id)
                InkWell(
                  onTap: () {
                    rController.navigateToAddReport(
                      ctx,
                      post != null ? 'post' : 'user',
                      postId: post?.id,
                      userId: user?.id,
                    );
                  },
                  child: Padding(
                    padding: AppPaddings.bodyH.add(AppPaddings.lV),
                    child: Row(
                      children: <Widget>[
                        Icon(Ionicons.flag_outline, color: context.colors.text, size: 24),
                        const AppSpacing(h: 16),
                        Text(
                          post != null ? 'report_post'.tr : 'report_user'.tr,
                          style: context.body2.copyWith(color: context.colors.text, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              if ((loggedInUser.id == post!.user.id) && post != null)
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    controller.deleteUserPost(ctx, post!.id);
                  },
                  child: Padding(
                    padding: AppPaddings.bodyH.add(AppPaddings.lV),
                    child: Row(
                      children: <Widget>[
                        Icon(Ionicons.trash_outline, color: context.colors.text, size: 24),
                        const AppSpacing(h: 16),
                        Text(
                          'Delete ${post!.isOddbox ? 'Oddbox' : 'Post'}',
                          style: context.body2.copyWith(color: context.colors.text, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              if (loggedInUser.isBusiness == true &&
                  ((loggedInUser.id == post!.user.id) && post != null && post!.boosted == false))
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    navigationController.navigateTo(AppRoutes.adsProces);
                    adsController.post.value = post!;
                  },
                  child: Padding(
                    padding: AppPaddings.bodyH.add(AppPaddings.lV),
                    child: Row(
                      children: <Widget>[
                        Icon(Ionicons.barbell_sharp, color: context.colors.text, size: 24),
                        const AppSpacing(h: 16),
                        Text(
                          'Boost ${post!.isOddbox ? 'Oddbox' : 'Post'}',
                          style: context.body2.copyWith(color: context.colors.text, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              if (loggedInUser.isBusiness == true &&
                  ((loggedInUser.id == post!.user.id) && post != null && post!.boosted == true))
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    navigationController.navigateTo(
                      AppRoutes.adAnalytics,
                      arguments: AdAnalyticsScreenRouteArgument(post: post!),
                    );
                  },
                  child: Padding(
                    padding: AppPaddings.bodyH.add(AppPaddings.lV),
                    child: Row(
                      children: <Widget>[
                        Icon(Ionicons.analytics, color: context.colors.text, size: 24),
                        const AppSpacing(h: 16),
                        Text(
                          'Ad Analytics',
                          style: context.body2.copyWith(color: context.colors.text, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
