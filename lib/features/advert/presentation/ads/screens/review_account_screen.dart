import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../getx/professional_controller.dart';
// import 'package:ionicons/ionicons.dart';

class ReviewAccountScreen extends GetWidget<ProfessionalController> {
  const ReviewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isCreatingBusiness.value,
          child: Padding(
            padding: AppPaddings.lH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 40),
                Text(
                  'Review your contact info',
                  style: context.h6.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'These contact options will be displayed on your profile so people can contact you. You can edit or remove them anytime.',
                  style: context.sub2.copyWith(color: context.colors.text),
                ),
                const SizedBox(height: 16),
                Text(
                  'Public business information',
                  style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'email'.tr.toUpperCase(),
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: controller.validateEmail,
                  onChanged: (String email) => controller.email.value = email,
                ),
                const AppSpacing(v: 8),
                AppPhoneInput(
                  labelText: 'phone_number'.tr.toUpperCase(),
                  textInputType: TextInputType.phone,
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  searchHintText: 'Search country code',
                  validator: (String value) => null,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(' '),
                  ],
                  onChanged: (String value) => controller.phone.value = value,
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'BIO',
                  maxLines: 5,
                  borderRadius: AppBorderRadius.card,
                  hintText: 'Let your followers get to know something about you.',
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String bio) => null,
                  onChanged: (String bio) => controller.bio.value = bio,
                ),
                const AppSpacing(v: 8),
                AppTextInput(
                  labelText: 'WEBSITE',
                  backgroundColor: context.colors.primary.shade100,
                  lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                  validator: (String website) => null,
                  onChanged: (String website) => controller.website.value = website,
                ),
                const Spacer(),
                AppButton(
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.primary,
                  onPressed: () => controller.addBusiness(context),
                  child: Text(
                    'next'.tr.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const AppSpacing(v: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
