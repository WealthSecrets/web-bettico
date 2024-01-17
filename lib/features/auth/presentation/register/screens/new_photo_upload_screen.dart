import 'package:betticos/assets/app_asset_icons.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPhotoUploadScreen extends StatelessWidget {
  NewPhotoUploadScreen({super.key});

  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: AppBackButton(onPressed: Get.back),
      ),
      backgroundColor: context.colors.background,
      body: Padding(
        padding: AppPaddings.lH,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppAnimatedColumn(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Text(
                    'Pick a profile picture',
                    style: context.h5.copyWith(fontWeight: FontWeight.w600, color: context.colors.textInputText),
                  ),
                ),
                const AppSpacing(v: 8),
                SizedBox(
                  child: Text(
                    'Have a favorite selfie? Upload it now.',
                    style: context.body2.copyWith(fontWeight: FontWeight.w400, height: 1.22),
                  ),
                ),
                const AppSpacing(v: 56),
                Align(
                  child: Stack(
                    children: <Widget>[
                      Image.asset(AssetImages.profileFrame, height: 207, width: 207),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(AppAssetIcons.addition, height: 66, width: 66),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            AppButton(
              onPressed: () => Get.toNamed(AppRoutes.bio),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const AppSpacing(v: 8),
            Align(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Skip for later',
                  style: context.body1.copyWith(fontWeight: FontWeight.normal, color: context.colors.primary),
                ),
              ),
            ),
            const AppSpacing(v: 72),
          ],
        ),
      ),
    );
  }
}
