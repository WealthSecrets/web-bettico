import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../core.dart';

class AppEmptyScreen extends StatelessWidget {
  const AppEmptyScreen({
    Key? key,
    this.title,
    this.image,
    required this.message,
    this.onBottonPressed,
    this.btnText,
    this.loading = false,
  }) : super(key: key);

  final String? title;
  final String? image;
  final String message;
  final Function? onBottonPressed;
  final String? btnText;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return AppLoadingBox(
      loading: loading,
      child: Padding(
        padding: AppPaddings.bodyH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (image != null) ...<Widget>[
              SvgPicture.asset(
                image!,
                height: 300,
              ),
              const AppSpacing(v: 10),
            ],
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
            const SizedBox(height: 32),
            if (onBottonPressed != null && btnText != null)
              AppButton(
                padding: EdgeInsets.zero,
                borderRadius: AppBorderRadius.largeAll,
                backgroundColor: context.colors.primary,
                onPressed: () {
                  onBottonPressed?.call();
                },
                child: Text(
                  btnText!.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
