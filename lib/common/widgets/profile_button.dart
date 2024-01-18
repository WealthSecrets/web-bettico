import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
  });

  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(color: borderColor ?? context.colors.primary),
          borderRadius: AppBorderRadius.card,
        ),
        child: child,
      ),
    );
  }
}