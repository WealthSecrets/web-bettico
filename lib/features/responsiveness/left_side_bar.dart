import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
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
  const LeftSideBar({Key? key, required this.userToken, required this.user})
      : super(key: key);
  final String userToken;
  final User user;

  @override
  State<LeftSideBar> createState() => _LeftSideBarState();
}

class _LeftSideBarState extends State<LeftSideBar> {
  @override
  Widget build(BuildContext context) {
    final List<SideMenuItem> sideMenuItems = getSideMenuItems(widget.userToken);
    final EdgeInsetsGeometry padding = isLargeScreen
        ? const EdgeInsets.symmetric(vertical: 24, horizontal: 16)
        : const EdgeInsets.symmetric(vertical: 24);
    return ListView(
      padding: padding,
      children: <Widget>[
        if (isLargeScreen && widget.userToken.isNotEmpty) ...<Widget>[
          UserInfoContainer(),
          const SizedBox(height: 8),
        ],
        if (!isSmallScreen && widget.userToken.isEmpty) ...<Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 16),
              Image.asset(AssetImages.logo, height: 30, width: 30),
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (isSmallScreen && widget.userToken.isNotEmpty) ...<Widget>[
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
                              '${AppEndpoints.userImages}/${widget.user.photo}',
                              headers: <String, String>{
                                'Authorization': 'Bearer ${widget.userToken}',
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
                          _UserColumnButton(
                              context: context,
                              title: 'Following',
                              subtitle: '${widget.user.following}',
                              onPressed: () {}),
                          _UserColumnButton(
                              context: context,
                              title: 'Followers',
                              subtitle: '${widget.user.followers}',
                              onPressed: () {}),
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
                            '${widget.user.firstName} ${widget.user.lastName}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.user.isVerified)
                            Image.asset(
                              AssetImages.verified,
                              height: 14,
                              width: 14,
                            ),
                        ],
                      ),
                      Text(
                        '@${widget.user.username}',
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
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);

  bool get isLargeScreen => ResponsiveWidget.isLargeScreen(context);

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
    final BaseScreenController controller = Get.find<BaseScreenController>();
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) => Obx(
        () => AppLoadingBox(
          loading: controller.isLoggingOut.value,
          child: SizedBox(
            width: 500,
            height: 300,
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

class _UserColumnButton extends StatelessWidget {
  const _UserColumnButton({
    Key? key,
    required this.context,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String subtitle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
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
}
