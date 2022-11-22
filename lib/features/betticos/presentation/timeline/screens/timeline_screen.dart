import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/presentation/timeline/widgets/p2pbet_tab.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:betticos/features/settings/presentation/settings/getx/settings_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';
import '/core/core.dart';
import '/core/presentation/utils/app_endpoints.dart';
import '/core/presentation/widgets/app_empty_screen.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '/features/betticos/presentation/profile/screens/profile_screen.dart';
import '/features/betticos/presentation/timeline/getx/timeline_controller.dart';
import '/features/betticos/presentation/timeline/screens/post_detail_screen.dart';
import '/features/betticos/presentation/timeline/widgets/timeline_card.dart';
import '../../profile/widgets/circle_indicator.dart';

// ignore: must_be_immutable
class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);
  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  final TimelineController controller = Get.find<TimelineController>();
  final BaseScreenController baseScreenController =
      Get.find<BaseScreenController>();
  final LiveScoreController lController = Get.find<LiveScoreController>();
  final SettingsController sController = Get.find<SettingsController>();
  final P2PBetController _p2pBetController = Get.find<P2PBetController>();

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
    WidgetUtils.onWidgetDidBuild(() {
      _p2pBetController.setButtonSelected(context, 'awaiting');
    });
    super.initState();
  }

  Future<void> showTutorial() async {
    if (sController.isIntro.value) {
      initTargets();
      tutorialCoachMark = TutorialCoachMark(
        targets: targets,
        colorShadow: context.colors.primary,
        textSkip: 'SKIP',
        paddingFocus: 10,
        opacityShadow: 0.8,
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
                    child: const Icon(
                      Ionicons.create_outline,
                      color: Colors.white,
                    ),
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
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      TabBar(
                        indicatorColor: context.colors.primary,
                        labelColor: Colors.black,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        padding: AppPaddings.lH.add(AppPaddings.lB),
                        unselectedLabelColor: Colors.grey,
                        indicator: CircleTabIndicator(
                          color: context.colors.primary,
                          radius: 3,
                        ),
                        tabs: <Widget>[
                          Tab(
                            text: 'timeline'.tr,
                            key: timelineTab,
                          ),
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
                children: <Widget>[
                  _buildTimelineTab(),
                  _buildUpdatesTab(),
                  const P2pBetTab(),
                  _buildPromoTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdatesTab() {
    final List<Post> topPosts = controller.getTopUsers();
    return topPosts.isEmpty
        ? AppEmptyScreen(message: 'no_records'.tr)
        : ListView.separated(
            padding: AppPaddings.lA,
            itemCount: topPosts.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildListUserRow(topPosts[index].user);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
  }

  Widget _buildTimelineTab() {
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(
        () => controller.pagingController.value.refresh(),
      ),
      child: Obx(
        () => PagedListView<int, Post>.separated(
          pagingController: controller.pagingController.value,
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (BuildContext context, Post post, int index) {
              return Obx(
                () => TimelineCard(
                  post: post,
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PostDetailsScreen(
                          post: post,
                        ),
                      ),
                    );
                  },
                  onCommentTap: () => controller.navigateToAddPost(
                    context,
                    pstId: post.id,
                  ),
                  onLikeTap: () => controller.likeThePost(context, post.id),
                  onDislikeTap: () =>
                      controller.dislikeThePost(context, post.id),
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (BuildContext context) =>
                ErrorIndicator(
              error: controller.pagingController.value.error as Failure,
              onTryAgain: () => controller.pagingController.value.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (BuildContext context) =>
                const EmptyListIndicator(),
            newPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: LoadingLogo(),
            ),
            firstPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: LoadingLogo(),
            ),
            // padding: AppPaddings.homeA,
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox.shrink(),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildPromoTab() {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        child: Transform.translate(
          offset: const Offset(0.0, -260.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CarouselSlider(
                items: const <Widget>[
                  Image(
                    image: NetworkImage(
                        'https://www.thebettingcoach.com/wp-content/uploads/2020/08/Melbet-banner-728x90-thebettingcoach-1.jpg'),
                    fit: BoxFit.contain,
                  ),
                  Image(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6TsR43z_TMg52Yein3oNgIof65oBYkq4JXxAXWKwPIKdRPX94B2JafW1RsIREDvH4Q&usqp=CAU'),
                    fit: BoxFit.fitWidth,
                  ),
                ],
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 24 / 3,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 300),
                  viewportFraction: 1.0,
                ),
              ),
              const SizedBox(height: 9.0),
              DetectableText(
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'more',
                trimExpandedText: '...less',
                text: 'Tap: https://bit.ly/melbet-bettico',
                detectionRegExp: RegExp(
                  '(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent',
                  multiLine: true,
                ),
                callback: (bool readMore) {
                  debugPrint('Read more >>>>>>> $readMore');
                },
                onTap: (String tappedText) async {
                  // ignore: avoid_print
                  print(tappedText);
                  if (tappedText.startsWith('#')) {
                    debugPrint('DetectableText >>>>>>> #');
                  } else if (tappedText.startsWith('@')) {
                    debugPrint('DetectableText >>>>>>> @');
                  } else if (tappedText.startsWith('http')) {
                    _launchURL(tappedText);
                  }
                },
                basicStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 0.5,
                ),
                detectedStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 0.5,
                  color: context.colors.primary,
                ),
              ),
              const SelectableText(
                'promocode: betworld2022',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              )
            ],
          ),
        ),
      ),
      const SizedBox(height: 15.0),
      CarouselSlider(
        items: <Widget>[
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://melbet.com.gh/img/banners/main/home_page_main_section/202.jpg?v=1010022910'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'MELBET',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'fast_betting'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyKuwPx-xSzgZxm-RQ8Z0cz4Aqunnt2a178w&usqp=CAU'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'sporting'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'sport_news'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-I-VS-cZT4Q424GvkVZnYNZZoC1JQL13e9-ZhDgik79NRxF41kBKINUDaWlmZPrwUp4g&usqp=CAU'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'online_odds'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'have_lost'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          viewportFraction: 0.8,
        ),
      )
    ]);
  }

  Widget _buildListUserRow(User user) {
    final double averageUserPosts = controller.getUserPercentage(user.id);
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProfileScreen(user: user),
              ),
            );
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${user.photo}',
                  headers: <String, String>{
                    'Authorization':
                        'Bearer ${baseScreenController.userToken.value}'
                  },
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const AppSpacing(h: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(
                '@${user.username}',
                style: TextStyle(
                  color: context.colors.grey,
                  fontSize: 10,
                ),
              ),
              const AppSpacing(v: 5),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  controller.getUsersTotalWins(user.id).toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.text,
                  ),
                ),
                Icon(
                  Ionicons.caret_up_sharp,
                  size: 24,
                  color: context.colors.success,
                ),
              ],
            ),
            Text(
              '${averageUserPosts.toStringAsFixed(2)}%',
              style: TextStyle(
                color: averageUserPosts >= 50
                    ? context.colors.success
                    : context.colors.error,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  controller.getUserTotalLosses(user.id).toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colors.text,
                  ),
                ),
                Icon(
                  Ionicons.caret_down_sharp,
                  size: 24,
                  color: context.colors.error,
                ),
              ],
            ),
          ],
        ),
      ],
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
            align: ContentAlign.bottom,
            builder:
                (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'view_posts_tut'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
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
            builder:
                (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'create_posts_tut'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
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
            align: ContentAlign.bottom,
            builder:
                (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'update_tut'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
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
            align: ContentAlign.bottom,
            builder:
                (BuildContext context, TutorialCoachMarkController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'promo_tut'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20.0),
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
