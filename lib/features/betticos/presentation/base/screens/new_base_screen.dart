// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:betticos/core/core.dart';
// import 'package:betticos/core/presentation/utils/app_endpoints.dart';
// import 'package:betticos/features/auth/data/models/user/user.dart';
// import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
// import 'package:betticos/features/betticos/presentation/profile/screens/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';

// import '/core/presentation/widgets/page_icon_list.dart';
// import '/features/betticos/presentation/base/widgets/navigation_screen.dart';
// import '/features/betticos/presentation/timeline/getx/timeline_controller.dart';

// class NBaseScreen extends StatefulWidget {
//   const NBaseScreen({Key? key}) : super(key: key);
//   @override
//   _NBaseScreenState createState() => _NBaseScreenState();
// }

// class _NBaseScreenState extends State<NBaseScreen>
//     with SingleTickerProviderStateMixin {
//   // controllers
//   final TimelineController controller = Get.find<TimelineController>();
//   final BaseScreenController bController = Get.find<BaseScreenController>();

//   final AutoSizeGroup autoSizeGroup = AutoSizeGroup();
//   int _bottomNavIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     // bController.loadUserFromToken();
//     return Scaffold(
//       extendBody: true,
//       body: NavigationScreen(
//         content:
//             _bottomNavIndex == 4 ? ProfileScreen() : pageList[_bottomNavIndex],
//       ),
//       floatingActionButton: _bottomNavIndex == 0
//           ? FloatingActionButton(
//               onPressed: () => controller.navigateToAddPost(context),
//               backgroundColor: context.colors.primary.shade400,
//               child: const Icon(
//                 Ionicons.create_outline,
//                 color: Colors.white,
//               ),
//             )
//           : null,
//       bottomNavigationBar: AnimatedBottomNavigationBar.builder(
//         itemCount: iconList.length,
//         tabBuilder: (int index, bool isActive) {
//           final Color lightColor =
//               isActive ? context.colors.primary : context.colors.black;

//           if (index == 4) {
//             return Center(
//               child: Obx(
//                 () {
//                   final User user = bController.user.value;
//                   return Container(
//                     height: 30,
//                     width: 30,
//                     margin: AppPaddings.lH,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           '${AppEndpoints.userImages}/${user.photo}',
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(
//                 isActive ? iconSharpList[index] : iconList[index],
//                 size: 24,
//                 color: lightColor,
//               ),
//             ],
//           );
//         },
//         backgroundColor: Theme.of(context).cardColor,
//         activeIndex: _bottomNavIndex,
//         splashColor: context.colors.primary,
//         splashSpeedInMilliseconds: 300,
//         notchSmoothness: NotchSmoothness.defaultEdge,
//         gapLocation: GapLocation.none,
//         onTap: (int index) => setState(
//           () => _bottomNavIndex = index,
//         ),
//       ),
//     );
//   }
// }
