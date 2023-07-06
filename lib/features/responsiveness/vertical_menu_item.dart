import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/web_controller.dart';

class VerticalMenuItem extends StatelessWidget {
  const VerticalMenuItem({super.key, required this.name, required this.route, required this.onTap});

  final String name;
  final String route;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        onHover: (bool value) {
          value ? menuController.onHover(route) : menuController.onHover('not hovering');
        },
        borderRadius: BorderRadius.circular(40),
        child: Obx(
          () => Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: menuController.isHovering(route) || menuController.isActive(route)
                  ? context.colors.lightGrey
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: menuController.returnIconFor(route),
          ),
        ),
      ),
    );
  }
}
