import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '/core/presentation/presentation.dart';

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
      icon: Icon(Ionicons.chevron_back, color: color ?? context.colors.textDark, size: 20),
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
