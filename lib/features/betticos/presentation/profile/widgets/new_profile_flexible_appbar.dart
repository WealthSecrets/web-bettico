import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class NewProfileFlexibleAppBar extends StatefulWidget {
  const NewProfileFlexibleAppBar({super.key, required this.user, this.showBackButton});
  final User user;
  final bool? showBackButton;

  @override
  State<NewProfileFlexibleAppBar> createState() => _ProfileFlexibleAppBarState();
}

class _ProfileFlexibleAppBarState extends State<NewProfileFlexibleAppBar> {
  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  int? followers;
  int? followings;

  @override
  void initState() {
    super.initState();
    followers = widget.user.followers;
    followings = widget.user.following;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final User loggedInUser = bController.user.value;
      return FlexibleSpaceBar(
        background: Padding(
          padding: AppPaddings.lB,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 138,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AssetImages.topbar), fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Row(
                  children: <Widget>[
                    ProfileImageStack(user: widget.user),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.user.firstName} ${widget.user.lastName}',
                          style: TextStyle(color: context.colors.black, fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        if (widget.user.createdAt != null)
                          Text(
                            'Joined since ${AppDateUtils.format(widget.user.createdAt!)}',
                            style:
                                TextStyle(color: context.colors.darkenText, fontWeight: FontWeight.w300, fontSize: 12),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const AppSpacing(v: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Put user bio here',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF3A424A),
                  ),
                ),
              ),
              const AppSpacing(v: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Image.asset(AppAssetIcons.link, height: 15, width: 15),
                    const SizedBox(width: 8),
                    Text(
                      'Place user website here too',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w300,
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: AppPaddings.lH,
                child: Row(
                  children: <Widget>[
                    _RowTextButton(count: '$followings', title: 'Following'),
                    const SizedBox(width: 12),
                    _RowTextButton(count: '$followers', title: 'Followers'),
                  ],
                ),
              ),
              //
              const SizedBox(height: 16),
              _ButtonsRow(
                user: widget.user,
                onFollowPressed: () {
                  if (controller.isFollowedByUser.value) {
                    controller.unfollowTheUser(
                      callback: () => setState(() => followers = followers != null ? followers! - 1 : 0),
                      onFailure: () => setState(() => followers = followers != null ? followers! + 1 : 1),
                    );
                  } else {
                    controller.followTheUser(
                      callback: () => setState(() => followers = followers != null ? followers! + 1 : 1),
                      onFailure: () => setState(() => followers = followers != null ? followers! - 1 : 0),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              Divider(color: context.colors.dividerColor),
              if (widget.user.id != loggedInUser.id && widget.user.isCreator)
                _SubscribeSection(user: widget.user, controller: controller, bController: bController),
            ],
          ),
        ),
      );
    });
  }
}

class _SubscribeSection extends StatelessWidget {
  const _SubscribeSection({required this.user, required this.controller, required this.bController});

  final User user;
  final ProfileController controller;
  final BaseScreenController bController;

  @override
  Widget build(BuildContext context) {
    final String? name = user.firstName ?? user.lastName ?? user.username;
    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        Padding(
          padding: AppPaddings.lH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Subscriptions',
                style: context.body1
                    .copyWith(fontWeight: FontWeight.w600, color: context.colors.darkenText, letterSpacing: 0.1),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const IconCard(imagePath: AppAssetIcons.bookOpen),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Subscribe to $name',
                          style: context.body1.copyWith(
                            color: context.colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "As a subscriber, you'll gain exclusive access to $name's creator contents.",
                          style: context.body2.copyWith(
                            color: const Color(0xFF3A424A),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProfileButton(
                onPressed: () => controller.subscribeToTheUser(context, user.id),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                height: 40,
                width: double.infinity,
                backgroundColor: controller.isSubscribedToUser.value ? context.colors.primary : Colors.white,
                child: controller.isSubscribingToUser.value || controller.isCheckingSubscription.value
                    ? SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: controller.isSubscribedToUser.value ? Colors.white : context.colors.error,
                        ),
                      )
                    : Text(
                        controller.isSubscribedToUser.value
                            ? 'subscribed'.tr.toUpperCase()
                            : 'subscribe'.tr.toUpperCase(),
                        style: context.body1.copyWith(
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500,
                          color: controller.isSubscribedToUser.value ? Colors.white : context.colors.primary,
                        ),
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ButtonsRow extends StatelessWidget {
  _ButtonsRow({required this.user, required this.onFollowPressed});

  final User user;
  final VoidCallback onFollowPressed;

  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    final SizedBox loader = SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: controller.isUnfollowingUser.value ? Colors.white : context.colors.primary,
      ),
    );

    return Obx(
      () {
        final User loggedInUser = bController.user.value;
        return Padding(
          padding: AppPaddings.lH,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (user.id == bController.user.value.id)
                ProfileButton(
                  backgroundColor: const Color(0xFFF6F2FF),
                  borderColor: const Color(0xFFF6F2FF),
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                  onPressed: () => _handleEditProfile(context),
                  child: Row(
                    children: <Widget>[
                      Image.asset(AppAssetIcons.editPencil, height: 20, width: 20, color: context.colors.primary),
                      const SizedBox(width: 10),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                          color: context.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              if (user.id != loggedInUser.id) ...<Widget>[
                ProfileButton(
                  onPressed: () {},
                  child: Image.asset(AppAssetIcons.inboxOut, height: 25, width: 25, color: context.colors.primary),
                ),
                const AppSpacing(h: 10),
                ProfileButton(
                  onPressed: () {},
                  child: Image.asset(AppAssetIcons.bell, height: 25, width: 25, color: context.colors.primary),
                ),
                const AppSpacing(h: 10),
                ProfileButton(
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 56),
                  backgroundColor: controller.isFollowedByUser.value ? context.colors.primary : Colors.white,
                  onPressed: onFollowPressed,
                  child: controller.isFollowingUser.value || controller.isUnfollowingUser.value
                      ? loader
                      : Text(
                          controller.isFollowedByUser.value ? 'following'.tr : 'follow'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                            color: controller.isFollowedByUser.value ? Colors.white : context.colors.primary,
                          ),
                        ),
                ),
                const AppSpacing(h: 10),
                ProfileButton(
                  onPressed: () => WidgetUtils.showVerificationBottomSheet(
                    context,
                    isLoggedInUser: bController.user.value.id == user.id,
                  ),
                  child: Image.asset(AppAssetIcons.star, height: 25, width: 25, color: context.colors.primary),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _handleEditProfile(BuildContext context) async {
    final dynamic value = await Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => UpdateProfileScreen(user: user)),
    );

    if (value == true && context.mounted) {
      await AppSnacks.show(
        context,
        message: 'Profile updated successfully',
        backgroundColor: context.colors.success,
        leadingIcon: const Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
      );
    }
  }
}

class _RowTextButton extends StatelessWidget {
  const _RowTextButton({this.count, required this.title});

  final String? count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          count ?? '0',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.2,
            color: context.colors.black,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.2,
            color: context.colors.icon,
          ),
        ),
      ],
    );
  }
}
