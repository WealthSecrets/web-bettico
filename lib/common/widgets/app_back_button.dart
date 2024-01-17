import 'package:betticos/assets/assets.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.color, this.rootNavigator = false, this.onPressed});

  final Color? color;
  final bool rootNavigator;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.of(context, rootNavigator: rootNavigator).maybePop();
        }
      },
      icon: Image.asset(AppAssetIcons.arrowLeft, color: color ?? context.colors.textDark, height: 24, width: 24),
    );
  }
}

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({super.key, this.color, this.rootNavigator = false, this.onPressed});

  final Color? color;
  final bool rootNavigator;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.of(context, rootNavigator: rootNavigator).maybePop();
        }
      },
      icon: Icon(Icons.close, color: color ?? context.colors.text, size: 25),
    );
  }
}
