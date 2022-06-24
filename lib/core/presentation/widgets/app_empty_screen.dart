import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../core.dart';

class AppEmptyScreen extends StatelessWidget {
  const AppEmptyScreen({
    Key? key,
    this.title,
    required this.message,
    this.onBottonPressed,
  }) : super(key: key);

  final String? title;
  final String message;
  final Function? onBottonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // SvgPicture.asset(
        //   AssetSVGs.emptyState.path,
        //   height: 300,
        // ),
        // const AppSpacing(v: 10),
        Text(
          title ?? 'nothing_to_see'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        const AppSpacing(v: 10),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.colors.text,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
