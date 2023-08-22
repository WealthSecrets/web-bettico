import 'dart:math';

import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoTextInputWrapper extends StatelessWidget {
  const AutoTextInputWrapper({super.key, required this.child, required this.labelText});

  final Widget child;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            labelText,
            textAlign: TextAlign.left,
            style: context.overline.copyWith(color: context.colors.text, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            minHeight: max(35.h.toDouble(), 35),
          ),
          margin: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(borderRadius: AppBorderRadius.smallAll, color: Colors.white),
          child: AnimatedOpacity(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            child: child,
          ),
        ),
      ],
    );
  }
}
