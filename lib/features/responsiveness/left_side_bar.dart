import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
// import 'package:betticos/features/responsiveness/side_menu.dart';
import 'package:betticos/features/responsiveness/side_menu_item.dart';
// import 'package:betticos/core/presentation/web_controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';

import '../../core/presentation/helpers/responsiveness.dart';
import '../../core/presentation/routes/side_menu_routes.dart'
    as side_menu_routes;
import '../../core/presentation/utils/app_endpoints.dart';
import '../betticos/presentation/timeline/screens/timeline_post_screen.dart';
import 'constants/web_controller.dart';
import 'custom_text.dart';

class LeftSideBar extends StatelessWidget {
  LeftSideBar({Key? key}) : super(key: key);
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return ListView(
      padding: AppPaddings.lA,
      children: <Widget>[
        if (!ResponsiveWidget.isSmallScreen(context))
          _buildUserInfoContainer(context),
        const SizedBox(height: 8),
        if (ResponsiveWidget.isSmallScreen(context))
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 40),
              Row(
                children: <Widget>[
                  SizedBox(width: _width / 48),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  Flexible(
                    child: CustomText(
                      text: 'Bettico',
                      size: 20,
                      weight: FontWeight.bold,
                      color: context.colors.primary,
                    ),
                  ),
                  SizedBox(width: _width / 48),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        Divider(color: context.colors.lightGrey.withOpacity(.1)),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: side_menu_routes.sideMenuItemRoutes
              .map(
                (side_menu_routes.MenuItem item) => SideMenuItem(
                  name: item.name,
                  route: item.route,
                  onTap: () {
                    if (item.route == AppRoutes.login) {
                      showLogoutDialog(context);
                      // menuController.changeActiveItemTo(AppRoutes.timeline);
                    }
                    if (!menuController.isActive(item.route)) {
                      menuController.changeActiveItemTo(item.route);
                      if (ResponsiveWidget.isSmallScreen(context)) {
                        Get.back<void>();
                      }
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

  Widget _buildUserInfoContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPaddings.lH.add(AppPaddings.mV),
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: const <BoxShadow>[
        //   BoxShadow(
        //     blurRadius: 5,
        //     color: Colors.black12,
        //     offset: Offset(0, 1),
        //   )
        // ],
        border: Border.all(
          color: context.colors.faintGrey,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: AppBorderRadius.largeAll,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Obx(
            () => GestureDetector(
              onTap: () => navigationController.navigateTo(AppRoutes.login),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${AppEndpoints.userImages}/${bController.user.value.photo}',
                      headers: <String, String>{
                        'Authorization': 'Bearer ${bController.userToken.value}'
                      },
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Obx(
            () => Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text(
                    '${bController.user.value.firstName} ${bController.user.value.lastName}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '@${bController.user.value.username}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.colors.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showAppModal<void>(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: SizedBox(
                      width: 600,
                      height: 500,
                      child: ClipRRect(
                        borderRadius: AppBorderRadius.mediumAll,
                        child: const TimelinePostScreen(),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 30,
              padding: AppPaddings.lH.add(AppPaddings.mV),
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text(
                  'Post',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          height: 400,
          child: AppOptionDialogueModal(
            modalContext: context,
            title: 'logout'.tr,
            iconData: Ionicons.log_out_outline,
            backgroundColor: context.colors.error,
            message: 'sure_logout'.tr,
            affirmButtonText: 'logout'.tr.toUpperCase(),
            onPressed: () => baseScreenController.logOutTheUser(context),
          ),
        ),
      ),
    );
  }

  // Widget _buildButtonColumnCards(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           _buildCustomButton(
  //             context,
  //             'TIMELINE',
  //             Ionicons.time_outline,
  //             onTap: () {
  //               navigationController.navigateTo(AppRoutes.timeline);
  //             },
  //           ),
  //           _buildCustomButton(
  //             context,
  //             'UPDATES',
  //             Ionicons.thunderstorm_outline,
  //             onTap: () {
  //               navigationController.navigateTo(AppRoutes.updates);
  //             },
  //           ),
  //         ],
  //       ),
  //       const AppSpacing(v: 8),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           _buildCustomButton(
  //             context,
  //             'ODDBOXES',
  //             Ionicons.football_outline,
  //             onTap: () {
  //               navigationController.navigateTo(AppRoutes.oddboxes);
  //             },
  //           ),
  //           _buildCustomButton(
  //             context,
  //             'PROMOS',
  //             Ionicons.megaphone_outline,
  //             onTap: () {},
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Widget _buildCardButton(BuildContext context, String text, IconData icon,
  //     {Function()? onTap}) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         boxShadow: const <BoxShadow>[
  //           BoxShadow(
  //             blurRadius: 5,
  //             color: Colors.black12,
  //             offset: Offset(0, 1),
  //           )
  //         ],
  //         borderRadius: AppBorderRadius.smallAll,
  //       ),
  //       height: 90,
  //       width: 130,
  //       child: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(
  //               icon,
  //               size: 24,
  //               color: context.colors.primary,
  //             ),
  //             const SizedBox(height: 5),
  //             Text(
  //               text,
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w600,
  //                 color: context.colors.textDark,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCustomButton(BuildContext context, String text, IconData icon,
  //     {Function()? onTap}) {
  //   return SizedBox(
  //     height: 90,
  //     width: 130,
  //     child: TextButton(
  //       onPressed: onTap,
  //       child: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(
  //               icon,
  //               size: 24,
  //               color: context.colors.primary,
  //             ),
  //             const SizedBox(height: 5),
  //             Text(
  //               text,
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w600,
  //                 color: context.colors.textDark,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildIconInfo(BuildContext context, String text, IconData icon) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: <Widget>[
  //       Icon(
  //         icon,
  //         color: Colors.black,
  //         size: 18,
  //       ),
  //       const SizedBox(width: 8),
  //       Text(
  //         text,
  //         style: TextStyle(
  //           fontSize: 12,
  //           color: context.colors.text,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
