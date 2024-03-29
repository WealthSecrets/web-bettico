import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationUploadPhotoScreen extends GetWidget<RegisterController> {
  const RegistrationUploadPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Transform.translate(offset: const Offset(10, 0), child: const AppBackButton()),
      ),
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isAddingProfileImage.value,
          child: SafeArea(
            child: Center(
              child: SizedBox(
                width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
                child: SingleChildScrollView(
                  padding: AppPaddings.homeH,
                  child: AppAnimatedColumn(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'set_photo'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: context.colors.textDark, fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      const AppSpacing(v: 40),
                      Text(
                        'take_photo'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: context.colors.text),
                      ),
                      const AppSpacing(v: 30),
                      UploadButton(
                        type: UploadButtonType.photos,
                        buttonText: 'tap_to_take'.tr,
                        textColor: Colors.white,
                        openFrontCamera: true,
                        onFileSelected: controller.onProfileImageSelected,
                      ),
                      const AppSpacing(v: 50),
                      AppButton(
                        enabled: controller.profileFormIsValid,
                        borderRadius: AppBorderRadius.largeAll,
                        onPressed: () => controller.updateTheUserProfilePhoto(context),
                        child: Text(
                          'next'.tr,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
