import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/betticos/presentation/profile/getx/profile_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';

class UpdateProfileScreen extends GetWidget<ProfileController> {
  UpdateProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  final BaseScreenController bController = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: ResponsiveWidget.isSmallScreen(context)
            ? IconButton(
                icon: const Icon(
                  Ionicons.chevron_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.back<void>();
                },
              )
            : null,
        title: Text(
          'update_profile'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isUpdatingUserProfile.value,
          child: SafeArea(
            child: SizedBox.expand(
              child: SingleChildScrollView(
                padding: AppPaddings.lH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppAnimatedColumn(
                      direction: Axis.horizontal,
                      duration: const Duration(milliseconds: 1000),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const AppSpacing(v: 20),
                        AppTextInput(
                          labelText: 'first_name'.tr.toUpperCase(),
                          prefixIcon: Icon(
                            Ionicons.person_outline,
                            color: context.colors.hintLight,
                            size: 18,
                          ),
                          initialValue: user.firstName,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          validator: controller.validateFirstName,
                          onChanged: controller.onFirstNameInputChanged,
                        ),
                        const AppSpacing(v: 8),
                        AppTextInput(
                          labelText: 'last_name'.tr.toUpperCase(),
                          prefixIcon: Icon(
                            Ionicons.person_outline,
                            color: context.colors.hintLight,
                            size: 18,
                          ),
                          initialValue: user.lastName,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          validator: controller.validateLastName,
                          onChanged: controller.onLastNameInputChanged,
                        ),
                        AppTextInput(
                          labelText: 'username'.tr.toUpperCase(),
                          prefixIcon: Icon(
                            Ionicons.person_outline,
                            color: context.colors.hintLight,
                            size: 18,
                          ),
                          initialValue: user.username,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          validator: controller.validateUserName,
                          onChanged: controller.onUserNameInputChanged,
                        ),
                        const AppSpacing(v: 8),
                        AppTextInput(
                          labelText: 'email'.tr.toUpperCase(),
                          disabled: true,
                          prefixIcon: Icon(
                            Ionicons.mail_outline,
                            color: context.colors.hintLight,
                            size: 18,
                          ),
                          initialValue: user.email,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          validator: controller.validateEmail,
                          onChanged: controller.onEmailInputChanged,
                        ),
                        const AppSpacing(v: 8),
                        AppDatePicker(
                          disabled: true,
                          labelText: 'dob'.tr.toUpperCase(),
                          validator: (DateTime? dateOfBirth) =>
                              controller.validateMinimumAge(
                            dateOfBirth: dateOfBirth ?? DateTime.now(),
                            minimumAge: 18,
                          ),
                          onDateTimeChanged:
                              controller.onDateOfBirthInputChanged,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          initialDate: user.dateOfBirth,
                        ),
                        const AppSpacing(v: 8),
                        AppPhoneInput(
                          labelText: 'phone_number'.tr.toUpperCase(),
                          initialValue: user.phone,
                          textInputType: TextInputType.phone,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          searchHintText: 'Search country code',
                          validator: controller.validatePhone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(' '),
                          ],
                          onChanged: controller.onPhoneInputChanged,
                        ),
                        const AppSpacing(v: 49),
                        AppButton(
                          enabled: true,
                          borderRadius: AppBorderRadius.largeAll,
                          onPressed: () async {
                            final Either<Failure, User> failurOrUser =
                                await controller.updateProfile(context);

                            failurOrUser.fold((Failure failure) {
                              controller.setUpdatingUserProfile(false);
                              AppSnacks.show(context, message: failure.message);
                            }, (User user) {
                              controller.setUpdatingUserProfile(false);
                              bController.updateTheUser(user);
                              controller.setProfileUser(user);
                              Navigator.of(context).pop(true);
                            });
                          },
                          // onPressed: () => Get.back<void>(),
                          child: Text(
                            'update_profile'.tr.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const AppSpacing(v: 50),
                      ],
                    ),
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
