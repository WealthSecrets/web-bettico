import 'package:flutter/material.dart';

class AppNavigationKeys {
  AppNavigationKeys._();

  static final GlobalKey<NavigatorState> rootNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'rootNavKey');
  static final GlobalKey<NavigatorState> homeNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeNavKey');
  static final GlobalKey<NavigatorState> exploreNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'exploreNavKey');
  static final GlobalKey<NavigatorState> tradeNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'tradeNavKey');
  static final GlobalKey<NavigatorState> notificationKey =
      GlobalKey<NavigatorState>(debugLabel: 'notificationKey');
  static final GlobalKey<NavigatorState> authNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'authNavKey');
  static final GlobalKey<NavigatorState> profileNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'profileNavKey');
  static final GlobalKey<NavigatorState> oddstersNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'oddstersNavKey');
  static final GlobalKey<NavigatorState> membersNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'membersNavKey');
  static final GlobalKey<NavigatorState> referralNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'referralNavKey');
  static final GlobalKey<NavigatorState> settingsNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'settingsNavKey');
}
