import 'package:betticos/features/auth/presentation/login/screens/login_screen.dart';
import 'package:betticos/features/onboarding_splash/presentation/splash/screens/splash_screen.dart';
import 'package:betticos/features/responsiveness/home_base_screen.dart';
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
          initialRoute: AppRoutes.splash,
          getPages: <GetPage<AppRoutes>>[
            GetPage<AppRoutes>(
              name: AppRoutes.home,
              page: () {
                return HomeBaseScreen();
              },
            ),
            GetPage<AppRoutes>(
              name: AppRoutes.login,
              page: () {
                return LoginScreen();
              },
            ),
            GetPage<AppRoutes>(
              name: AppRoutes.splash,
              page: () {
                return const SplashScreen();
              },
            ),
          ],
          translations: AppStrings(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          title: 'Bettico',
          theme: AppTheme(AppLightTheme()).data,
        ),
      ),
    );
  }
}
