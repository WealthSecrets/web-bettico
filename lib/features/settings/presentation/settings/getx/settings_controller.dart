import 'dart:ui';

import 'package:betticos/features/settings/domain/requests/update_intro_request.dart';
import 'package:betticos/features/settings/domain/requests/update_language_request.dart';
import 'package:betticos/features/settings/domain/usecases/get_intro_prefs.dart';
import 'package:betticos/features/settings/domain/usecases/get_language_prefs.dart';
import 'package:betticos/features/settings/domain/usecases/update_intro_prefs.dart';
import 'package:betticos/features/settings/domain/usecases/update_language_prefs.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '/core/errors/failure.dart';
import '/core/usecase/usecase.dart';

class SettingsController extends GetxController {
  SettingsController({
    required this.updateLanguagePrefs,
    required this.updateIntroPrefs,
    required this.getIntroPrefs,
    required this.getLanguagePrefs,
  });

  final UpdateIntroPrefs updateIntroPrefs;
  final UpdateLanguagePrefs updateLanguagePrefs;
  final GetIntroPrefs getIntroPrefs;
  final GetLanguagePrefs getLanguagePrefs;

  RxBool isIntro = true.obs;
  RxString isLanguage = 'en'.obs;

  @override
  void onInit() {
    getIntroductionPreference();
    super.onInit();
  }

  void updateIntroductionPreference(bool value) async {
    isIntro(value);
    final Either<Failure, void> failureOrVoid =
        await updateIntroPrefs(UpdateIntroRequest(value: value));
    failureOrVoid.fold((Failure failure) {}, (_) {
      isIntro(value);
    });
  }

  void getIntroductionPreference() async {
    final Either<Failure, bool?> failureOrIntro =
        await getIntroPrefs(NoParams());
    failureOrIntro.fold((Failure failure) {
      isIntro(true);
    }, (bool? value) {
      if (value != null) {
        isIntro(value);
      }
    });
  }

  void updateLanguagePreference(String value) async {
    isLanguage(value);
    final Either<Failure, void> failureOrVoid =
        await updateLanguagePrefs(UpdateLanguageRequest(value: value));
    failureOrVoid.fold((Failure failure) {}, (_) {
      isLanguage(value);
    });
    if (isLanguage.value == 'en') {
      await Get.updateLocale(const Locale('en', 'US'));
    } else {
      await Get.updateLocale(const Locale('zh', 'CN'));
    }
  }

  void getLanguagePreference() async {
    final Either<Failure, String?> failureOrLanguage =
        await getLanguagePrefs(NoParams());

    failureOrLanguage.fold((Failure failure) {
      isLanguage('en');
    }, (String? value) {
      if (value != null) {
        isLanguage(value);
      }
    });
    if (isLanguage.value == 'en') {
      await Get.updateLocale(const Locale('en', 'US'));
    } else {
      await Get.updateLocale(const Locale('zh', 'CN'));
    }
  }
}
