import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/auth/presentation/register/getx/register_controller.dart';

class RegistrationUploadPhotoScreen extends GetWidget<RegisterController> {
  const RegistrationUploadPhotoScreen({Key? key}) : super(key: key);
  static const String route = '/register/upload-photo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Transform.translate(
          offset: const Offset(10, 0),
          child: const AppBackButton(),
        ),
      ),
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isAddingProfileImage.value,
          child: SafeArea(
            child: SizedBox.expand(
              child: SingleChildScrollView(
                padding: AppPaddings.homeH,
                child: AppAnimatedColumn(
                  direction: Axis.horizontal,
                  duration: const Duration(milliseconds: 1000),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'set_photo'.tr,
                      textAlign: TextAlign.center,
                      style: context.h6.copyWith(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const AppSpacing(v: 40),
                    Text(
                      'take_photo'.tr,
                      textAlign: TextAlign.center,
                      style: context.body1.copyWith(),
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
                      onPressed: () =>
                          controller.updateTheUserProfilePhoto(context),
                      child: Text(
                        'next'.tr,
                      ),
                    ),
                    const AppSpacing(v: 200),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
