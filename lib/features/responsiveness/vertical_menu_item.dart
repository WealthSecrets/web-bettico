import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/web_controller.dart';

class VerticalMenuItem extends StatelessWidget {
  const VerticalMenuItem({
    Key? key,
    required this.name,
    required this.route,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String route;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    // final double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (bool value) {
        value
            ? menuController.onHover(route)
            : menuController.onHover('not hovering');
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: menuController.isHovering(route)
                ? context.colors.lightGrey
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: menuController.returnIconFor(route),
        ),
      ),
    );
  }
}
