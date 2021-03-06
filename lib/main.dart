import 'dart:async';

import 'package:betticos/core/presentation/web_controllers/menu_controller.dart';
import 'package:betticos/core/presentation/web_controllers/navigation_controller.dart';
import 'package:betticos/features/auth/presentation/forgotPassword/getx/forgot_bindings.dart';
import 'package:betticos/features/auth/presentation/login/getx/login_bindings.dart';
import 'package:betticos/features/auth/presentation/register/getx/register_bindings.dart';
import 'package:betticos/features/auth/presentation/resetPassword/getx/reset_bindings.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_bindings.dart';
import 'package:betticos/features/betticos/presentation/members/getx/members_bindings.dart';
import 'package:betticos/features/betticos/presentation/oddsters/getx/oddsters_bindings.dart';
import 'package:betticos/features/betticos/presentation/profile/getx/profile_bindings.dart';
import 'package:betticos/features/betticos/presentation/referral/getx/referral_bindings.dart';
import 'package:betticos/features/betticos/presentation/report/getx/report_bindings.dart';
import 'package:betticos/features/betticos/presentation/timeline/getx/card_bindings.dart';
import 'package:betticos/features/betticos/presentation/timeline/getx/timeline_bindings.dart';
import 'package:betticos/features/onboarding_splash/presentation/onbaording/getx/onboard_bindings.dart';
import 'package:betticos/features/onboarding_splash/presentation/splash/getx/splash_bindings.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_bindings.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_binding.dart';
import 'package:betticos/features/settings/presentation/settings/getx/settings_bindings.dart';
import 'package:betticos/main_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ClassBuilder.registerClasses();

  MainBindings.dependencies();

  Get.put(NavigationController());
  Get.put(MenuController());
  SplashBindings.dependencies();
  OnBoardBindings.dependencies();
  RegisterBindings.dependencies();
  BaseBindings.dependencies();
  ProfileBindings.dependencies();
  LoginBindings.dependencies();
  ForgotBindings.dependencies();
  ResetBindings.dependencies();
  TimelineBindings.dependencies();
  SettingsBindings.dependencies();

  MembersBindings.dependencies();
  OddstersBindings.dependencies();
  ReferralBindings.dependencies();
  CardBindings.dependencies();
  ReportBindings.dependencies();
  P2PBetBindings.dependencies();
  LiveScoreBindings.dependencies();

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
  FutureOr<void> report(
      {required StackTrace stackTrace,
      required Object error,
      Object? extra}) async {
    // TODO: Sentry or Crashlytics
  }

  @override
  void log(Object object) {
    AppLog.i(object);
  }
}
