import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'option_inkwell.dart';

class ProfileOptionsModalBottom extends StatelessWidget {
  ProfileOptionsModalBottom({super.key});

  final BaseScreenController controller = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () {
          final User user = controller.user.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OptionInkwell(
                onTap: () {
                  Navigator.of(context).pop();
                  if (user.isBusiness == true) {
                    navigationController.navigateTo(AppRoutes.professionalDashboard);
                  } else {
                    navigationController.navigateTo(AppRoutes.onboard);
                  }
                },
                iconData: Ionicons.people_sharp,
                title: 'Professional account',
              ),
              Divider(color: context.colors.cardColor, height: 0),
              OptionInkwell(
                onTap: () => navigationController.navigateTo(AppRoutes.settings),
                iconData: Ionicons.settings_sharp,
                title: 'Settings',
              ),
            ],
          );
        },
      ),
    );
  }
}
