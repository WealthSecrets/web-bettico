import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class UserListScreen extends GetWidget<ProfileController> {
  UserListScreen({super.key, this.theUser, this.isFollowers = true});
  final User? theUser;
  final bool isFollowers;

  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back, color: Colors.black),
          onPressed: () => Get.back<void>(),
        ),
        title: Text(isFollowers ? 'followers'.tr : 'following'.tr),
        centerTitle: false,
      ),
      body: (isFollowers ? controller.myFollowers.isEmpty : controller.myFollowings.isEmpty)
          ? AppEmptyScreen(message: 'no_followers'.tr)
          : ListView.separated(
              padding: AppPaddings.lA,
              itemCount: isFollowers ? controller.myFollowers.length : controller.myFollowings.length,
              itemBuilder: (BuildContext context, int index) {
                return isFollowers
                    ? _buildListUserRow(
                        context,
                        controller.myFollowers[index],
                        () => null,
                      )
                    : _buildListUserRow(
                        context,
                        controller.myFollowings[index],
                        () => null,
                      );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
    );
  }

  Widget _buildListUserRow(BuildContext context, User user, Function() onPressed) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            final User? thePreviousUser = await Navigator.of(context).push<User>(
              MaterialPageRoute<User>(
                builder: (BuildContext context) => ProfileScreen(user: user, showBackButton: true),
              ),
            );

            if (thePreviousUser != null) {
              controller.setProfileUser(
                thePreviousUser,
                performActions: true,
              );
            } else {
              controller.setProfileUser(
                bController.user.value,
                performActions: true,
              );
            }
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image:
                  DecorationImage(image: NetworkImage('${AppEndpoints.userImages}/${user.photo}'), fit: BoxFit.cover),
            ),
          ),
        ),
        const AppSpacing(h: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName}',
                style: context.body2.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                '@${user.username}',
                style: context.caption.copyWith(color: context.colors.grey),
              ),
              const AppSpacing(v: 5),
            ],
          ),
        ),
        if (user.id != bController.user.value.id)
          OutlinedButton(
            onPressed: () {
              if (controller.isFollowedByLoggedInUser(user.id)) {
                controller.unfollowTheUser(u: user);
              } else {
                controller.followTheUser(u: user);
              }
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              backgroundColor: controller.isFollowedByLoggedInUser(
                user.id,
              )
                  ? context.colors.primary
                  : Colors.white,
              side: BorderSide(
                width: 2.0,
                color: controller.isFollowedByLoggedInUser(user.id) ? context.colors.primary : context.colors.cardColor,
              ),
            ),
            child: Text(
              controller.isFollowedByLoggedInUser(user.id) ? 'following'.tr : 'follow'.tr,
              style: context.caption.copyWith(
                color: controller.isFollowedByLoggedInUser(user.id) ? Colors.white : context.colors.textDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
