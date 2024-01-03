import 'package:betticos/common/common.dart';
import 'package:betticos/constants/constants.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
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
      Get.offAllNamed<void>(AppRoutes.home);
      menuController.changeActiveItemTo(AppRoutes.explore);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ResponsiveWidget.isSmallScreen(context)
            ? CircleAvatar(backgroundColor: Colors.white, radius: 50, child: Image.asset(AssetImages.logo))
            : const LoadingLogo(),
      ),
    );
  }
}
