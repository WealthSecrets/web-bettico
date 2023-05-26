import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../getx/profile_controller.dart';
import '../screens/update_profile_screen.dart';
import 'column_text_button.dart';
import 'profile_image_stack.dart';

class ProfileFlexibleAppBar extends StatefulWidget {
  const ProfileFlexibleAppBar({super.key, this.user, this.showBackButton});
  final User? user;
  final bool? showBackButton;

  @override
  State<ProfileFlexibleAppBar> createState() => _ProfileFlexibleAppBarState();
}

class _ProfileFlexibleAppBarState extends State<ProfileFlexibleAppBar> {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Padding(
        padding: AppPaddings.lH.add(AppPaddings.lB),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (widget.showBackButton == true)
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Ionicons.arrow_back_sharp, color: Colors.black, size: 20),
                    ),
                ],
              ),
              if (controller.user.value.role == 'oddster')
                Align(child: Icon(Ionicons.star_sharp, color: context.colors.secondary)),
              const AppSpacing(v: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ColumnTextButton(title: 'following'.tr, count: '${controller.user.value.following}'),
                  ProfileImageStack(user: widget.user),
                  ColumnTextButton(
                    title: 'followers'.tr,
                    count: '${controller.user.value.followers}',
                    isFollowers: true,
                  ),
                ],
              ),
              const AppSpacing(v: 20),
              _ProfileNameSection(),
              const AppSpacing(v: 10),
              Padding(
                padding: AppPaddings.lH,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    if (widget.user == null)
                      OutlinedButton(
                        onPressed: () => _handleEditProfile(context),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                          side: BorderSide(width: 2.0, color: context.colors.cardColor),
                        ),
                        child: Text(
                          'edit_profile'.tr,
                          style: TextStyle(color: context.colors.textDark, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    if (widget.user != null && controller.isNotLoggedInUser())
                      OutlinedButton(
                        onPressed: () {
                          if (controller.isFollowedByUser.value) {
                            controller.unfollowTheUser();
                          } else {
                            controller.followTheUser();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                          backgroundColor: controller.isFollowedByUser.value ? context.colors.primary : Colors.white,
                          side: BorderSide(
                            width: 2.0,
                            color:
                                controller.isFollowedByUser.value ? context.colors.primary : context.colors.cardColor,
                          ),
                        ),
                        child: controller.isFollowingUser.value || controller.isUnfollowingUser.value
                            ? SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: controller.isUnfollowingUser.value ? Colors.white : context.colors.primary,
                                ),
                              )
                            : Text(
                                controller.isFollowedByUser.value ? 'following'.tr : 'follow'.tr,
                                style: TextStyle(
                                  color: controller.isFollowedByUser.value ? Colors.white : context.colors.textDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                      ),
                    if (widget.user != null && controller.user.value.role == 'oddster')
                      OutlinedButton(
                        onPressed: () => controller.subscribeToTheUser(context, widget.user!.id),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          backgroundColor: controller.isSubscribedToUser.value ? context.colors.error : Colors.white,
                          side: BorderSide(
                            width: 2.0,
                            color:
                                controller.isSubscribedToUser.value ? context.colors.error : context.colors.cardColor,
                          ),
                        ),
                        child: controller.isSubscribingToUser.value
                            ? SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: controller.isSubscribedToUser.value ? Colors.white : context.colors.error,
                                ),
                              )
                            : Text(
                                controller.isSubscribedToUser.value ? 'subscribed'.tr : 'subscribe'.tr,
                                style: TextStyle(
                                  color: controller.isSubscribedToUser.value ? Colors.white : context.colors.textDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleEditProfile(BuildContext context) async {
    final dynamic value = await Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => UpdateProfileScreen(user: controller.user.value)),
    );

    if (value == true && mounted) {
      await AppSnacks.show(
        context,
        message: 'Profile updated successfully',
        backgroundColor: context.colors.success,
        leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
      );
    }
  }
}

class _ProfileNameSection extends StatelessWidget {
  _ProfileNameSection();

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${controller.user.value.firstName} ${controller.user.value.lastName}',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const AppSpacing(h: 5),
            if (controller.user.value.role == 'admin') Image.asset(AssetImages.verified, height: 14, width: 14),
          ],
        ),
        Text(
          '@${controller.user.value.username}',
          style: TextStyle(color: context.colors.text, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
