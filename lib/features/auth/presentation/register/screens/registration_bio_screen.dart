import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegistrationBioScreen extends StatelessWidget {
  RegistrationBioScreen({super.key});

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
          loading: controller.isAddingPersonalInformation.value,
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
                      width: 203,
                      child: Text(
                        'Describe yourself',
                        style: context.h5.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colors.textInputText,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    const AppSpacing(v: 8),
                    SizedBox(
                      child: Text(
                        'What makes you special? Don’t think too hard, just have fun with it.',
                        style: context.body2.copyWith(fontWeight: FontWeight.w400, height: 1.22),
                      ),
                    ),
                    const AppSpacing(v: 24),
                    ColoredBox(
                      color: context.colors.textInputBackground,
                      child: TextFormField(
                        onChanged: controller.onBioInputChanged,
                        validator: controller.validateBio,
                        maxLength: 160,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 16),
                          counterStyle: TextStyle(fontSize: 16),
                        ),
                        style: TextStyle(fontSize: 16, color: context.colors.black),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  enabled: controller.hasBio,
                  onPressed: () => controller.updatePersonalInformation(
                    context,
                    hideUsername: true,
                    routeName: AppRoutes.home,
                  ),
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
                    //     loginController.reRouteOddster(context, args!.user, skip: Skip.bio);
                    //   } else {
                    //     Get.toNamed<void>(AppRoutes.followAccounts);
                    //   }
                    // },
                    onPressed: () => Get.toNamed<void>(AppRoutes.followAccounts),
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
