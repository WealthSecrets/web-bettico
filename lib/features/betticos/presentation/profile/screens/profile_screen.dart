// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'dart:io';

// import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/my_posts_screen.dart';
import 'package:betticos/features/betticos/presentation/profile/screens/update_profile_screen.dart';
import 'package:betticos/features/betticos/presentation/profile/widgets/circle_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/core/core.dart';
import '/core/presentation/presentation.dart';
import '/core/presentation/utils/app_endpoints.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/presentation/profile/getx/profile_controller.dart';
import '/features/betticos/presentation/profile/screens/user_list_screen.dart';
import '../../timeline/widgets/modal_fit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {Key? key, this.user, this.thePreviousUser, this.showBackButton})
      : super(key: key);
  final User? user;
  final User? thePreviousUser;
  final bool? showBackButton;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.find<ProfileController>();

  void _onPickImage() async {
    Navigator.pop(context);
    final FilePickerResult? picked = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => debugPrint(status.name),
    );

    if (picked != null) {
      final Uint8List? bytes = picked.files.first.bytes;

      controller.onProfileImageSelected(bytes);
      if (context.mounted) {
        controller.updateTheUserProfilePhoto(context);
      }
    }
  }

  @override
  void initState() {
    WidgetUtils.onWidgetDidBuild(() {
      controller.setPageContext(context);
      controller.setProfileUser(
        widget.user,
        performActions: true,
      );
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
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  _buildSliverAppBar(),
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
                          Tab(
                            text: 'posts'.tr,
                          ),
                          Tab(
                            text: 'odd_boxes'.tr,
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  MyPostsScreen(
                    userId: controller.user.value.id,
                  ),
                  MyPostsScreen(
                    userId: controller.user.value.id,
                    isOddboxes: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      toolbarHeight: 0,
      expandedHeight: 250,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        if (widget.user != null && widget.user!.id != controller.user.value.id)
          GestureDetector(
              onTap: () => showMaterialModalBottomSheet<String>(
                    context: context,
                    builder: (_) => ModalFit(
                      user: widget.user,
                      ctx: context,
                    ),
                  ),
              child: Padding(
                padding: AppPaddings.homeR,
                child: const Icon(
                  Ionicons.ellipsis_vertical,
                  size: 16,
                  color: Colors.black,
                ),
              )),
      ],
      flexibleSpace: _buildFlexibleSpaceWidget(),
      forceElevated: true,
    );
  }

  LayoutBuilder _buildFlexibleSpaceWidget() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FlexibleSpaceBar(
        background: Padding(
            padding: AppPaddings.lH.add(AppPaddings.lB),
            child: Obx(
              () => Column(
                children: <Widget>[
                  const AppSpacing(v: 30),
                  if (controller.user.value.role == 'oddster')
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Ionicons.star_sharp,
                        color: context.colors.secondary,
                      ),
                    ),
                  const AppSpacing(v: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildFollowingButton(),
                      _buildProfileImageStack(),
                      _buildFollowersButton(),
                    ],
                  ),
                  const AppSpacing(v: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            '${controller.user.value.firstName} ${controller.user.value.lastName}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const AppSpacing(h: 5),
                          if (controller.user.value.role == 'admin')
                            Image.asset(
                              AssetImages.verified,
                              height: 14,
                              width: 14,
                            ),
                        ],
                      ),
                      Center(
                        child: Text(
                          '@${controller.user.value.username}',
                          style: TextStyle(
                            color: context.colors.text,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const AppSpacing(v: 10),
                  Padding(
                    padding: AppPaddings.lH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        if (widget.user == null)
                          OutlinedButton(
                            onPressed: () async {
                              // final dynamic value = await Get.toNamed<dynamic>(
                              //   AppRoutes.updateProfile,
                              //   arguments: ProfileArgument(
                              //     user: controller.user.value,
                              //   ),
                              // );
                              // if (value as bool? ?? false) {
                              //   await AppSnacks.show(
                              //     context,
                              //     message: 'Profile updated successfully',
                              //     backgroundColor: context.colors.success,
                              //     leadingIcon: const Icon(
                              //       Ionicons.checkmark_circle_outline,
                              //       color: Colors.white,
                              //     ),
                              //   );
                              // }

                              final dynamic value =
                                  await Navigator.push<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      UpdateProfileScreen(
                                    user: controller.user.value,
                                  ),
                                ),
                              );

                              if (value as bool? ?? false) {
                                if (context.mounted) {
                                  await AppSnacks.show(
                                    context,
                                    message: 'Profile updated successfully',
                                    backgroundColor: context.colors.success,
                                    leadingIcon: const Icon(
                                      Ionicons.checkmark_circle_outline,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              side: BorderSide(
                                width: 2.0,
                                color: context.colors.cardColor,
                              ),
                            ),
                            child: Text(
                              'edit_profile'.tr,
                              style: TextStyle(
                                color: context.colors.textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (widget.user != null &&
                            controller.isNotLoggedInUser())
                          OutlinedButton(
                            onPressed: () {
                              if (controller.isFollowedByUser.value) {
                                controller.unfollowTheUser();
                              } else {
                                controller.followTheUser();
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              backgroundColor: controller.isFollowedByUser.value
                                  ? context.colors.primary
                                  : Colors.white,
                              side: BorderSide(
                                width: 2.0,
                                color: controller.isFollowedByUser.value
                                    ? context.colors.primary
                                    : context.colors.cardColor,
                              ),
                            ),
                            child: controller.isFollowingUser.value ||
                                    controller.isUnfollowingUser.value
                                ? SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: controller.isUnfollowingUser.value
                                          ? Colors.white
                                          : context.colors.primary,
                                    ),
                                  )
                                : Text(
                                    controller.isFollowedByUser.value
                                        ? 'following'.tr
                                        : 'follow'.tr,
                                    style: TextStyle(
                                      color: controller.isFollowedByUser.value
                                          ? Colors.white
                                          : context.colors.textDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                          ),
                        if (widget.user != null &&
                            controller.user.value.role == 'oddster')
                          OutlinedButton(
                            onPressed: () => controller.subscribeToTheUser(
                                context, widget.user!.id),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              backgroundColor:
                                  controller.isSubscribedToUser.value
                                      ? context.colors.error
                                      : Colors.white,
                              side: BorderSide(
                                width: 2.0,
                                color: controller.isSubscribedToUser.value
                                    ? context.colors.error
                                    : context.colors.cardColor,
                              ),
                            ),
                            child: controller.isSubscribingToUser.value
                                ? SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: controller.isSubscribedToUser.value
                                          ? Colors.white
                                          : context.colors.error,
                                    ),
                                  )
                                : Text(
                                    controller.isSubscribedToUser.value
                                        ? 'subscribed'.tr
                                        : 'subscribe'.tr,
                                    style: TextStyle(
                                      color: controller.isSubscribedToUser.value
                                          ? Colors.white
                                          : context.colors.textDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }

  Widget _buildFollowingButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => UserListScreen(
              isFollowers: false,
              theUser: widget.user,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'following'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            '${controller.user.value.following}',
            style: TextStyle(
              color: context.colors.text,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowersButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => UserListScreen(
              isFollowers: true,
              theUser: widget.user,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'followers'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            '${controller.user.value.followers}',
            style: TextStyle(
              color: context.colors.text,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImageStack() {
    return Stack(
      children: <Widget>[
        if (controller.profileImage.value.isEmpty)
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.userImages}/${controller.user.value.photo}',
                  headers: <String, String>{
                    'Authorization': 'Bearer ${controller.userToken.value}'
                  },
                ),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                width: 3,
                color: context.colors.primary,
              ),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.black12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          )
        else
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              image: DecorationImage(
                image: MemoryImage(controller.profileImage.value),
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (widget.user == null)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: context.colors.primary,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: GestureDetector(
                  child: const Icon(
                    Ionicons.camera_sharp,
                    color: Colors.white,
                    size: 14,
                  ),
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: ((BuildContext context) => bottomSheet(context)),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'choose_profile_photo'.tr,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            IconButton(
              icon: const Icon(
                Ionicons.camera,
              ),
              onPressed: _onPickImage,
            ),
            IconButton(
              icon: const Icon(
                Ionicons.image,
              ),
              onPressed: _onPickImage,
            ),
          ])
        ],
      ),
    );
  }
}

class FullImage extends StatelessWidget {
  FullImage({Key? key, required this.imageAddress}) : super(key: key);

  File imageAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Center(
              child: Image.file(
                imageAddress,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
