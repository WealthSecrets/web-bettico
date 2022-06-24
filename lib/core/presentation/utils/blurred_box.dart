import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlurredBox extends StatelessWidget {
  const BlurredBox({
    Key? key,
    this.padding,
    this.height,
    this.child,
    this.backgroundColor,
    this.sigmaX = 6,
    this.sigmaY = 6,
  }) : super(key: key);

  final Widget? child;
  final EdgeInsets? padding;
  final double? height;
  final double sigmaX, sigmaY;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 1.sw.toDouble(),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: LimitedBox(
                child: Container(
                  width: 1.sw.toDouble(),
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Container(
            color: backgroundColor ?? Colors.transparent,
            width: 1.sw.toDouble(),
            padding: padding,
            child: child,
          ),
        ],
      ),
    );
  }
}
