import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationFollowAccountsScreen extends StatelessWidget {
  RegistrationFollowAccountsScreen({super.key});

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
                  width: 203,
                  child: Text(
                    'Describe yourself',
                    style: context.h5
                        .copyWith(fontWeight: FontWeight.w600, color: context.colors.textInputText, letterSpacing: 0.1),
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
