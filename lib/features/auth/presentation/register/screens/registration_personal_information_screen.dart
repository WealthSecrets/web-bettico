import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ionicons/ionicons.dart';

class RegistrationPersonalInformationScreen extends GetWidget<RegisterController> {
  const RegistrationPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isAddingPersonalInformation.value || controller.isSendingSms.value,
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
            child: Center(
              child: SizedBox(
                width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
                child: SingleChildScrollView(
                  padding: AppPaddings.lH,
                  child: AppAnimatedColumn(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'personal_info'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      const AppSpacing(v: 30),
                      Text(
                        'fill_form'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          height: 1.22,
                          fontSize: 16,
                        ),
                      ),
                      const AppSpacing(v: 20),
                      AppTextInput(
                        labelText: 'first_name'.tr.toUpperCase(),
                        prefixIcon: Icon(
                          Ionicons.person_outline,
                          color: context.colors.hintLight,
                        ),
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
                        ),
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
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
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        validator: controller.validateUsername,
                        onChanged: controller.onUsernameInputChanged,
                      ),
                      const AppSpacing(v: 8),
                      AppDatePicker(
                        labelText: 'dob'.tr.toUpperCase(),
                        validator: (DateTime? dateOfBirth) =>
                            controller.validateMinimumAge(dateOfBirth: dateOfBirth ?? DateTime.now(), minimumAge: 18),
                        onDateTimeChanged: controller.onDateOfBirthInputChanged,
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
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
                        lableStyle: TextStyle(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                        validator: controller.validatePhone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(' '),
                        ],
                        onChanged: (PhoneNumber number) =>
                            controller.onPhoneInputChanged(number.phoneNumber, number.isoCode),
                      ),
                      AppCountryPicker(
                        onChanged: (CountryCode code) {},
                        dialogTextStyle: context.caption.copyWith(color: context.colors.black),
                        showFlagMain: false,
                        showFlag: false,
                        initialSelection: 'GH',
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        alignLeft: true,
                        textStyle: context.caption.copyWith(color: context.colors.black),
                        onInit: (CountryCode? code) {},
                      ),
                      const AppSpacing(v: 20),
                      AppButton(
                        enabled: controller.personalFormIsValid,
                        borderRadius: AppBorderRadius.largeAll,
                        onPressed: () => controller.updatePersonalInformation(context),
                        child: Text(
                          'next'.tr.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const AppSpacing(v: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
