import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BetticosApp extends StatelessWidget {
  const BetticosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? widget) => GetMaterialApp(
        initialRoute: AppRoutes.splash,
        getPages: Pages.pages,
        translations: AppStrings(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        title: 'Xviral',
        theme: AppTheme(AppLightTheme()).data,
      ),
    );
  }
}
