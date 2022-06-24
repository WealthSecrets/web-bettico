import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/web_controller.dart';
import 'custom_text.dart';

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
          color: menuController.isHovering(route)
              ? context.colors.lightGrey
              : Colors.transparent,
          child: Row(
            children: <Widget>[
              Visibility(
                visible: menuController.isHovering(route) ||
                    menuController.isActive(route),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                child: Container(
                  width: 6,
                  height: 72,
                  color: context.colors.textDark,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: menuController.returnIconFor(route),
                    ),
                    if (!menuController.isActive(route))
                      Flexible(
                        child: CustomText(
                          text: name,
                          color: menuController.isHovering(route)
                              ? context.colors.textDark
                              : context.colors.lightGrey,
                        ),
                      )
                    else
                      Flexible(
                        child: CustomText(
                          text: name,
                          color: context.colors.textDark,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
