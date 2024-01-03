import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  const HorizontalMenuItem({super.key, required this.name, required this.route, required this.onTap});

  final String name;
  final String route;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: onTap,
          onHover: (bool value) {
            value ? menuController.onHover(route) : menuController.onHover('not hovering');
          },
          borderRadius: BorderRadius.circular(30),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: menuController.isHovering(route) || menuController.isActive(route)
                  ? context.colors.lightGrey
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: menuController.returnIconFor(route),
                ),
                Flexible(
                  child: CustomText(
                    text: name,
                    color: context.colors.textDark,
                    size: !menuController.isActive(route) ? 15 : 16,
                    weight: !menuController.isActive(route) ? FontWeight.w600 : FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
