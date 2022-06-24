// import 'package:betticos/core/presentation/helpers/responsiveness.dart';
import 'package:betticos/features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
// import 'package:betticos/features/responsiveness/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/core/core.dart';
// import '/main_bindings.dart';

class BetticosApp extends StatelessWidget {
  const BetticosApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? widget) => GetMaterialApp(
        translations: AppStrings(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        title: 'Bettico',
        theme: AppTheme(AppLightTheme()).data,
        // getPages: ResponsiveWidget.isSmallScreen(context) ? Pages.pages : null,
        // initialBinding: MainBindings(),
        home: const SplashScreen(),
      ),
    );
  }
}
