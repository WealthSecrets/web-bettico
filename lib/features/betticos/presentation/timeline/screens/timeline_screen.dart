import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});
  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final TimelineController controller = Get.find<TimelineController>();
  final SettingsController sController = Get.find<SettingsController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  GlobalKey timelineTab = GlobalKey();
  GlobalKey createPost = GlobalKey();
  GlobalKey menuButton = GlobalKey();
  GlobalKey anonymous = GlobalKey();
  GlobalKey viralz = GlobalKey();
  GlobalKey promoTab = GlobalKey();
  GlobalKey oddSlipButton = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: scaffoldKey,
          appBar: TopNavigationBar(scaffoldKey: scaffoldKey),
          drawer: isSmallScreen ? const Drawer(child: LeftSideBar()) : null,
          floatingActionButton: isSmallScreen
              ? controller.tabIndex.value == 0
                  ? FloatingActionButton(
                      onPressed: () => controller.navigateToAddPost(context),
                      backgroundColor: context.colors.primary.shade400,
                      key: createPost,
                      child: Center(
                        child: Image.asset(AppAssetIcons.editPencil, height: 24, width: 24, color: Colors.white),
                      ),
                    )
                  : null
              : null,
          body: DefaultTabController(
            length: isSmallScreen ? 3 : 2,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverPersistentHeader(
                      delegate: SliverAppBarDelegate(
                        TabBar(
                          indicatorColor: context.colors.primary,
                          labelColor: Colors.black,
                          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          unselectedLabelStyle: const TextStyle(fontSize: 14),
                          padding: AppPaddings.lH.add(AppPaddings.lB),
                          unselectedLabelColor: Colors.grey,
                          indicator: CircleTabIndicator(color: context.colors.primary, radius: 3),
                          tabs: <Widget>[
                            Tab(text: 'timeline'.tr, key: timelineTab),
                            if (isSmallScreen) Tab(text: 'Viralz', key: viralz),
                            Tab(text: 'Anonymous', key: anonymous),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    TimelineTab(),
                    if (isSmallScreen) const TrendsForYouScreen(isOnScreen: true),
                    Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
