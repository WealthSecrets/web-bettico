import 'package:flutter/material.dart';

import '/core/core.dart';

class AppSelectableTile extends StatelessWidget {
  const AppSelectableTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onPressed,
    this.subtitle,
    this.inactiveIcon,
    this.padding,
    this.width,
    this.textOverflow,
  }) : super(key: key);
  final Widget icon;
  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onPressed;
  final Widget? inactiveIcon;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 800),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.largeAll.add(AppBorderRadius.mediumAll),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: context.colors.textDark.withOpacity(.2),
          ),
        ],
        border: Border.all(
          width: 1.4,
          color: selected
              ? context.colors.primary
              : context.colors.primary.shade100,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: padding ?? AppPaddings.sA,
          shape: RoundedRectangleBorder(
            borderRadius:
                AppBorderRadius.largeAll.add(AppBorderRadius.mediumAll),
          ),
          backgroundColor: selected
              ? context.colors.primary.shade100
              : context.colors.primary.shade50,
        ),
        child: Row(
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 900),
              reverseDuration: Duration.zero,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final Animation<double> scale =
                    Tween<double>(begin: selected ? 0.7 : 1.0, end: 1.0)
                        .animate(animation);
                return ScaleTransition(
                  scale: scale,
                  child: child,
                );
              },
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.elasticInOut.flipped,
              child: Builder(
                key: ValueKey<bool>(selected),
                builder: (_) {
                  if (selected) {
                    return icon;
                  } else {
                    return inactiveIcon != null
                        ? inactiveIcon!
                        : ColorFiltered(
                            //from https://api.flutter.dev/flutter/dart-ui/ColorFilter/ColorFilter.matrix.html
                            colorFilter: const ColorFilter.matrix(
                              <double>[
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0,
                                0,
                                0,
                                1,
                                0,
                              ],
                            ),
                            child: icon,
                          );
                  }
                },
              ),
            ),
            const AppSpacing(h: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: subtitle == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: context.caption.copyWith(
                      color: context.colors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: textOverflow,
                  ),
                  if (subtitle != null) const AppSpacing(v: 4),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: context.overline.copyWith(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: textOverflow,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
