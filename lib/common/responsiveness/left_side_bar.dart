import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LeftSideBar extends StatefulWidget {
  const LeftSideBar({super.key});

  @override
  State<LeftSideBar> createState() => _LeftSideBarState();
}

class _LeftSideBarState extends State<LeftSideBar> {
  final BaseScreenController baseScreenController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final User user = baseScreenController.user.value;
      final String userToken = baseScreenController.userToken.value;
      final List<SideMenuItem> sideMenuItems = getSideMenuItems(userToken);
      return ListView(
        children: <Widget>[
          if (isLargeScreen && userToken.isNotEmpty) ...<Widget>[
            UserInfoContainer(),
            const SizedBox(height: 8),
          ],
          if (!isSmallScreen && userToken.isEmpty) ...<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 16),
                Image.asset(AssetImages.logo, height: 30, width: 30),
              ],
            ),
            const SizedBox(height: 16),
          ],
          if (isSmallScreen && userToken.isNotEmpty) ...<Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 52.44,
                        width: 52.44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
                              // headers: <String, String>{'Authorization': 'Bearer ${userToken}'},
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF272E35),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (user.isVerified) ...<Widget>[
                                const SizedBox(width: 10),
                                Image.asset(AssetImages.verified, height: 14, width: 14)
                              ],
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '@${user.username}',
                            style: context.sub2.copyWith(fontWeight: FontWeight.w400, color: const Color(0xFF272E35)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Text(
                            '${user.following} Following',
                            style: context.sub2.copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF272E35)),
                          ),
                          const SizedBox(width: 22),
                          Text(
                            '${user.followers} Followers',
                            style: context.sub2.copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF272E35)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Divider(color: context.colors.dividerColor),
          ],
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map(
                  (SideMenuItem item) => SideMenu(
                    name: item.name,
                    route: item.route,
                    onTap: () {
                      if (isSmallScreen) {
                        Navigator.of(context).pop();
                      }
                      if (item.route == AppRoutes.logout) {
                        showLogoutDialog(context);
                      } else {
                        menuController.changeActiveItemTo(item.route);
                        if (item.route == AppRoutes.profile) {
                          navigationController.navigateTo(
                            item.route,
                            arguments: ProfileScreenArgument(user: user),
                          );
                        } else {
                          navigationController.navigateTo(item.route);
                        }
                      }
                    },
                  ),
                )
                .toList(),
          )
        ],
      );
    });
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);

  bool get isCustomScreen => ResponsiveWidget.isCustomSize(context);

  bool get isMediumScreen => ResponsiveWidget.isMediumScreen(context);

  bool get isLargeScreen => ResponsiveWidget.isLargeScreen(context);

  List<SideMenuItem> getSideMenuItems(String userToken) {
    List<SideMenuItem> menuItems = <SideMenuItem>[explore, settings];
    if (userToken.isNotEmpty) {
      if (isSmallScreen) {
        menuItems = <SideMenuItem>[profile, referral, settings, logout];
      } else {
        menuItems = <SideMenuItem>[timeline, explore, profile, messages, games, reels, referral, settings, logout];
      }
    }

    return menuItems;
  }

  EdgeInsetsGeometry get padding => isLargeScreen
      ? const EdgeInsets.symmetric(vertical: 24, horizontal: 16)
      : const EdgeInsets.symmetric(vertical: 24, horizontal: 8);

  void showLogoutDialog(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    final BaseScreenController controller = Get.find<BaseScreenController>();
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => Obx(
        () => AppLoadingBox(
          loading: controller.isLoggingOut.value,
          child: Container(
            width: 500,
            height: 300,
            margin: isSmallScreen ? AppPaddings.lH : null,
            child: Center(
              child: AppOptionDialogueModal(
                modalContext: context,
                title: 'logout'.tr,
                iconData: Ionicons.log_out_outline,
                backgroundColor: context.colors.error,
                message: 'sure_logout'.tr,
                affirmButtonText: 'logout'.tr.toUpperCase(),
                onPressed: () => controller.logOutTheUser(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
