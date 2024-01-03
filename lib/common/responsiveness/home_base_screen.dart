import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({super.key});

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final BaseScreenController baseScreenController = Get.find<BaseScreenController>();

  int _bottomNavIndex = 0;

  List<Map<String, dynamic>> bottomNavIcons = <Map<String, dynamic>>[
    <String, dynamic>{
      'outline': AssetImages.homeOutline,
      'solid': AssetImages.homeSolid,
      'text': 'Home',
    },
    <String, dynamic>{
      'outline': AssetImages.searchOutline,
      'solid': AssetImages.searchSolid,
      'text': 'Search',
    },
    <String, dynamic>{
      'outline': AssetImages.convertOutline,
      'solid': AssetImages.convertSolid,
      'text': 'Trade',
    },
    <String, dynamic>{
      'outline': AssetImages.notificationOutline,
      'solid': AssetImages.notificationSolid,
      'text': 'Notification',
    },
    <String, dynamic>{
      'outline': AssetImages.moreOutline,
      'solid': AssetImages.moreSolid,
      'text': 'More',
    }
  ];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? token;
  late Stream<String> _tokenStream;

  void setToken(String? tkn) {
    baseScreenController.updateUserDeviceInfo(tkn);
  }

  @override
  void initState() {
    _firebaseMessaging.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    super.initState();
  }

  void showFlutterNotification(RemoteMessage message) {
    final RemoteNotification? notification = message.notification;
    AppSnacks.show(
      context,
      message: '${notification?.title.toString()} ${notification?.body.toString}',
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
    return Obx(() {
      final String userToken = baseScreenController.userToken.value;
      final User user = baseScreenController.user.value;
      final String initialRoute = userToken.isNotEmpty ? AppRoutes.timeline : AppRoutes.explore;
      return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        drawer: isSmallScreen ? Drawer(child: LeftSideBar(user: user, userToken: userToken)) : null,
        bottomNavigationBar: isSmallScreen && userToken.isNotEmpty
            ? AnimatedBottomNavigationBar.builder(
                activeIndex: _bottomNavIndex,
                itemCount: bottomNavIcons.length,
                tabBuilder: (int index, bool isActive) {
                  final String image =
                      isActive ? bottomNavIcons[index]['solid'] as String : bottomNavIcons[index]['outline'] as String;

                  final Color color = isActive ? context.colors.primary : context.colors.grey;

                  final String text = bottomNavIcons[index]['text'] as String;

                  final FontWeight fontWeight = isActive ? FontWeight.bold : FontWeight.normal;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(image, height: 24, width: 24, color: color),
                      const SizedBox(height: 3),
                      Text(text, style: TextStyle(fontSize: 10, fontWeight: fontWeight, color: color)),
                    ],
                  );
                },
                gapLocation: GapLocation.none,
                notchSmoothness: NotchSmoothness.defaultEdge,
                onTap: (int index) {
                  setState(() => _bottomNavIndex = index);
                  switchScreen(index);
                },
              )
            : !isLargeScreen && !baseScreenController.isLoggedIn
                ? const ResponsiveWidget(
                    largeScreen: LargeUnAthenticatedBottomNavbar(),
                    mediumScreen: MediumUnAthenticatedBottomNavbar(),
                    customScreen: CustomUnAthenticatedBottomNavbar(),
                    smallScreen: SmallUnAthenticatedBottomNavbar(),
                  )
                : null,
        body: AppLoadingBox(
          loading: baseScreenController.isLoggingOut.value,
          child: ResponsiveWidget(
            largeScreen: LargeScreen(initialRoute: initialRoute, user: user, userToken: userToken),
            mediumScreen: MediumScreen(initialRoute: initialRoute, user: user, userToken: userToken),
            customScreen: CustomScreen(initialRoute: initialRoute, user: user, userToken: userToken),
            smallScreen: Column(
              children: <Widget>[topNavigationBar(context, scaffoldKey), Expanded(child: appNavigator(initialRoute))],
            ),
          ),
        ),
      );
    });
  }

  bool get isSmallScreen => ResponsiveWidget.isSmallScreen(context);

  bool get isLargeScreen => ResponsiveWidget.isLargeScreen(context);

  double get screenWidth => MediaQuery.of(context).size.width;

  void switchScreen(int index) {
    switch (index) {
      case 0:
        navigationController.navigateTo(AppRoutes.timeline);
        return;
      case 1:
        navigationController.navigateTo(AppRoutes.explore);
        return;
      case 2:
        navigationController.navigateTo(AppRoutes.okxOptions);
        return;
      case 3:
        navigationController.navigateTo(AppRoutes.members);
        return;
      case 4:
        navigationController.navigateTo(AppRoutes.moreScreen);
        return;
      default:
        navigationController.navigateTo(AppRoutes.timeline);
    }
  }
}
