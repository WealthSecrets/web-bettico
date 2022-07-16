import 'package:betticos/features/responsiveness/vertical_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'horizontal_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem(
      {Key? key, required this.name, required this.route, required this.onTap})
      : super(key: key);

  final String name;
  final String route;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HorizontalMenuItem(name: name, route: route, onTap: onTap),
      desktop: HorizontalMenuItem(name: name, route: route, onTap: onTap),
      tablet: VerticalMenuItem(name: name, route: route, onTap: onTap),
    );
  }
}
