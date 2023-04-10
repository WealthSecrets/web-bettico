import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

Widget topNavigationBar(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return Container(
    height: 56,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: context.colors.textDark,
          ),
        ),
        Image.asset(
          AssetImages.logo,
          height: 25,
          width: 25,
        ),
        IconButton(onPressed: () {}, icon: const SizedBox()),
      ],
    ),
  );
}
