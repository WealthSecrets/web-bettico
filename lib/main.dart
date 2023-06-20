import 'dart:async';

import 'package:betticos/core/presentation/web_controllers/menu_controller.dart';
import 'package:betticos/core/presentation/web_controllers/navigation_controller.dart';
import 'package:betticos/features/advert/presentation/ads/getx/professional_bindings.dart';
import 'package:betticos/main_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import 'core/core.dart';
import 'features/advert/presentation/ads/getx/ads_bindings.dart';
import 'features/auth/presentation/forgotPassword/getx/forgot_bindings.dart';
import 'features/auth/presentation/login/getx/login_bindings.dart';
import 'features/auth/presentation/register/getx/register_bindings.dart';
import 'features/auth/presentation/resetPassword/getx/reset_bindings.dart';
import 'features/betticos/presentation/base/getx/base_screen_bindings.dart';
import 'features/betticos/presentation/explore/getx/explore_bindings.dart';
import 'features/betticos/presentation/explore/getx/market_rate/market_rate_bindings.dart';
import 'features/betticos/presentation/explore/getx/sports/sports_bindings.dart';
import 'features/betticos/presentation/members/getx/members_bindings.dart';
import 'features/betticos/presentation/oddsters/getx/oddsters_bindings.dart';
import 'features/betticos/presentation/private_sales/getx/sales_bindings.dart';
import 'features/betticos/presentation/profile/getx/profile_bindings.dart';
import 'features/betticos/presentation/referral/getx/referral_bindings.dart';
import 'features/betticos/presentation/report/getx/report_bindings.dart';
import 'features/betticos/presentation/timeline/getx/card_bindings.dart';
import 'features/betticos/presentation/timeline/getx/timeline_bindings.dart';
import 'features/okx_swap/presentation/funds/getx/funds_bindings.dart';
import 'features/okx_swap/presentation/getx/okx_bindings.dart';
import 'features/okx_swap/presentation/usdt/getx/usdt_sale_bindings.dart';
import 'features/okx_swap/presentation/withdrawal/getx/withdrawal_bindings.dart';
import 'features/onboarding_splash/presentation/onbaording/getx/onboard_bindings.dart';
import 'features/onboarding_splash/presentation/splash/getx/splash_bindings.dart';
import 'features/p2p_betting/presentation/livescore/getx/live_score_bindings.dart';
import 'features/p2p_betting/presentation/p2p_betting/getx/p2pbet_binding.dart';
import 'features/settings/presentation/settings/getx/settings_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAzvRUUfl7-8tObQkzgtqPp7a870EJ_I_U',
        authDomain: 'betticos.firebaseapp.com',
        projectId: 'betticos',
        storageBucket: 'betticos.appspot.com',
        messagingSenderId: '356955805793',
        appId: '1:356955805793:web:56a09c92dac8827a32f220'),
  );

  MainBindings.dependencies();

  Get.put(NavigationController());
  Get.put(AppMenuController());
  SettingsBindings.dependencies();
  SplashBindings.dependencies();
  LiveScoreBindings.dependencies();
  OnBoardBindings.dependencies();
  BaseBindings.dependencies();
  ProfileBindings.dependencies();
  TimelineBindings.dependencies();
  AdsBinding.dependencies();
  SalesBindings.dependencies();
  LoginBindings.dependencies();
  RegisterBindings.dependencies();
  OkxBindigns.dependencies();
  UsdtSaleBinding.dependencies();
  WithdrawalBindings.dependencies();
  FundsBindings.dependencies();

  ForgotBindings.dependencies();
  ResetBindings.dependencies();
  P2PBetBindings.dependencies();

  ExploreBindings.dependencies();
  SportsBindings.dependencies();
  MarketRateBindings.dependencies();

  MembersBindings.dependencies();
  OddstersBindings.dependencies();
  ReferralBindings.dependencies();

  ProfessionalBindings.dependencies();
  CardBindings.dependencies();
  ReportBindings.dependencies();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  final ErrorReporter errorReporter = ErrorReporter(client: _ReporterClient());
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    logListener(
      onReleaseModeException: errorReporter.report,
    ),
  );

  ErrorBoundary(
    isReleaseMode: !environment.isDebugging,
    errorViewBuilder: (_) => const ErrorView(),
    onException: AppLog.e,
    child: const BetticosApp(),
  );
}

class _ReporterClient implements ReporterClient {
  _ReporterClient();

  @override
  FutureOr<void> report({required StackTrace stackTrace, required Object error, Object? extra}) async {
    // TODO: Sentry or Crashlytics
  }

  @override
  void log(Object object) {
    AppLog.i(object);
  }
}
