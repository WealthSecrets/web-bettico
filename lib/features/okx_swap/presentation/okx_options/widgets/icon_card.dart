import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    Key? key,
    required this.imagePath,
    this.backgroundColor,
    this.color,
    this.padding,
    this.size,
    this.radius,
    this.hideBorder,
    this.onTap,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? radius;
  final String imagePath;
  final double? size;
  final Color? color;
  final bool? hideBorder;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(12),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor != null ? backgroundColor!.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 15),
          border: hideBorder ?? false
              ? null
              : Border.all(
                  color: backgroundColor != null ? backgroundColor!.withOpacity(.5) : const Color(0xFFD2CDDE),
                ),
        ),
        child: SizedBox(
          height: size ?? 23,
          width: size ?? 23,
          child: Image.asset(
            imagePath,
            color: color,
            height: size ?? 23,
            width: size ?? 23,
          ),
        ),
      ),
    );
  }
}
