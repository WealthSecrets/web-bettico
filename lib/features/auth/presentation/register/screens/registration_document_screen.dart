import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const List<String> documentTypes = <String>['Passport', 'Voter ID', 'National Card', 'Driver\'s License'];

class RegistrationDocumentScreen extends GetWidget<RegisterController> {
  RegistrationDocumentScreen({super.key});

  final UserArgument? args = Get.arguments as UserArgument?;

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
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          backgroundColor: context.colors.background,
          body: Builder(
            builder: (BuildContext context) {
              return SafeArea(
                child: Center(
                  child: SizedBox(
                    width: ResponsiveWidget.isSmallScreen(context) ? double.infinity : 450,
                    child: SingleChildScrollView(
                      padding: AppPaddings.lH.add(AppPaddings.lV),
                      child: AppAnimatedColumn(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'upload_doc'.tr,
                            style: const TextStyle(fontWeight: FontWeight.w500, height: 1.22, fontSize: 16),
                          ),
                          const AppSpacing(v: 30),
                          AppSelectField<String>(
                            value: controller.identificationType.value,
                            labelText: 'iden_type'.tr.toUpperCase(),
                            validator: (String value) => null,
                            backgroundColor: context.colors.primary.shade100,
                            lableStyle:
                                TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                            titleBuilder: (_, String documentType) => documentType,
                            onChanged: controller.onIdentificationTypeInputChanged,
                            options: documentTypes,
                          ),
                          const AppSpacing(v: 8),
                          AppTextInput(
                            labelText: 'iden_number'.tr.toUpperCase(),
                            backgroundColor: context.colors.primary.shade100,
                            lableStyle:
                                TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                            validator: controller.validateIdentificationNumber,
                            onChanged: controller.onIdentificationNumberInputChanged,
                          ),
                          AppDatePicker(
                            labelText: 'exp_date'.tr.toUpperCase(),
                            backgroundColor: context.colors.primary.shade100,
                            lableStyle:
                                TextStyle(color: context.colors.primary, fontWeight: FontWeight.w700, fontSize: 10),
                            validator: controller.validateExpiryDate,
                            onDateTimeChanged: controller.onExpiryDateInputChanged,
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
                              onPressed: () => controller.uploadUserIdentification(context),
                              child: Text(
                                'next'.tr.toUpperCase(),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                if (args != null && args!.user != null) {
                                  if (!args!.user!.hasProfileImage) {
                                    Get.toNamed<void>(AppRoutes.profilePhoto);
                                  } else {
                                    Get.offAllNamed<void>(AppRoutes.home);
                                    menuController.changeActiveItemTo(AppRoutes.timeline);
                                  }
                                } else {
                                  Get.toNamed<void>(AppRoutes.profilePhoto);
                                }
                              },
                              child: Text(
                                'skip'.tr,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontWeight: FontWeight.bold, color: context.colors.primary, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
