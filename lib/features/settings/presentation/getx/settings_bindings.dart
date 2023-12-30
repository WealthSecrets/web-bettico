import 'package:betticos/features/settings/domain/domain.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';

class SettingsBindings {
  static void dependencies() {
    Get.put(
      SettingsController(
        getIntroPrefs: GetIntroPrefs(
          settingsRepository: Get.find(),
        ),
        getPostIntroPrefs: GetPostIntroPrefs(
          settingsRepository: Get.find(),
        ),
        updateIntroPrefs: UpdateIntroPrefs(
          settingsRepository: Get.find(),
        ),
        updateLanguagePrefs: UpdateLanguagePrefs(
          settingsRepository: Get.find(),
        ),
        getLanguagePrefs: GetLanguagePrefs(
          settingsRepository: Get.find(),
        ),
        updatePostIntroPrefs: UpdatePostIntroPrefs(
          settingsRepository: Get.find(),
        ),
      ),
      permanent: true,
    );
  }
}
