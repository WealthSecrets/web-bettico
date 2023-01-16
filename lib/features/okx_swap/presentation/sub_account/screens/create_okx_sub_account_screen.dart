// import 'package:betticos/features/auth/presentation/register/arguments/user_argument.dart';
// import 'package:betticos/features/auth/presentation/register/getx/register_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';

// import '/core/core.dart';
// import '../../../../../core/presentation/helpers/responsiveness.dart';

// class CreateOkxSubAccountScreen extends StatelessWidget {
//   CreateOkxSubAccountScreen({Key? key}) : super(key: key);

//   final RegisterController registerController = Get.find<RegisterController>();

//   final UserArgument? args = Get.arguments as UserArgument?;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => AppLoadingBox(
//         loading: registerController.isRegisteringUser.value,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//             leading: Transform.translate(
//               offset: const Offset(10, 0),
//               child: const AppBackButton(),
//             ),
//           ),
//           backgroundColor: context.colors.background,
//           body: SafeArea(
//             child: Center(
//               child: SizedBox(
//                 width: ResponsiveWidget.isSmallScreen(context)
//                     ? double.infinity
//                     : 450,
//                 child: SingleChildScrollView(
//                   padding: AppPaddings.lH,
//                   child: AppAnimatedColumn(
//                     direction: Axis.horizontal,
//                     duration: const Duration(milliseconds: 1000),
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Sign up for trade.',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 20,
//                             color: context.colors.hintLight,
//                           ),
//                         ),
//                       ),
//                       const AppSpacing(v: 30),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Enter preferred username for trading - swap of tokens',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             height: 1.22,
//                             fontSize: 16,
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       const AppSpacing(v: 30),
//                       AppTextInput(
//                         labelText: 'Name / Username',
//                         prefixIcon: Icon(Ionicons.person_sharp,
//                             color: context.colors.hintLight),
//                         backgroundColor: context.colors.primary.shade100,
//                         lableStyle: TextStyle(
//                           color: context.colors.primary,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 10,
//                         ),
//                         validator: registerController.validateOkxUsername,
//                         onChanged: registerController.onOkxUsernameInputChanged,
//                       ),
//                       Obx(
//                         () => TextButton(
//                           onPressed: () {
//                             registerController.toggleOkxUsername(
//                                 !registerController.useUsername.value);
//                           },
//                           child: Row(
//                             children: <Widget>[
//                               IgnorePointer(
//                                 child: AppCheckBox(
//                                   checkBoxMargin: EdgeInsets.zero,
//                                   borderRadius: BorderRadius.circular(2),
//                                   height: 24,
//                                   value: registerController.useUsername.value,
//                                   onChanged:
//                                       registerController.toggleOkxUsername,
//                                 ),
//                               ),
//                               const AppSpacing(h: 4),
//                               Text(
//                                 'Use your username to create subaccount?',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: context.colors.textDark,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const AppSpacing(v: 250),
//                       AppButton(
//                         borderRadius: AppBorderRadius.largeAll,
//                         enabled:
//                             registerController.okxUsername.value.isNotEmpty ||
//                                 registerController.useUsername.value,
//                         onPressed: () {
//                           if (registerController.useUsername.value) {
//                             registerController.createOkxAccount(context,
//                                 user: args?.user);
//                           } else {
//                             registerController.createOkxAccount(context);
//                           }
//                         },
//                         child: const Text(
//                           'Create Account',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const AppSpacing(v: 50),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
