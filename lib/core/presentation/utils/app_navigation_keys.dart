import 'package:flutter/material.dart';

class AppNavigationKeys {
  AppNavigationKeys._();
  static final GlobalKey<NavigatorState> rootNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'rootNavKey');
  static final GlobalKey<NavigatorState> homeNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeNavKey');
  static final GlobalKey<NavigatorState> authNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'authNavKey');
}
