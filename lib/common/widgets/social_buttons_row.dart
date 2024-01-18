import 'package:betticos/common/common.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialButtonsRow extends StatelessWidget {
  SocialButtonsRow({super.key, this.mainAxisAlignment, this.size});

  final MainAxisAlignment? mainAxisAlignment;
  final double? size;

  final RegisterController rController = Get.find<RegisterController>();
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Image.asset(AssetImages.wallets, height: 55, width: 55),
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () {},
          child: Image.asset(AssetImages.facebookn, height: size ?? 40, width: size ?? 40),
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () => rController.registerWithGoogleAuth(context, routeName: AppRoutes.newUsername),
          child: Image.asset(AssetImages.googlen, height: size ?? 40, width: size ?? 40),
        ),
      ],
    );
  }
}
