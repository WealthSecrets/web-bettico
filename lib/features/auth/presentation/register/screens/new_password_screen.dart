import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
                    'You will need a password',
                    style: context.h5.copyWith(fontWeight: FontWeight.w600, color: context.colors.textInputText),
                  ),
                ),
                const AppSpacing(v: 8),
                SizedBox(
                  child: Text(
                    'Make sure it’s 8 character or more',
                    style: context.body2.copyWith(fontWeight: FontWeight.w400, height: 1.22),
                  ),
                ),
                const AppSpacing(v: 24),
                AppTextInput(
                  hintText: 'Password',
                  obscureText: true,
                  showObscureTextToggle: true,
                  validator: (String _) => null,
                  onChanged: (String password) {},
                ),
              ],
            ),
            const Spacer(),
            AppButton(
              onPressed: () => Get.toNamed(AppRoutes.newUsername),
              child: const Text(
                'Next',
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
