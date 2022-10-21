import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/widgets/search_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    this.onChanged,
    this.showSortBy,
    this.isLoading,
    this.controller,
    this.initialValue,
  }) : super(key: key);

  final Function(String text)? onChanged;
  final bool? showSortBy;
  final bool? isLoading;
  final TextEditingController? controller;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            validator: (String? validator) => null,
            controller: controller,
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: 'Search..',
              prefixIconConstraints: const BoxConstraints(maxHeight: 30),
              prefixIcon: isLoading ?? false
                  ? Container(
                      height: 25,
                      width: 25,
                      margin: AppPaddings.mH,
                      child: const LoadingLogo(),
                    )
                  : Padding(
                      padding: AppPaddings.mH,
                      child: Icon(
                        Ionicons.search_outline,
                        color: context.colors.text,
                        size: 20,
                      ),
                    ),
              suffixIcon: showSortBy ?? false
                  ? InkWell(
                      onTap: () {
                        showCustomModalBottomSheet<void>(
                          containerWidget: (_, __, Widget child) => ClipRRect(
                            borderRadius: AppBorderRadius.largeTop,
                            child: Material(child: child),
                          ),
                          animationCurve: Curves.fastLinearToSlowEaseIn,
                          duration: const Duration(milliseconds: 500),
                          bounce: true,
                          context: context,
                          builder: (_) => const SearchFilterBottomSheet(),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            AssetImages.filter,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    )
                  : null,
              suffixIconConstraints: showSortBy ?? false
                  ? const BoxConstraints(maxHeight: 20, maxWidth: 36)
                  : null,
              contentPadding: AppPaddings.mH.add(AppPaddings.sV),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.smallAll,
                borderSide: BorderSide(
                  width: .4,
                  color: context.colors.primary.shade100,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.smallAll,
                borderSide: const BorderSide(width: .4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.smallAll,
                borderSide: BorderSide(
                  color: context.colors.primary,
                  width: .4,
                ),
              ),
              hintStyle: TextStyle(
                color: context.colors.hintLight,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        if (showSortBy ?? false)
          GestureDetector(
            onTap: () {
              showCustomModalBottomSheet<void>(
                containerWidget: (_, __, Widget child) => ClipRRect(
                  borderRadius: AppBorderRadius.largeTop,
                  child: Material(child: child),
                ),
                animationCurve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 500),
                bounce: true,
                context: context,
                builder: (_) => const SearchFilterBottomSheet(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Filter By',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Image.asset(
                    AssetImages.caretDown,
                    width: 12,
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
