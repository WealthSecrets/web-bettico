// import 'package:betticos/core/core.dart';
// import 'package:betticos/features/p2p_betting/data/models/country/country.dart';
// import 'package:efficient_autocomplete_formfield/efficient_autocomplete_formfield.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';

// class SearchCountriesTextField extends StatelessWidget {
//   const SearchCountriesTextField({
//     super.key,
//     required this.controller,
//     required this.beneficiaries,
//     required this.onChanged,
//     this.decoration,
//   });

//   final TextEditingController controller;
//   final List<Country> beneficiaries;
//   final ValueChanged<Country> onChanged;

//   /// Only a subset of properties are actually applied
//   final InputDecoration? decoration;

//   @override
//   Widget build(BuildContext context) {
//     return EfficientAutocompleteFormField<Country>(
//       controller: controller,
//       decoration: InputDecoration(
//         filled: decoration?.filled ?? true,
//         contentPadding: decoration?.contentPadding ?? const EdgeInsets.all(15),
//         fillColor: decoration?.fillColor ?? context.colors.background,
//         floatingLabelBehavior: FloatingLabelBehavior.never,
//         hintStyle: context.body1.copyWith(
//           fontWeight: FontWeight.w400,
//           color: context.colors.hint,
//           height: 1.4,
//         ),
//       ),
//       suggestionsHeight: 160.0,
//       itemBuilder: (BuildContext txtContext, Country? beneficiary) {
//         return ListTile(
//           leading: Icon(Ionicons.flag, size: 24, color: context.colors.primary),
//           title: Text(
//             beneficiary!.name,
//             style: context.body1.copyWith(color: Colors.black),
//           ),
//           subtitle: Text(
//             '${AppStrings.type}: ${beneficiary.type}',
//             style: context.caption.copyWith(color: context.colors.text),
//           ),
//         );
//       },
//       onSearch: (String search) async => beneficiaries
//           .where((Beneficiary beneficiary) =>
//               beneficiary.name.toLowerCase().contains(search.toLowerCase()))
//           .toList(),
//       itemFromString: (String string) {
//         final List<Beneficiary> matches = beneficiaries
//             .where((Beneficiary beneficiary) =>
//                 beneficiary.name.toLowerCase() == string.toLowerCase())
//             .toList();
//         return matches.isEmpty ? null : matches.first;
//       },
//       onChanged: (Beneficiary? beneficiary) {
//         if (beneficiary != null) {
//           controller.text = StringUtils.capitalizeFirst(beneficiary.name);
//           onChanged(beneficiary);
//         }
//       },
//     );
//   }
// }
