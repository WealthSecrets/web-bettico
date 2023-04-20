import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/core/core.dart';

class OnboardCard extends StatelessWidget {
  const OnboardCard({
    Key? key,
    required this.text,
    required this.svgAssetPath,
    required this.index,
    required this.isActive,
    required this.isPrevious,
  }) : super(key: key);

  final List<String> text;
  final int index;
  final bool isActive;
  final String svgAssetPath;
  final bool isPrevious;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const AppSpacing(v: 50),
        AnimatedSwitcher(
          switchInCurve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 1000),
          reverseDuration: Duration.zero,
          child: Builder(
            key: ValueKey<bool>(isActive),
            builder: (BuildContext context) {
              if (!isActive) {
                return const SizedBox();
              }
              return Padding(
                padding: AppPaddings.bodyH,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TweenAnimationBuilder<double>(
                      curve: Curves.fastLinearToSlowEaseIn,
                      tween: Tween<double>(begin: 0.4, end: 1.0),
                      duration: const Duration(milliseconds: 1200),
                      builder: (BuildContext context, double offset, Widget? child) {
                        return Transform.scale(scale: offset, child: child);
                      },
                      child: ClipRRect(
                        child: SvgPicture.asset(
                          svgAssetPath,
                          height: 300,
                        ),
                      ),
                    ),
                    const AppSpacing(v: 50),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List<Widget>.generate(
                          text.length,
                          (int index) {
                            return TweenAnimationBuilder<Offset>(
                              curve: Curves.fastLinearToSlowEaseIn,
                              tween: Tween<Offset>(begin: Offset(index == 1 ? 0 : 10, 150), end: Offset.zero),
                              builder: (BuildContext context, Offset offset, Widget? child) {
                                return Transform.translate(
                                  offset: offset,
                                  child: child,
                                );
                              },
                              duration: Duration(milliseconds: (1000 + index * 500).toInt()),
                              child: Text(
                                text[index],
                                style: context.h6.copyWith(color: context.colors.primary).copyWith(
                                      height: 1.3,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
