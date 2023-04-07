import 'package:flutter/material.dart';

class TapOutsideUnfocus extends StatelessWidget {
  const TapOutsideUnfocus({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
