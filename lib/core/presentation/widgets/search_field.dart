import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
    return TextFormField(
      validator: (String? validator) => null,
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: 'Search crypto',
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
                  Ionicons.search_sharp,
                  color: context.colors.text,
                  size: 20,
                ),
              ),
        suffixIcon: null,
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
          color: context.colors.text,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: onChanged,
    );
  }
}
