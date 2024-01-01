import 'dart:async';
import 'package:betticos/features/presentation.dart';
import 'package:betticos/main_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import 'core/core.dart';
import 'features/auth/presentation/forgotPassword/getx/forgot_bindings.dart';
import 'features/auth/presentation/login/getx/login_bindings.dart';
import 'features/auth/presentation/register/getx/register_bindings.dart';
import 'features/auth/presentation/resetPassword/getx/reset_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAzvRUUfl7-8tObQkzgtqPp7a870EJ_I_U',
      authDomain: 'betticos.firebaseapp.com',
      projectId: 'betticos',
      storageBucket: 'betticos.appspot.com',
      messagingSenderId: '356955805793',
      appId: '1:356955805793:web:56a09c92dac8827a32f220',
    ),
  );

  MainBindings.dependencies();

  Get.put(NavigationController());
  Get.put(AppMenuController());
  SettingsBindings.dependencies();
  SplashBindings.dependencies();
  WalletBindings.dependencies();
  LiveScoreBindings.dependencies();
  OnBoardBindings.dependencies();
  BaseBindings.dependencies();
  ProfileBindings.dependencies();
  TimelineBindings.dependencies();
  AdsBinding.dependencies();
  SalesBindings.dependencies();
  SharesBinding.dependencies();
  ContributionBindings.dependencies();
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
  FutureOr<void> report({required StackTrace stackTrace, required Object error, Object? extra}) async {}

  @override
  void log(Object object) {
    AppLog.i(object);
  }
}
