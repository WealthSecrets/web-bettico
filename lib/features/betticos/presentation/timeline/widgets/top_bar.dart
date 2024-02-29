import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.timelineController, this.args});

  final TimelineController timelineController;
  final AddPostCommentArgument? args;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                timelineController.resetValuesAfterPost();
                Get.back();
              },
              child: Image.asset(AppAssetIcons.closeFrame, height: 32, width: 32),
            ),
            const Spacer(),
            ProfileButton(
              onPressed: () => WidgetUtils.showOptionsBottomSheet(
                context,
                options: <OptionArgument>[
                  OptionArgument(icon: AppAssetIcons.globeGrad, title: 'Public', onPressed: () {}),
                  OptionArgument(icon: AppAssetIcons.pinGrad, title: 'Subscribers', onPressed: () {}),
                ],
                title: 'Choose Audience',
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Image.asset(AppAssetIcons.globe, height: 16, width: 16, color: context.colors.primary),
                  const SizedBox(width: 4),
                  Text(
                    'Public',
                    style: TextStyle(
                      letterSpacing: 0.2,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ProfileButton(
              onPressed: () {
                if (!timelineController.timelineIsInvalid) {
                  if (args != null && args?.isReply == true) {
                    timelineController.addNewPost(context, isReply: true, postId: args!.post.id);
                  } else if (args != null && (args?.isReply == false || args?.isReply == null)) {
                    timelineController.addNewRepost(context, postId: args!.post.id);
                  } else {
                    timelineController.addNewPost(context);
                  }
                }
              },
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              backgroundColor:
                  timelineController.timelineIsInvalid ? context.colors.primary.shade200 : context.colors.primary,
              borderColor:
                  timelineController.timelineIsInvalid ? context.colors.primary.shade200 : context.colors.primary,
              child: const Text(
                'Post',
                style: TextStyle(
                  letterSpacing: 0.2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
