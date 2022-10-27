import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

import '../../core/presentation/helpers/responsiveness.dart';
import 'custom_text.dart';

AppBar topNavigationBar(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    elevation: 0,
    leading: ResponsiveWidget.isSmallScreen(context)
        ? IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          )
        : null,
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (ResponsiveWidget.isSmallScreen(context))
          CustomText(
            text: 'Bettico',
            color: context.colors.textDark,
            size: 20,
            weight: FontWeight.bold,
          ),
        Stack(
          children: <Widget>[
            Icon(
              Icons.notifications,
              color: context.colors.textDark.withOpacity(.7),
            ),
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 12,
                height: 12,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: context.colors.lightGrey,
                    width: 2,
                  ),
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    iconTheme: IconThemeData(color: context.colors.textDark),
  );
}
