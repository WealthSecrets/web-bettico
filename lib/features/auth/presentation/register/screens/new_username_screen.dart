import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewUsernameScreen extends StatelessWidget {
  NewUsernameScreen({super.key});

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
                    'Choose a Username',
                    style: context.h5.copyWith(fontWeight: FontWeight.w600, color: context.colors.textInputText),
                  ),
                ),
                const AppSpacing(v: 8),
                SizedBox(
                  child: Text(
                    'Your unique name for socializing, you can change it at anytime',
                    style: context.body2.copyWith(fontWeight: FontWeight.w400, height: 1.22),
                  ),
                ),
                const AppSpacing(v: 24),
                AppTextInput(
                  hintText: 'username'.tr,
                  validator: controller.validateUsername,
                  onChanged: controller.onUsernameInputChanged,
                  suffixIcon: Image.asset(AppAssetIcons.checkCircle, height: 24, width: 24),
                ),
              ],
            ),
            const Spacer(),
            AppButton(
              onPressed: () => Get.toNamed(AppRoutes.interests),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const AppSpacing(v: 50),
          ],
        ),
      ),
    );
  }
}
