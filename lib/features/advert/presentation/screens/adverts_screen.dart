// import 'package:betticos/core/core.dart';
// import 'package:betticos/core/presentation/helpers/responsiveness.dart';
// import 'package:betticos/features/advert/presentation/ads/getx/ads_controller.dart';
// import 'package:betticos/features/advert/presentation/ads/widgets/step_controls.dart';
// import 'package:betticos/features/betticos/presentation/timeline/widgets/timeline_card.dart';
// import 'package:betticos/features/okx_swap/presentation/okx_options/widgets/icon_card.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdsScreen extends GetWidget<AdsController> {
//   const AdsScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final List<String?> countryNames = controller.countries.map((CountryCode _) => _.name).toList();
//     final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
//     return SingleChildScrollView(
//       padding: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
//       child: Column(
//         children: <Widget>[
//           TimelineCard(post: controller.post.vale, hideButtons: true, hideOptions: true),
//           const SizedBox(height: 8),
//           _SummaryItem(
//             title: 'Target',
//             subtitle: StringUtils.capitalizeFirst(controller.target.value.name),
//             imagePath: AssetImages.darts,
//           ),
//           const SizedBox(height: 16),
//           if (controller.isSpecialAdCategory.value) ...<Widget>[
//             _SummaryItem(
//               title: 'Category',
//               subtitle: StringUtils.capitalizeFirst(controller.category.value.name),
//               imagePath: AssetImages.catgory,
//             ),
//             const SizedBox(height: 16),
//           ],
//           _SummaryItem(
//             title: countryNames.length > 1 ? 'Locations' : 'Location',
//             subtitle: countryNames.join(', '),
//             imagePath: AssetImages.location,
//           ),
//           const SizedBox(height: 16),
//           _SummaryItem(
//             title: 'Age Range',
//             subtitle: '${controller.rangeValues.value.start.toInt()} - ${controller.rangeValues.value.end.toInt()}',
//             imagePath: AssetImages.ageRange,
//           ),
//           const SizedBox(height: 16),
//           _SummaryItem(
//             title: 'Gender',
//             subtitle: StringUtils.capitalizeFirst(controller.gender.value.name),
//             imagePath: AssetImages.gender,
//           ),
//           const SizedBox(height: 16),
//           _SummaryItem(
//             title: 'Budget',
//             subtitle:
//                 'Amount:\$${contoller.budget.value}  Estimated Reach: ${controller.estimatedReach.value.toInt()}',
//             imagePath: AssetImages.money,
//           ),
//           const SizedBox(height: 16),
//           _SummaryItem(
//             title: 'Duration',
//             subtitle: '${controller.duration.value} days',
//             imagePath: AssetImages.duration,
//           ),
//           const SizedBox(height: 56),
//           StepControls(),
//           const SizedBox(height: 20)
//         ],
//       ),
//     );
//   }
// }

// class _SummaryItem extends StatelessWidget {
//   const _SummaryItem({required this.title, required this.subtitle, required this.imagePath});
//   final String title;
//   final String subtitle;
//   final String imagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         IconCard(imagePath: imagePath, padding: const EdgeInsets.all(5), radius: 8, size: 35),
//         const SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisize.mn,
//           children: <Widget>[
//             Text(
//               title,
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: context.colors.textDark),
//             ),
//             const SizedBox(height: 3),
//             Text(
//               subtitle,
//               style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: context.colors.text),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
