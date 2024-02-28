import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

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
    this.fillColor,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.contentPadding,
    this.style,
  });

  final Function(String text)? onChanged;
  final bool? showSortBy;
  final bool? isLoading;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;
  final Color? fillColor;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? validator) => null,
      controller: controller,
      initialValue: initialValue,
      style: style ?? TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: context.colors.textDark),
      decoration: InputDecoration(
        hintText: hintText ?? 'Search...',
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
                child: Image.asset(AppAssetIcons.search, color: context.colors.darkenText, height: 15.50, width: 15.50),
              ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: showSortBy ?? false ? const BoxConstraints(maxHeight: 20, maxWidth: 36) : null,
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 8).add(const EdgeInsets.symmetric(vertical: 4)),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: .4, color: context.colors.primary.shade100),
            ),
        disabledBorder: disabledBorder ??
            const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: .4),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: context.colors.primary, width: .4),
            ),
        hintStyle: TextStyle(
          color: context.colors.text,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        filled: true,
        fillColor: fillColor ?? Colors.white,
      ),
      onChanged: onChanged,
    );
  }
}
