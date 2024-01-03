import 'package:betticos/core/presentation/themes/themes.dart';
import 'package:flutter/material.dart';

import '../utils/app_border_radius.dart';

class PageViewIndicators extends StatelessWidget {
  const PageViewIndicators({super.key, required this.itemCount, required this.activeItemIndex})
      : assert(activeItemIndex <= itemCount);

  final int itemCount;
  final int activeItemIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        itemCount,
        (int index) => AnimatedContainer(
          height: 2,
          width: activeItemIndex == index ? 26 : 16,
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.smallAll,
            color: index == activeItemIndex ? context.colors.blue : context.colors.hintLight,
          ),
        ),
      ),
    );
  }
}
