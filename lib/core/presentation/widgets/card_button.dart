import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.imagePath,
    this.backgroundColor,
    required this.title,
    this.color,
    this.radius,
    this.size,
    this.width,
    this.padding,
    this.hideBorder,
    this.fontSize,
    this.onPressed,
  });

  final String title;
  final String imagePath;
  final Color? backgroundColor;
  final Color? color;
  final double? radius;
  final double? size;
  final double? width;
  final bool? hideBorder;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 60.w,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconCard(
              backgroundColor: backgroundColor,
              color: color,
              imagePath: imagePath,
              radius: radius,
              hideBorder: hideBorder,
              padding: padding,
            ),
            const AppSpacing(v: 8),
            Text(
              title,
              style: TextStyle(fontSize: fontSize ?? 12, fontWeight: FontWeight.normal, color: context.colors.textDark),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
