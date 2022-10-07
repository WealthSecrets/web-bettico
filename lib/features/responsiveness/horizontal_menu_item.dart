import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/web_controllers/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  HorizontalMenuItem({
    Key? key,
    required this.name,
    required this.route,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String route;
  final void Function() onTap;

  final MenuController menuController = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (bool value) {
        value ? menuController.onHover(route) : menuController.onHover('not hovering');
      },
      borderRadius: BorderRadius.circular(30),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: menuController.isHovering(route) ? context.colors.lightGrey.withOpacity(.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Visibility(
              //   visible: menuController.isHovering(route) ||
              //       menuController.isActive(route),
              //   maintainSize: true,
              //   maintainState: true,
              //   maintainAnimation: true,
              //   child: Container(
              //     width: 6,
              //     height: 40,
              //     color: context.colors.textDark,
              //   ),
              // ),
              // SizedBox(width: _width / 80),
              Padding(
                padding: const EdgeInsets.all(16),
                child: menuController.returnIconFor(route),
              ),
              // if (!menuController.isActive(route))
              Flexible(
                child: CustomText(
                  text: name,
                  color: context.colors.textDark,
                  size: !menuController.isActive(route) ? 15 : 16,
                  weight: !menuController.isActive(route) ? FontWeight.w600 : FontWeight.bold,
                ),
              )
              // else
              //   Flexible(
              //     child: CustomText(
              //       text: name,
              //       color: context.colors.textDark,
              //       size: 19,
              //       weight: FontWeight.bold,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
