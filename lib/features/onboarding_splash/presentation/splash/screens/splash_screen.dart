import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/settings/presentation/settings/getx/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/core.dart';
import '/features/onboarding_splash/presentation/splash/getx/splash_controller.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = '/splash';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SettingsController sController = Get.find<SettingsController>();
  final SplashController controller = Get.find<SplashController>();

  @override
  void initState() {
    sController.getLanguagePreference();
    Future<void>.delayed(const Duration(seconds: 1), () {
      controller.isUserAuthenticated(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ResponsiveWidget.isSmallScreen(context)
            ? CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: Image.asset(
                  AssetImages.logo,
                ),
              )
            : const LoadingLogo(),
      ),
    );
  }
}
