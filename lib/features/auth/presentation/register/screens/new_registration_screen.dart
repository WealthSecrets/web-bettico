import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewRegistrationScreen extends GetWidget<RegisterController> {
  const NewRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return Obx(
      () => AppLoadingBox(
        loading: controller.isAddingPersonalInformation.value || controller.isSendingSms.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Transform.translate(offset: const Offset(10, 0), child: AppBackButton(onPressed: Get.back)),
          ),
          backgroundColor: context.colors.background,
          body: isSmallScreen
              ? _MainBody(controller: controller)
              : SafeArea(child: Center(child: _MainBody(controller: controller))),
        ),
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody({required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
      child: SingleChildScrollView(
        padding: AppPaddings.lH,
        child: AppAnimatedColumn(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Sign up for Xviral'.tr,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.black),
            ),
            const AppSpacing(v: 8),
            const Text(
              'Enjoy unlimited chat and gamification',
              style: TextStyle(fontWeight: FontWeight.w400, height: 1.22, fontSize: 14),
            ),
            const AppSpacing(v: 20),
            AppTextInput(
              hintText: 'first_name'.tr,
              validator: controller.validateFirstName,
              onChanged: controller.onFirstNameInputChanged,
            ),
            const AppSpacing(v: 8),
            AppTextInput(
              hintText: 'last_name'.tr,
              validator: controller.validateLastName,
              onChanged: controller.onLastNameInputChanged,
            ),
            const AppSpacing(v: 8),
            AppTextInput(
              hintText: 'Phone number or email',
              validator: controller.validateLastName,
              onChanged: controller.onLastNameInputChanged,
            ),
            const AppSpacing(v: 8),
            AppDatePicker(
              hintText: 'dob'.tr,
              validator: (DateTime? dateOfBirth) =>
                  controller.validateMinimumAge(dateOfBirth: dateOfBirth ?? DateTime.now(), minimumAge: 18),
              onDateTimeChanged: controller.onDateOfBirthInputChanged,
            ),
            const SizedBox(height: 8),
            const Text(
              'This will be displayed publicly. Confirm your own age, even if the account is for business, a pet , or something else',
              style: TextStyle(fontSize: 12, color: Color(0xFF7E8B99)),
            ),
            const AppSpacing(v: 100),
            AppButton(
              // enabled: controller.personalFormIsValid,
              borderRadius: BorderRadius.circular(12),
              onPressed: () {
                // controller.updatePersonalInformation(context);
                Get.toNamed<void>(AppRoutes.otpVerifyEmail);
              },
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const AppSpacing(v: 100),
          ],
        ),
      ),
    );
  }
}
