import 'package:betticos/features/auth/presentation/register/arguments/user_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '/core/core.dart';
import '/features/auth/presentation/register/getx/register_controller.dart';

class RegistrationPersonalInformationScreen
    extends GetWidget<RegisterController> {
  const RegistrationPersonalInformationScreen({Key? key}) : super(key: key);
  static const String route = '/register/personal-information';

  @override
  Widget build(BuildContext context) {
    final UserArgument? args =
        ModalRoute.of(context)?.settings.arguments as UserArgument?;
    return Obx(
      () => AppLoadingBox(
        loading: controller.isAddingPersonalInformation.value ||
            controller.isSendingSms.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Transform.translate(
              offset: const Offset(10, 0),
              child: const AppBackButton(),
            ),
          ),
          backgroundColor: context.colors.background,
          body: SafeArea(
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
                        Text(
                          'personal_info'.tr,
                          style: context.h4.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const AppSpacing(v: 30),
                        Text(
                          'fill_form'.tr,
                          style: context.body1.copyWith(
                            fontWeight: FontWeight.w500,
                            height: 1.22,
                          ),
                        ),
                        const AppSpacing(v: 20),
                        AppTextInput(
                          labelText: 'first_name'.tr.toUpperCase(),
                          prefixIcon: Icon(
                            Ionicons.person_outline,
                            color: context.colors.hintLight,
                          ),
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: context.overline.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
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
                          ),
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: context.overline.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          validator: controller.validateLastName,
                          onChanged: controller.onLastNameInputChanged,
                        ),
                        const AppSpacing(v: 8),
                        AppTextInput(
                          labelText: 'username'.tr.toUpperCase(),
                          prefixIcon: Icon(
                            Ionicons.person_outline,
                            color: context.colors.hintLight,
                          ),
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: context.overline.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          validator: controller.validateUsername,
                          onChanged: controller.onUsernameInputChanged,
                        ),
                        const AppSpacing(v: 8),
                        AppDatePicker(
                          labelText: 'dob'.tr,
                          validator: (DateTime? dateOfBirth) =>
                              controller.validateMinimumAge(
                                  dateOfBirth: dateOfBirth ?? DateTime.now(),
                                  minimumAge: 18),
                          onDateTimeChanged:
                              controller.onDateOfBirthInputChanged,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: context.overline.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const AppSpacing(v: 8),
                        AppPhoneInput(
                          labelText: 'phone_number'.tr,
                          prefixIcon: Icon(
                            Ionicons.call_outline,
                            color: context.colors.hintLight,
                          ),
                          textInputType: TextInputType.phone,
                          backgroundColor: context.colors.primary.shade100,
                          lableStyle: context.overline.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          validator: controller.validatePhone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(' '),
                          ],
                          onChanged: controller.onPhoneInputChanged,
                        ),
                        const AppSpacing(v: 20),
                        AppButton(
                          enabled: controller.personalFormIsValid,
                          borderRadius: AppBorderRadius.largeAll,
                          onPressed: () => controller.updatePersonalInformation(
                            context,
                            u: args?.user,
                          ),
                          child: Text(
                            'next'.tr.toUpperCase(),
                          ),
                        ),
                        const AppSpacing(v: 100),
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
