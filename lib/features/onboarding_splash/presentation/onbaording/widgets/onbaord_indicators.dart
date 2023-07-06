import 'package:flutter/material.dart';
import '/core/core.dart';

class OnboardIndicators extends StatelessWidget {
  const OnboardIndicators({super.key, required this.itemCount, required this.activeItem, this.radius})
      : assert(activeItem <= itemCount);

  final int itemCount;
  final int activeItem;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        itemCount,
        (int index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: radius ?? 10,
          width: radius ?? 10,
          decoration: BoxDecoration(
            color: context.colors.primary.withOpacity(index == activeItem ? 1.0 : 0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
