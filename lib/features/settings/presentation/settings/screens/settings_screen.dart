// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:betticos/features/settings/presentation/settings/getx/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import '/core/core.dart';

class SettingsScreen extends KFDrawerContent {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsController controller = Get.find<SettingsController>();
  // late bool intro = false;

  // Future<void> showTutorial() async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   intro = preferences.getBool('intro') ?? false;
  // }

  // void updatePref(bool value) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.setBool('intro', value);
  //   intro = preferences.getBool('intro') ?? false;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: widget.onMenuPressed,
          ),
          title: Text(
            'settings'.tr,
            style: context.body1.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        body: Obx(
          () => SettingsList(
            sections: <AbstractSettingsSection>[
              SettingsSection(
                title: Text('general'.tr),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: Text('lang'.tr),
                    onPressed: (BuildContext context) {
                      if (controller.isLanguage.value == 'en') {
                        controller.updateLanguagePreference('zh');
                      } else {
                        controller.updateLanguagePreference('en');
                      }
                    },
                    value: Text(
                        controller.isLanguage.value == 'en' ? '🇨🇳' : '🇺🇸'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: controller.updateIntroductionPreference,
                    initialValue: controller.isIntro.value,
                    leading: const Icon(Icons.book_online_outlined),
                    title: Text('enable_tut'.tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
