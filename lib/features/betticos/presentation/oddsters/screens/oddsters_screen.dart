// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/presentation/oddsters/widgets/oddsters_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/core/presentation/utils/app_endpoints.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/presentation/base/getx/base_screen_controller.dart';
import '/features/betticos/presentation/oddsters/getx/oddsters_controller.dart';
import '/features/betticos/presentation/profile/getx/profile_controller.dart';
import '/features/betticos/presentation/profile/screens/profile_screen.dart';
import '../../profile/widgets/circle_indicator.dart';

class OddstersScreen extends KFDrawerContent {
  OddstersScreen({Key? key}) : super(key: key);
  @override
  State<OddstersScreen> createState() => _OddstersScreenState();
}

class _OddstersScreenState extends State<OddstersScreen> {
  final OddstersController controller = Get.find<OddstersController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(() {
      controller.loadAllOddsters(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  _buildSliverAppBar(),
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      TabBar(
                        indicatorColor: context.colors.primary,
                        labelColor: Colors.black,
                        labelStyle: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Jost',
                        ),
                        onTap: (int index) {
                          controller.changeTabIndex(index);
                        },
                        indicator: CircleTabIndicator(
                          color: context.colors.primary,
                          radius: 3,
                        ),
                        unselectedLabelColor: Colors.grey,
                        padding: AppPaddings.lH,
                        tabs: <Widget>[
                          Tab(text: 'explore'.tr),
                          Tab(text: 'following'.tr),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: Obx(() {
                profileController.isFollowingUser.value;
                profileController.isUnfollowingUser.value;
                return TabBarView(
                  children: <Widget>[
                    _buildExploreOddstersTab(context, controller.oddsters),
                    _buildFollowingListView(
                      context,
                      profileController.getFollowingOddsters(),
                    ),
                  ],
                );
              }),
            )),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: false,
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading:
          ResponsiveWidget.isSmallScreen(context) ? false : true,
      title: Text(
        'oddsters'.tr,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      leading: ResponsiveWidget.isSmallScreen(context)
          ? IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: widget.onMenuPressed,
            )
          : null,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            showSearch<String>(context: context, delegate: OddsterSearch());
          },
          icon: Icon(
            Icons.search,
            color: context.colors.black,
          ),
        )
      ],
    );
  }

  Widget _buildFollowingListView(BuildContext context, List<User> users) {
    return Obx(
      () => AppLoadingBox(
        loading: profileController.isLoading.value,
        child: ListView.separated(
          padding: AppPaddings.lA,
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildListUserRow(
              context,
              users[index],
              () => null,
              isFollowingTab: true,
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: context.colors.faintGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildExploreOddstersTab(BuildContext context, List<User> users) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: ListView.separated(
          padding: AppPaddings.lA,
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              return _buildListUserRow(
                context,
                users[index],
                () {
                  if (profileController.checkIfFollowingUser(users[index])) {
                    profileController.unfollowTheUser();
                  } else {
                    profileController.followTheUser();
                  }
                  controller.loadAllOddsters(context);
                },
                isFollowing:
                    profileController.checkIfFollowingUser(users[index]),
              );
            });
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: context.colors.faintGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildListUserRow(
      BuildContext context, User user, Function() onPressed,
      {bool isFollowingTab = false, bool isFollowing = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ProfileScreen(
              user: user,
            ),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${user.photo}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '@${user.username}',
                  style: TextStyle(
                    color: context.colors.text,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          if (isFollowingTab)
            Icon(
              Ionicons.star_sharp,
              color: context.colors.primary,
            )
        ],
      ),
    );
  }
}
