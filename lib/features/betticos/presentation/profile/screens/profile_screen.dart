import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user, this.showBackButton});
  final User user;
  final bool? showBackButton;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.find<ProfileController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
  @override
  void initState() {
    controller.setProfileUser(widget.user, performActions: true);
    WidgetUtils.onWidgetDidBuild(() {
      controller.context = context;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
        length: 6,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                _SliverAppBar(user: widget.user, showBackButton: widget.showBackButton),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicatorColor: context.colors.primary,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: const TextStyle(fontSize: 14),
                      padding: AppPaddings.lH,
                      unselectedLabelColor: Colors.grey,
                      indicator: CircleTabIndicator(
                        color: context.colors.primary,
                        radius: 3,
                      ),
                      tabs: <Tab>[
                        Tab(icon: Image.asset(AppAssetIcons.postsSolid, height: 24, width: 24)),
                        Tab(icon: Image.asset(AppAssetIcons.box, height: 24, width: 24)),
                        Tab(icon: Image.asset(AppAssetIcons.refreshCcwSolid, height: 24, width: 24)),
                        Tab(icon: Image.asset(AppAssetIcons.comments, height: 24, width: 24)),
                        Tab(icon: Image.asset(AppAssetIcons.heart, height: 24, width: 24)),
                        Tab(icon: Image.asset(AppAssetIcons.bookmarks, height: 24, width: 24)),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                MyPostsScreen(userId: widget.user.id, type: PostType.posts),
                MyPostsScreen(userId: widget.user.id, type: PostType.oddboxes, oddbox: true),
                RepostsScreen(),
                MyPostsScreen(userId: widget.user.id, type: PostType.comments),
                MyPostsScreen(userId: widget.user.id, type: PostType.likedPosts),
                MyPostsScreen(userId: widget.user.id, type: PostType.bookmarks),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  _SliverAppBar({required this.user, this.showBackButton});
  final User user;
  final bool? showBackButton;

  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final User loggedInUser = Get.find<BaseScreenController>().user.value;
        return SliverAppBar(
          toolbarHeight: 0,
          expandedHeight: user.id == loggedInUser.id || (user.id != loggedInUser.id && !user.isCreator) ? 400 : 542,
          pinned: true,
          backgroundColor: Colors.white,
          flexibleSpace: NewProfileFlexibleAppBar(user: user, showBackButton: showBackButton),
          forceElevated: true,
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
