import 'package:betticos/features/settings/domain/usecases/get_intro_prefs.dart';
import 'package:betticos/features/settings/domain/usecases/get_language_prefs.dart';
import 'package:betticos/features/settings/domain/usecases/update_intro_prefs.dart';
import 'package:betticos/features/settings/domain/usecases/update_language_prefs.dart';
import 'package:betticos/features/settings/presentation/settings/getx/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingsController(
        getIntroPrefs: GetIntroPrefs(
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
      ),
    );
  }
}

// class SettingsBindings {
//   static void dependencies() {
//     Get.lazyPut(
//       () => SettingsController(
//         getIntroPrefs: GetIntroPrefs(
//           settingsRepository: Get.find(),
//         ),
//         updateIntroPrefs: UpdateIntroPrefs(
//           settingsRepository: Get.find(),
//         ),
//         updateLanguagePrefs: UpdateLanguagePrefs(
//           settingsRepository: Get.find(),
//         ),
//         getLanguagePrefs: GetLanguagePrefs(
//           settingsRepository: Get.find(),
//         ),
//       ),
//     );
//   }
// }
