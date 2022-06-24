import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing extends StatelessWidget {
  const AppSpacing({
    ///vertical space
    this.v = 0,

    ///horizontal space
    this.h = 0,
    Key? key,
  }) : super(key: key);

  final int v;
  final int h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: ValueKey<String>('$v$h'),
      height: v.h,
      width: h.w,
    );
  }
}
