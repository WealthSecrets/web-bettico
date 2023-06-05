import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';

class ReviewAccountScreen extends StatelessWidget {
  const ReviewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              disabled: true,
              // prefixIcon: Icon(Ionicons.mail_outline, color: context.colors.hintLight, size: 18),
              initialValue: 'mensahrichmondb@gmail.com',
              backgroundColor: context.colors.primary.shade100,
              lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
              validator: (String email) => null,
              onChanged: (String email) {},
            ),
            const AppSpacing(v: 8),
            AppPhoneInput(
              labelText: 'phone_number'.tr.toUpperCase(),
              initialValue: '0247656959',
              textInputType: TextInputType.phone,
              backgroundColor: context.colors.primary.shade100,
              lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
              searchHintText: 'Search country code',
              validator: (String value) => null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.deny(' '),
              ],
              onChanged: (String value) {},
            ),
            const AppSpacing(v: 8),
            AppTextInput(
              labelText: 'BIO',

              maxLines: 5,
              borderRadius: AppBorderRadius.card,
              // prefixIcon: Icon(Ionicons.person_sharp, color: context.colors.hintLight, size: 18),
              hintText: 'Let your followers get to know something about you.',
              backgroundColor: context.colors.primary.shade100,
              lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
              validator: (String email) => null,
              onChanged: (String email) {},
            ),
            const AppSpacing(v: 8),
            AppTextInput(
              labelText: 'WEBSITE',
              disabled: true,
              // prefixIcon: Icon(Icons.web_sharp, color: context.colors.hintLight, size: 18),
              backgroundColor: context.colors.primary.shade100,
              lableStyle: TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
              validator: (String email) => null,
              onChanged: (String email) {},
            ),
            const Spacer(),
            AppButton(
              borderRadius: AppBorderRadius.largeAll,
              backgroundColor: context.colors.primary,
              onPressed: () {},
              child: Text(
                'next'.tr.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const AppSpacing(v: 40),
          ],
        ),
      ),
    );
  }
}
