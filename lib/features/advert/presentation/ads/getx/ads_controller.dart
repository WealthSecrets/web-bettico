import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:betticos/features/advert/domain/requests/create_advert_request.dart';
import 'package:betticos/features/advert/domain/usecases/create_advert.dart';
import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/special_category_type.dart';

class AdsController extends GetxController {
  AdsController({required this.createAdvert});

  final CreateAdvert createAdvert;

  RxInt currentStep = 0.obs;
  Rx<RangeValues> rangeValues = const RangeValues(18, 65).obs;
  RxList<CountryCode> countries = <CountryCode>[].obs;
  Rx<Gender> gender = Gender.both.obs;
  Rx<SpecialCategoryType> category = SpecialCategoryType.unknown.obs;
  RxBool isSpecialAdCategory = false.obs;
  RxBool runUntilPaused = false.obs;
  Rx<Post> post = Post.empty().obs;
  RxInt budget = 1.obs;
  RxInt duration = 1.obs;
  RxInt maxAmount = 1000.obs;
  Rx<Category> selectedCategory = Category.other.obs;
  Rx<Target> selectedTarget = Target.views.obs;
  RxString location = 'Ghana'.obs;

  RxBool isCreatingAd = false.obs;

  void addCountry(CountryCode? code) {
    if (code != null && !countryExists(code)) {
      countries.add(code);
    }
  }

  bool countryExists(CountryCode code) {
    final CountryCode? value = countries.firstWhereOrNull((CountryCode c) => c.name == code.name);
    if (value != null) {
      return true;
    }
    return false;
  }

  void removeCountry(CountryCode code) {
    countries.remove(code);
  }

  void addAdvert(BuildContext context) async {
    isCreatingAd.value = true;

    if (post.value.id.isEmpty) {
      return AppSnacks.show(context, message: 'Post for ad was not selected');
    }

    final Either<Failure, Advert> failureOrSuccess = await createAdvert(
      CreateAdvertRequest(
        post: post.value.id,
        budget: budget.value,
        ageRange: const AgeRange(minimum: 18, maximum: 65),
        category: selectedCategory.value,
        target: selectedTarget.value,
        gender: gender.value,
        location: location.value,
        duration: duration.value,
      ),
    );

    failureOrSuccess.fold(
      (Failure failure) {
        isCreatingAd.value = false;
      },
      (Advert ad) {
        isCreatingAd.value = true;
        AppSnacks.show(context,
            message: 'You have successfully created an ad.',
            leadingIcon: const Icon(Ionicons.checkmark_circle_sharp, color: Colors.white, size: 20),
            backgroundColor: context.colors.success);
      },
    );
  }

  void reset() {
    post.value = Post.empty();
    budget.value = 1;
    duration.value = 1;
    gender.value = Gender.both;
    location.value = 'Ghana';
  }
}
