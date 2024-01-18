import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationInterestsScreen extends StatelessWidget {
  RegistrationInterestsScreen({super.key});

  final RegisterController controller = Get.find<RegisterController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
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
        () {
          return AppLoadingBox(
            loading: bController.isGettingSetup.value || controller.isAddingPersonalInformation.value,
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
                          'What do you want to see on Xviral',
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
                          'Select at least 7 interest to personalize your xviral exprience. They will be visible on your profile.',
                          style: context.body2.copyWith(fontWeight: FontWeight.w400, height: 1.22),
                        ),
                      ),
                      const AppSpacing(v: 56),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: bController.setup.value.interests
                            .map(
                              (String interest) => AppSelectableButton(
                                text: interest,
                                onPressed: () {
                                  if (controller.interests.contains(interest)) {
                                    controller.interests.remove(interest);
                                  } else {
                                    controller.interests.add(interest);
                                  }
                                },
                                selected: controller.interests.contains(interest),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppButton(
                    enabled: controller.hasInterest,
                    onPressed: () => controller.updatePersonalInformation(context,
                        hideUsername: true, routeName: AppRoutes.newProfilePhoto),
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
                      //     loginController.reRouteOddster(context, args!.user, skip: Skip.interest);
                      //   } else {
                      //     Get.toNamed<void>(AppRoutes.newProfilePhoto);
                      //   }
                      // },
                      onPressed: () => Get.toNamed<void>(AppRoutes.newProfilePhoto),
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
        },
      ),
    );
  }
}
