import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ReactionType { follows, like, reposted, share }

class ReactionNotificationCard extends StatelessWidget {
  ReactionNotificationCard({super.key, required this.reactionType});

  final ReactionType reactionType;

  final User user = Get.find<BaseScreenController>().user.value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.lA,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => navigationController.navigateTo(
              AppRoutes.profile,
              arguments: ProfileScreenArgument(user: user, showBackButton: true),
            ),
            child: Container(
              height: 35,
              width: 35,
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
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Blankson',
                    style: context.sub2.copyWith(color: context.colors.black, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '@blanksonR',
                    style: context.sub2.copyWith(color: context.colors.darkenText),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '3h',
                    style: context.sub2.copyWith(color: context.colors.darkenText),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  Image.asset(
                    reactionType == ReactionType.follows ? AppAssetIcons.userPlus : AppAssetIcons.thumbsUpSolid,
                    height: 15,
                    width: 15,
                    color: reactionType == ReactionType.follows ? null : Colors.red,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    reactionType == ReactionType.follows ? 'Follows you' : 'Liked your post',
                    style:
                        context.caption.copyWith(color: context.colors.textInputIconColor, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          if (reactionType == ReactionType.follows) ...<Widget>[
            const Spacer(),
            SelectableButton(text: 'Follow back', onPressed: () {}, selected: true),
          ],
        ],
      ),
    );
  }
}
