import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    this.backgroundColor,
    this.color,
    required this.imagePath,
    this.padding,
    this.height,
    this.width,
    this.radius,
  });

  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? radius;
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      width: width ?? 45,
      decoration: BoxDecoration(
        color: backgroundColor != null ? backgroundColor!.withOpacity(0.1) : const Color(0xFFF6F2FF),
        borderRadius: BorderRadius.circular(radius ?? 6),
        border: Border.all(
          color: backgroundColor != null ? backgroundColor!.withOpacity(.5) : const Color(0xFFF6F2FF),
        ),
      ),
      child: Center(
        child: Image.asset(imagePath, color: color ?? backgroundColor, height: 16.83, width: 16.83),
      ),
    );
  }
}
