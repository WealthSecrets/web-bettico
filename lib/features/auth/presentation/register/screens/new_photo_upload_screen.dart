import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPhotoUploadScreen extends StatelessWidget {
  NewPhotoUploadScreen({super.key});

  final RegisterController controller = Get.find<RegisterController>();
  final LoginController loginController = Get.find<LoginController>();

  final RegistrationScreenArgument? args = Get.arguments as RegistrationScreenArgument?;

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
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isAddingProfileImage.value,
          child: Padding(
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
                    UploadButton(
                      type: UploadButtonType.photos,
                      buttonText: 'tap_to_take'.tr,
                      textColor: Colors.white,
                      openFrontCamera: true,
                      onFileSelected: controller.onProfileImageSelected,
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  enabled: controller.profileFormIsValid,
                  onPressed: () => controller.updateTheUserProfilePhoto(context),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const AppSpacing(v: 8),
                Align(
                  child: TextButton(
                    // onPressed: () {
                    //   if (args != null) {
                    //     loginController.reRouteOddster(context, args!.user, skip: Skip.photo);
                    //   } else {
                    //     Get.toNamed<void>(AppRoutes.bio);
                    //   }
                    // },
                    onPressed: () => Get.toNamed<void>(AppRoutes.bio),
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
        ),
      ),
    );
  }
}
