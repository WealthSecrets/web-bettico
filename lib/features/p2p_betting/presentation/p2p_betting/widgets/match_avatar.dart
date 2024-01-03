import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class MatchAvatar extends StatelessWidget {
  const MatchAvatar({
    super.key,
    this.logo,
    required this.selected,
    this.disabled,
    this.onPressed,
    this.backgroundColor,
  });
  final String? logo;
  final bool selected;
  final bool? disabled;
  final Color? backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 60,
        padding: AppPaddings.sA,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected
                ? backgroundColor?.withOpacity(disabled! ? 0.6 : 1) ??
                    context.colors.primary.withOpacity(disabled! ? 0.6 : 1)
                : context.colors.text,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(child: logo != null ? Image.network(logo!, height: 45, width: 45) : const SizedBox.shrink()),
      ),
    );
  }
}
