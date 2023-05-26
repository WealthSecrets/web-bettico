// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:betticos/features/betticos/presentation/profile/screens/my_posts_screen.dart';
import 'package:betticos/features/betticos/presentation/profile/widgets/circle_indicator.dart';
import 'package:betticos/features/betticos/presentation/profile/widgets/profile_flexible_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/presentation/profile/getx/profile_controller.dart';
import '../../timeline/widgets/modal_fit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.user, this.thePreviousUser, this.showBackButton});
  final User? user;
  final User? thePreviousUser;
  final bool? showBackButton;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(() {
      controller.setPageContext(context);
      controller.setProfileUser(widget.user, performActions: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop<User>(widget.thePreviousUser);
        return Future<bool>.value(true);
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
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
                          Tab(text: 'posts'.tr),
                          Tab(text: 'odd_boxes'.tr),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  MyPostsScreen(userId: controller.user.value.id),
                  MyPostsScreen(userId: controller.user.value.id, isOddboxes: true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  _SliverAppBar({this.user, this.showBackButton});
  final User? user;
  final bool? showBackButton;

  final ProfileController controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0,
      expandedHeight: 260,
      pinned: true,
      backgroundColor: Colors.white,
      actions: <Widget>[
        if (user != null && user!.id != controller.user.value.id)
          GestureDetector(
            onTap: () => showMaterialModalBottomSheet<String>(
              context: context,
              builder: (_) => ModalFit(user: user, ctx: context),
            ),
            child: Padding(
              padding: AppPaddings.homeR,
              child: const Icon(Ionicons.ellipsis_vertical, size: 16, color: Colors.black),
            ),
          ),
      ],
      flexibleSpace: ProfileFlexibleAppBar(user: user, showBackButton: showBackButton),
      forceElevated: true,
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
