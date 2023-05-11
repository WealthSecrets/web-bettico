import 'package:betticos/features/betticos/data/models/post/post_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/special_category_type.dart';

enum Gender { both, male, female }

class AdsController extends GetxController {
  AdsController();

  RxInt currentStep = 0.obs;
  Rx<RangeValues> rangeValues = const RangeValues(18, 65).obs;
  RxList<CountryCode> countries = <CountryCode>[].obs;
  Rx<Gender> gender = Gender.both.obs;
  Rx<SpecialCategoryType> category = SpecialCategoryType.unknown.obs;
  RxBool isSpecialAdCategory = false.obs;
  RxBool runUntilPaused = false.obs;
  Rx<Post> post = Post.mock().obs;
  RxInt amount = 1.obs;
  RxInt duration = 1.obs;
  RxInt maxAmount = 1000.obs;

  void addCountry(CountryCode? code) {
    if (code != null && !countryExists(code)) {
      countries.add(code);
    }
  }

  bool countryExists(CountryCode code) {
    final CountryCode? value =
        countries.firstWhereOrNull((CountryCode c) => c.name == code.name);
    if (value != null) {
      return true;
    }
    return false;
  }

  void removeCountry(CountryCode code) {
    countries.remove(code);
  }
}
