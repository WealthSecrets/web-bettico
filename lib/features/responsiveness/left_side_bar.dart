import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/responsiveness/side_menu_item.dart';
import 'package:betticos/features/responsiveness/user_info_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/presentation/helpers/responsiveness.dart';
import '../../core/presentation/routes/side_menu_routes.dart';
import '../../core/presentation/utils/app_endpoints.dart';
import 'constants/web_controller.dart';

class LeftSideBar extends StatefulWidget {
  const LeftSideBar({Key? key}) : super(key: key);

  @override
  State<LeftSideBar> createState() => _LeftSideBarState();
}

class _LeftSideBarState extends State<LeftSideBar> {
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final String userToken = bController.userToken.value;
      final List<SideMenuItem> sideMenuItems = getSideMenuItems(userToken);
      return ListView(
        padding: AppPaddings.lA,
        children: <Widget>[
          if (!isSmallScreen && userToken.isNotEmpty) ...<Widget>[
            UserInfoContainer(),
            const SizedBox(height: 8),
          ],
          if (isSmallScreen && userToken.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${AppEndpoints.userImages}/${bController.user.value.photo}',
                                headers: <String, String>{
                                  'Authorization':
                                      'Bearer ${bController.userToken.value}',
                                },
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildUserColumnButton(
                              'Following',
                              '${bController.user.value.following}',
                              () {},
                            ),
                            _buildUserColumnButton(
                              'Followers',
                              '${bController.user.value.followers}',
                              () {},
                            ),
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '${bController.user.value.firstName} ${bController.user.value.lastName}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (bController.user.value.isVerified)
                              Image.asset(
                                AssetImages.verified,
                                height: 14,
                                width: 14,
                              ),
                          ],
                        ),
                        Text(
                          '@${bController.user.value.username}',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colors.text,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          Divider(color: context.colors.lightGrey.withOpacity(.1)),
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
                      } else if (!menuController.isActive(item.route)) {
                        menuController.changeActiveItemTo(item.route);
                        navigationController.navigateTo(item.route);
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

  Widget _buildUserColumnButton(
    String title,
    String subtitle,
    Function()? onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: context.colors.text,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: context.colors.textDark,
            ),
          )
        ],
      ),
    );
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);

  List<SideMenuItem> getSideMenuItems(String userToken) => userToken.isEmpty
      ? notLoggedInMenuItems
      : isSmallScreen
          ? smallScreenMenuItems
          : sideMenuItemRoutes;

  void showLogoutDialog(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => Center(
        child: SizedBox(
          width: 500,
          child: AppOptionDialogueModal(
            modalContext: context,
            title: 'logout'.tr,
            iconData: Ionicons.log_out_outline,
            backgroundColor: context.colors.error,
            message: 'sure_logout'.tr,
            affirmButtonText: 'logout'.tr.toUpperCase(),
            onPressed: () {
              Navigator.of(context).pop();
              bController.logOutTheUser(context);
            },
          ),
        ),
      ),
    );
  }
}
