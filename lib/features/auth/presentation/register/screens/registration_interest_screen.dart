import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationInterestsScreen extends StatelessWidget {
  RegistrationInterestsScreen({super.key});

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
                    'What do you want to see on Xviral',
                    style: context.h5
                        .copyWith(fontWeight: FontWeight.w600, color: context.colors.textInputText, letterSpacing: 0.1),
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
                  children: <Widget>[
                    AppSelectableButton(text: 'Crypto', onPressed: () {}),
                    AppSelectableButton(text: 'Entertainment', onPressed: () {}),
                    AppSelectableButton(text: 'Politics', onPressed: () {}),
                    AppSelectableButton(text: 'Fashion and Beauty', onPressed: () {}, selected: true),
                    AppSelectableButton(text: 'Outdoors', onPressed: () {}),
                    AppSelectableButton(text: 'Foods', onPressed: () {}),
                    AppSelectableButton(text: 'Business and Finance', onPressed: () {}),
                    AppSelectableButton(text: 'Music ', onPressed: () {}),
                    AppSelectableButton(text: 'Gaming', onPressed: () {}),
                  ],
                ),
              ],
            ),
            const Spacer(),
            AppButton(
              onPressed: () => Get.toNamed(AppRoutes.newProfilePhoto),
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
