import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'option_inkwell.dart';

class ProfileOptionsModalBottom extends StatelessWidget {
  const ProfileOptionsModalBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          OptionInkwell(
            onTap: () => Get.toNamed(AppRoutes.onboard),
            iconData: Ionicons.people_sharp,
            title: 'Professional account',
          ),
          Divider(color: context.colors.text, height: 0),
          OptionInkwell(onTap: () {}, iconData: Ionicons.settings_sharp, title: 'Settings'),
        ],
      ),
    );
  }
}
