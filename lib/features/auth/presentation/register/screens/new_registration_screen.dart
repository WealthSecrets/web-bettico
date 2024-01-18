import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewRegistrationScreen extends GetWidget<RegisterController> {
  NewRegistrationScreen({super.key});

  final String? params = Get.parameters['type'];

  @override
  Widget build(BuildContext context) {
    final bool isWalletConnect = params != null && params!.toLowerCase() == 'walletconnect';
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return Obx(
      () => AppLoadingBox(
        loading: controller.isSendingSms.value || controller.isRegisteringUser.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Transform.translate(offset: const Offset(10, 0), child: AppBackButton(onPressed: Get.back)),
          ),
          backgroundColor: context.colors.background,
          body: isSmallScreen
              ? _MainBody(controller: controller, isWalletConnect: isWalletConnect)
              : SafeArea(child: Center(child: _MainBody(controller: controller, isWalletConnect: isWalletConnect))),
        ),
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody({required this.controller, required this.isWalletConnect});

  final RegisterController controller;
  final bool isWalletConnect;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
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
                hintText: 'Email',
                validator: controller.validateEmail,
                onChanged: controller.onEmailInputChanged,
                textInputType: TextInputType.emailAddress,
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
                enabled: controller.registrationFormIsValid,
                borderRadius: BorderRadius.circular(12),
                onPressed: () => controller.register(context, isWalletConnect: isWalletConnect),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const AppSpacing(v: 100),
            ],
          ),
        ),
      ),
    );
  }
}
