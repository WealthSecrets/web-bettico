// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:betticos/features/settings/presentation/settings/getx/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    value: Text(controller.isLanguage.value == 'en' ? '🇨🇳' : '🇺🇸'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: controller.updateIntroductionPreference,
                    initialValue: controller.isIntro.value,
                    leading: const Icon(Icons.book_online_outlined),
                    title: Text('enable_tut'.tr),
                  ),
                  SettingsTile.navigation(
                    title: const Text('Certik'),
                    onPressed: (BuildContext context) {
                      js.context.callMethod(
                        'open',
                        <String>['https://drive.google.com/file/d/1CpaYubbMAY377_bBVHW7x1PBvv2kliVK/view'],
                      );
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Audit'),
                    onPressed: (BuildContext context) {
                      js.context.callMethod(
                        'open',
                        <String>['https://drive.google.com/file/d/189LTkNlKGKJhOUvnktuAIrrJHnPn3UO3/view'],
                      );
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Whitepaper'),
                    onPressed: (BuildContext context) {
                      js.context.callMethod(
                        'open',
                        <String>['https://drive.google.com/drive/folders/1vXyezl7lrtgpo8lmOlMkO7n9DLkuGDkW'],
                      );
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Buy WSC'),
                    onPressed: (BuildContext context) {
                      js.context.callMethod('open', <String>['https://staking.wealthsecrets.io/swap']);
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Store'),
                    onPressed: (BuildContext context) {
                      js.context.callMethod('open', <String>['https://wealthsecrets.store/']);
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Advertise'),
                    onPressed: (BuildContext context) {
                      js.context.callMethod('open', <String>['https://www.wealthsecrets.io/advertiseRequest']);
                    },
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
