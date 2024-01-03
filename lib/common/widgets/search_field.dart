import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.onChanged,
    this.showSortBy,
    this.isLoading,
    this.controller,
    this.initialValue,
    this.hintText,
    this.suffixIcon,
  });

  final Function(String text)? onChanged;
  final bool? showSortBy;
  final bool? isLoading;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? validator) => null,
      controller: controller,
      initialValue: initialValue,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: context.colors.textDark,
      ),
      decoration: InputDecoration(
        hintText: hintText ?? 'Search crypto',
        prefixIconConstraints: const BoxConstraints(maxHeight: 30),
        prefixIcon: isLoading ?? false
            ? Container(
                height: 25,
                width: 25,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const LoadingLogo(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Ionicons.search_sharp,
                  color: context.colors.text,
                  size: 20,
                ),
              ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: showSortBy ?? false ? const BoxConstraints(maxHeight: 20, maxWidth: 36) : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8).add(const EdgeInsets.symmetric(vertical: 4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: .4,
            color: context.colors.primary.shade100,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: .4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: context.colors.primary,
            width: .4,
          ),
        ),
        hintStyle: TextStyle(
          color: context.colors.text,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: onChanged,
    );
  }
}
