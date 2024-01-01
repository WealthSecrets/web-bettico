import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/domain/requests/create_business_request.dart';
import 'package:betticos/features/advert/presentation/utils/business_category_type.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/responsiveness/constants/web_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:validators/validators.dart' as validator;

import '../../data/models/business_model.dart';
import '../../domain/usecases/create_business.dart';

enum BusinessType { creator, business }

class ProfessionalController extends GetxController {
  ProfessionalController({required this.createBusiness});

  final CreateBusiness createBusiness;

  Rx<BusinessCategoryType> category = BusinessCategoryType.unknown.obs;
  Rx<BusinessType> businessType = BusinessType.creator.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString bio = ''.obs;
  RxString website = ''.obs;
  RxString location = ''.obs;

  RxBool isUpdatingBusinessType = false.obs;
  RxBool isCreatingBusiness = false.obs;

  bool get isBusinessCategoryValid => category.value != BusinessCategoryType.unknown;

  final BaseScreenController baseScreenController = Get.find<BaseScreenController>();

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email != null && !validator.isEmail(email.trim())) {
      errorMessage = 'Invalid email';
    }

    return errorMessage;
  }

  void addBusiness(BuildContext context) async {
    isCreatingBusiness.value = true;

    final Either<Failure, Business> failureOrSuccess = await createBusiness(
      CreateBusinessRequest(
        category: category.value,
        type: businessType.value,
        email: email.value.isNotEmpty ? email.value.trim() : null,
        phone: phone.value.isNotEmpty ? phone.value.trim() : null,
        bio: bio.value.isNotEmpty ? bio.value.trim() : null,
        website: website.value.isNotEmpty ? website.value.trim() : null,
        location: location.value.isNotEmpty ? location.value.trim() : null,
      ),
    );

    failureOrSuccess.fold(
      (_) {
        isCreatingBusiness.value = false;
        AppSnacks.show(context, message: _.message);
      },
      (Business business) {
        isCreatingBusiness.value = false;
        baseScreenController.user.value = business.user;
        navigationController.popUntil(AppRoutes.profile);
        AppSnacks.show(
          context,
          message: 'Your account is now a profession account.',
          leadingIcon: const Icon(Ionicons.checkmark_circle_sharp, color: Colors.white, size: 20),
          backgroundColor: context.colors.success,
        );
      },
    );
  }
}
