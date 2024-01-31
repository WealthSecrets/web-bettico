import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isHome = navigationController.currentRoute.value == AppRoutes.timeline ||
          navigationController.currentRoute.value == AppRoutes.home ||
          navigationController.currentRoute.value == AppRoutes.explore;
      final IconData icon = !isHome ? Icons.arrow_back : Icons.menu;
      return Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                if (isHome) {
                  scaffoldKey.currentState?.openDrawer();
                } else {
                  navigationController.goBack();
                }
              },
              icon: Icon(icon, color: context.colors.textDark),
            ),
            Image.asset(AssetImages.logo, height: 25, width: 25),
            IconButton(onPressed: () {}, icon: const SizedBox()),
          ],
        ),
      );
    });
  }
}
