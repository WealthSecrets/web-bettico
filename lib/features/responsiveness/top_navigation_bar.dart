import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

import '../../core/presentation/helpers/responsiveness.dart';

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
    title: ResponsiveWidget.isSmallScreen(context)
        ? Image.asset(
            AssetImages.logo,
            height: 25,
            width: 25,
          )
        : null,
    iconTheme: IconThemeData(color: context.colors.textDark),
  );
}
