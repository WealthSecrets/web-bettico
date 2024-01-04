import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});
  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  final TimelineController controller = Get.find<TimelineController>();
  final BaseScreenController baseScreenController = Get.find<BaseScreenController>();
  final SettingsController sController = Get.find<SettingsController>();

  GlobalKey timelineTab = GlobalKey();
  GlobalKey createPost = GlobalKey();
  GlobalKey menuButton = GlobalKey();
  GlobalKey updateTab = GlobalKey();
  GlobalKey p2pBetsTab = GlobalKey();
  GlobalKey promoTab = GlobalKey();
  GlobalKey oddSlipButton = GlobalKey();

  @override
  void initState() {
    Future<void>.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  Future<void> showTutorial() async {
    if (sController.isIntro.value) {
      initTargets();
      tutorialCoachMark = TutorialCoachMark(
        targets: targets,
        colorShadow: context.colors.primary,
        onFinish: () => sController.updateIntroductionPreference(false),
        onClickTarget: (TargetFocus target) {},
        onClickOverlay: (TargetFocus target) {},
        onSkip: () {
          sController.updateIntroductionPreference(false);
        },
        textStyleSkip: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )..show(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ResponsiveWidget.isSmallScreen(context)
            ? controller.tabIndex.value == 0
                ? FloatingActionButton(
                    onPressed: () => controller.navigateToAddPost(context),
                    backgroundColor: context.colors.primary.shade400,
                    key: createPost,
                    child: const Icon(Ionicons.create_outline, color: Colors.white),
                  )
                : null
            : null,
        body: DefaultTabController(
          length: 4,
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
                          Tab(text: 'updates'.tr, key: updateTab),
                          Tab(text: 'P2P Bets', key: p2pBetsTab),
                          Tab(text: 'promos'.tr, key: promoTab),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[TimelineTab(), UpdatesTab(), const PromoTab(), const PromoTab()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: 'timelineTab',
        keyTarget: timelineTab,
        alignSkip: Alignment.topRight,
        contents: <TargetContent>[
          TargetContent(
            builder: (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'view_posts_tut'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'createPost',
        keyTarget: createPost,
        alignSkip: Alignment.topRight,
        contents: <TargetContent>[
          TargetContent(
            align: ContentAlign.top,
            builder: (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'create_posts_tut'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'updateTab',
        keyTarget: updateTab,
        alignSkip: Alignment.topRight,
        contents: <TargetContent>[
          TargetContent(
            builder: (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'update_tut'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'promoTab',
        keyTarget: promoTab,
        alignSkip: Alignment.topRight,
        contents: <TargetContent>[
          TargetContent(
            builder: (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'promo_tut'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
