import 'package:betticos/features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/core/core.dart';

class BetticosApp extends StatelessWidget {
  const BetticosApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? widget) => Padding(
        padding: const EdgeInsets.only(top: 60),
        child: GetMaterialApp(
          translations: AppStrings(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          title: 'Bettico',
          theme: AppTheme(AppLightTheme()).data,
          home: const SplashScreen(),
          getPages: Pages.pages,
        ),
      ),
    );
  }
}
