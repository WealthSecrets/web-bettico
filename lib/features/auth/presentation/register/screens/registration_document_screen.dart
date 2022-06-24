import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/auth/presentation/register/getx/register_controller.dart';

const List<String> documentTypes = <String>[
  'Passport',
  'Voter ID',
  'National Card',
  'Driver\'s License'
];

class RegistrationDocumentScreen extends GetWidget<RegisterController> {
  const RegistrationDocumentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isAddingDocument.value,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text(
              'identification'.tr,
              style: context.body1.copyWith(
                color: Colors.black,
                // fontFamily: AppFonts.julius,
              ),
            ),
          ),
          backgroundColor: context.colors.background,
          body: Builder(builder: (BuildContext context) {
            return SafeArea(
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  padding: AppPaddings.lH.add(AppPaddings.lV),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppAnimatedColumn(
                        direction: Axis.horizontal,
                        duration: const Duration(milliseconds: 1000),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'upload_doc'.tr,
                            style: context.body1.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 1.22,
                            ),
                          ),
                          const AppSpacing(v: 30),
                          AppSelectField<String>(
                            disabled: false,
                            value: 'Passport',
                            labelText: 'iden_type'.tr.toUpperCase(),
                            validator: (String value) => null,
                            backgroundColor: context.colors.primary.shade100,
                            lableStyle: context.overline.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            titleBuilder: (_, String documentType) =>
                                documentType,
                            onChanged:
                                controller.onIdentificationTypeInputChanged,
                            options: documentTypes,
                          ),
                          const AppSpacing(v: 8),
                          AppTextInput(
                            disabled: false,
                            labelText: 'iden_number'.tr.toUpperCase(),
                            // initialValue: ,
                            backgroundColor: context.colors.primary.shade100,
                            lableStyle: context.overline.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            validator: controller.validateIdentificationNumber,
                            onChanged:
                                controller.onIdentificationNumberInputChanged,
                          ),
                          AppDatePicker(
                            labelText: 'exp_date'.tr.toUpperCase(),
                            backgroundColor: context.colors.primary.shade100,
                            lableStyle: context.overline.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            validator: controller.validateExpiryDate,
                            onDateTimeChanged:
                                controller.onExpiryDateInputChanged,
                          ),
                          const AppSpacing(v: 35),
                          UploadButton(
                            type: UploadButtonType.photos,
                            onFileSelected: controller.onFileSelected,
                            buttonText: 'doc_image'.tr,
                          ),
                          const AppSpacing(v: 49),
                          Obx(
                            () => AppButton(
                              enabled: controller.documentFormIsValid,
                              borderRadius: AppBorderRadius.largeAll,
                              onPressed: () =>
                                  controller.uploadUserIdentification(context),
                              child: Text('next'.tr.toUpperCase()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
