import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import 'horizontal_menu_item.dart';
import 'vertical_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.name, required this.route, required this.onTap});

  final String name;
  final String route;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context)) {
      return VerticalMenuItem(name: name, route: route, onTap: onTap);
    }

    return HorizontalMenuItem(name: name, route: route, onTap: onTap);
  }
}
