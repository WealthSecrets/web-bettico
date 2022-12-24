import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/helpers/web_navigator.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/responsiveness/left_side_bar.dart';
import 'package:betticos/features/responsiveness/top_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/presentation/helpers/responsiveness.dart';
import 'large_screen.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({Key? key}) : super(key: key);

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final BaseScreenController baseScreenController =
      Get.find<BaseScreenController>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? token;
  late Stream<String> _tokenStream;

  void setToken(String? tkn) {
    baseScreenController.updateUserDeviceInfo(tkn);
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) {
    final RemoteNotification? notification = message.notification;
    AppSnacks.show(
      context,
      message:
          '${notification?.title.toString()} ${notification?.body.toString}',
      backgroundColor: context.colors.success,
      leadingIcon: const Icon(
        Ionicons.information_sharp,
        size: 24,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? topNavigationBar(context, scaffoldKey)
          : null,
      drawer: ResponsiveWidget.isSmallScreen(context)
          ? const Drawer(
              child: LeftSideBar(),
            )
          : null,
      body: AppLoadingBox(
        loading: baseScreenController.isLoggingOut.value,
        child: ResponsiveWidget(
          largeScreen: const LargeScreen(),
          smallScreen: webNavigator(),
        ),
      ),
    );
  }
}
