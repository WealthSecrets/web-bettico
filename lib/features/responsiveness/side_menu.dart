// import 'package:betticos/core/core.dart';
// import 'package:betticos/features/responsiveness/side_menu_item.dart';
// import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// import '../../core/presentation/helpers/responsiveness.dart';
// import '../../core/presentation/routes/side_menu_routes.dart';
// // import 'constants/web_controller.dart';
// import 'custom_text.dart';

// class SideMenu extends StatelessWidget {
//   const SideMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;

//     return Container(
//       child: ListView(
//         children: <Widget>[
//           if (ResponsiveWidget.isSmallScreen(context))
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const SizedBox(height: 40),
//                 Row(
//                   children: <Widget>[
//                     SizedBox(width: _width / 48),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 12),
//                       child: Image.asset('assets/images/logo.png'),
//                     ),
//                     Flexible(
//                       child: CustomText(
//                         text: 'Bettico',
//                         size: 20,
//                         weight: FontWeight.bold,
//                         color: context.colors.primary,
//                       ),
//                     ),
//                     SizedBox(width: _width / 48),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           Divider(color: context.colors.lightGrey.withOpacity(.1)),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: sideMenuItemRoutes
//                 .map(
//                   (MenuItem item) => SideMenuItem(
//                     name: item.name,
//                     route: item.route,
//                     onTap: () {},
//                     // onTap: () {
//                     //   print(
//                     //       'the item route: ${item.route} and item name: ${item.name}');
//                     //   // if (item.route == AppRoutes.login) {
//                     //   //   Get.offAllNamed<void>(AppRoutes.login);
//                     //   //   menuController.changeActiveItemTo(AppRoutes.timeline);
//                     //   // } else if (!menuController.isActive(item.route)) {
//                     //   //   menuController.changeActiveItemTo(item.route);
//                     //   //   if (ResponsiveWidget.isSmallScreen(context)) {
//                     //   //     Get.back<void>();
//                     //   //   }
//                     //   //   navigationController.navigateTo(item.route);
//                     //   // }
//                     // },
//                   ),
//                 )
//                 .toList(),
//           )
//         ],
//       ),
//     );
//   }
// }
