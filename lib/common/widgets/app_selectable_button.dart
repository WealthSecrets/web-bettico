import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class AppSelectableButton extends StatelessWidget {
  const AppSelectableButton({super.key, required this.text, required this.onPressed, this.selected = false});

  final String text;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.sV.add(AppPaddings.lH),
      decoration: BoxDecoration(
        color: selected ? context.colors.primary : const Color(0xFFF5F7F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: context.sub2.copyWith(
          color: selected ? Colors.white : context.colors.textInputText,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
