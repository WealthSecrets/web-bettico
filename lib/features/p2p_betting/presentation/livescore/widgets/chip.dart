import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class ChipCard extends StatelessWidget {
  const ChipCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.largeAll,
          color: context.colors.grey.withOpacity(.05),
        ),
        child: child,
      ),
    );
  }
}
