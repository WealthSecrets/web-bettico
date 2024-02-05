import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key, required this.scaffoldKey, this.title});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? title;

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
            if (title != null)
              Text(
                title!,
                style: context.body1
                    .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0.2, color: const Color(0xFF272E35)),
              )
            else
              Image.asset(AssetImages.logo, height: 25, width: 25),
            IconButton(onPressed: () {}, icon: const SizedBox()),
          ],
        ),
      );
    });
  }
}
