import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/betticos/presentation/timeline/widgets/profile_optoins_modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../getx/profile_controller.dart';
import '../screens/update_profile_screen.dart';
import 'column_text_button.dart';
import 'profile_image_stack.dart';

class ProfileFlexibleAppBar extends StatefulWidget {
  const ProfileFlexibleAppBar({super.key, required this.user, this.showBackButton});
  final User user;
  final bool? showBackButton;

  @override
  State<ProfileFlexibleAppBar> createState() => _ProfileFlexibleAppBarState();
}

class _ProfileFlexibleAppBarState extends State<ProfileFlexibleAppBar> {
  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

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
                  const Spacer(),
                  if (widget.user.id == bController.user.value.id)
                    IconButton(
                      onPressed: () => showBarModalBottomSheet<void>(
                        animationCurve: Curves.fastLinearToSlowEaseIn,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
                        ),
                        context: context,
                        builder: (_) => ClipRRect(
                          borderRadius:
                              const BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
                          child: ProfileOptionsModalBottom(),
                        ),
                      ),
                      icon: const Icon(Ionicons.menu_sharp, color: Colors.black, size: 20),
                    ),
                ],
              ),
              if (widget.user.role == 'oddster')
                Align(child: Icon(Ionicons.star_sharp, color: context.colors.secondary)),
              const AppSpacing(v: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ColumnTextButton(title: 'following'.tr, count: '${widget.user.following}'),
                  ProfileImageStack(user: widget.user),
                  ColumnTextButton(title: 'followers'.tr, count: '${widget.user.followers}', isFollowers: true),
                ],
              ),
              const AppSpacing(v: 20),
              _ProfileNameSection(user: widget.user),
              const AppSpacing(v: 10),
              Padding(
                padding: AppPaddings.lH,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    if (widget.user.id == bController.user.value.id)
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
                    if (widget.user.id != bController.user.value.id)
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
                    if (widget.user.id != bController.user.value.id && (widget.user.role == 'oddster'))
                      OutlinedButton(
                        onPressed: () => controller.subscribeToTheUser(context, widget.user.id),
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
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => UpdateProfileScreen(user: widget.user)),
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
  const _ProfileNameSection({required this.user});

  final User user;

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
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const AppSpacing(h: 5),
            if (user.role == 'admin') Image.asset(AssetImages.verified, height: 14, width: 14),
          ],
        ),
        Text(
          '@${user.username}',
          style: TextStyle(color: context.colors.text, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
