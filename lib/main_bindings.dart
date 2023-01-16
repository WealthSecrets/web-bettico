// import 'dart:async';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/data/data_sources/betticos_remote_data_source.dart';
import 'package:betticos/features/betticos/data/data_sources/betticos_remote_data_source_impl.dart';
import 'package:betticos/features/betticos/data/repositories/betticos_repository_impl.dart';
import 'package:betticos/features/betticos/domain/repositories/betticos_repository.dart';
import 'package:betticos/features/betticos/presentation/timeline/getx/timeline_bindings.dart';
import 'package:betticos/features/okx_swap/data/data_sources/okx_remote_data_sources.dart';
import 'package:betticos/features/okx_swap/data/data_sources/okx_remote_data_sources_impl.dart';
import 'package:betticos/features/okx_swap/data/repositories/okx_repository_impl.dart';
import 'package:betticos/features/okx_swap/domain/repositories/okx_repository.dart';
import 'package:betticos/features/onboarding_splash/data/data_sources/onboard_local_data_source.dart';
import 'package:betticos/features/onboarding_splash/data/repositories/onboard_repository_impl.dart';
import 'package:betticos/features/onboarding_splash/domain/repositories/onboard_repository.dart';
import 'package:betticos/features/p2p_betting/data/data_sources/p2p_remote_data_source.dart';
import 'package:betticos/features/p2p_betting/data/data_sources/p2p_remote_data_source_impl.dart';
import 'package:betticos/features/p2p_betting/domain/repositories/p2p_repository.dart';
import 'package:betticos/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:betticos/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:betticos/features/settings/domain/repositories/settings_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/p2p_betting/data/repositories/p2p_repository_impl.dart';

// class MainBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put<Dio>(
//       Dio(
//         BaseOptions(
//           baseUrl: environment.url,
//           connectTimeout: 40000,
//           receiveTimeout: 40000,
//           headers: <String, dynamic>{
//             'Content-Type': 'application/json',
//           },
//         ),
//       ),
//       permanent: true,
//     );

//     Get.put<SharedPreferencesWrapper>(
//       SharedPreferencesWrapper(),
//       permanent: true,
//     );

//     Get.put<SettingsLocalDataSource>(
//       SettingsLocalDataSourceImpl(Get.find()),
//       permanent: true,
//     );

//     Get.put<AuthLocalDataSource>(
//       AuthLocalDataSourceImpl(Get.find()),
//       permanent: true,
//     );

//     Get.put<OnBoardLocalDataSource>(
//       OnBoardLocalDataSourceImpl(Get.find()),
//       permanent: true,
//     );

//     Get.put<AppHTTPClient>(
//       DioHTTPClient(
//         authLocalDataSource: Get.find(),
//         client: Get.find(),
//       ),
//       permanent: true,
//     );

//     Get.put<AuthRemoteDataSource>(
//       AuthRemoteDataSourceImpl(client: Get.find()),
//       permanent: true,
//     );

//     Get.put<BetticosRemoteDataSource>(
//       BetticosRemoteDataSourceImpl(client: Get.find()),
//       permanent: true,
//     );

//     Get.put<P2pRemoteDataSource>(
//       P2pRemoteDataSourceImpl(client: Get.find()),
//       permanent: true,
//     );

//     Get.put<OnBoardRepository>(
//       OnBoardRepositoryImpl(
//         onBoardLocalDataSource: Get.find(),
//       ),
//       permanent: true,
//     );

//     Get.put<SettingsRepository>(
//       SettingsRepositoryImpl(
//         settingsLocalDataSource: Get.find(),
//       ),
//       permanent: true,
//     );

//     Get.put<AuthRepository>(
//       AuthRepositoryImpl(
//         authLocalDataSource: Get.find(),
//         authRemoteDataSource: Get.find(),
//       ),
//       permanent: true,
//     );

//     Get.put<BetticosRepository>(
//       BetticosRepositoryImpl(
//         authLocalDataSource: Get.find(),
//         betticoslineRemoteDataSource: Get.find(),
//       ),
//       permanent: true,
//     );

//     Get.put<P2pRepository>(
//       P2pRepositoryImpl(
//         p2pRemoteDataSource: Get.find(),
//       ),
//       permanent: true,
//     );

//     TimelineBindings();
//   }
// }

class MainBindings {
  static void dependencies() {
    Get.put<Dio>(
      Dio(
        BaseOptions(
          baseUrl: environment.url,
          connectTimeout: 40000,
          receiveTimeout: 40000,
          headers: <String, dynamic>{
            'Content-Type': 'application/json',
          },
        ),
      ),
      permanent: true,
    );

    Get.put<SharedPreferencesWrapper>(
      SharedPreferencesWrapper(),
      permanent: true,
    );

    Get.put<SettingsLocalDataSource>(
      SettingsLocalDataSourceImpl(Get.find()),
      permanent: true,
    );

    Get.put<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(Get.find()),
      permanent: true,
    );

    Get.put<OnBoardLocalDataSource>(
      OnBoardLocalDataSourceImpl(Get.find()),
      permanent: true,
    );

    Get.put<AppHTTPClient>(
      DioHTTPClient(
        authLocalDataSource: Get.find(),
        client: Get.find(),
      ),
      permanent: true,
    );

    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(client: Get.find()),
      permanent: true,
    );

    Get.put<BetticosRemoteDataSource>(
      BetticosRemoteDataSourceImpl(client: Get.find()),
      permanent: true,
    );

    Get.put<P2pRemoteDataSource>(
      P2pRemoteDataSourceImpl(client: Get.find()),
      permanent: true,
    );

    Get.put<OkxRemoteDataSources>(
      OkxRemoteDataSourcesImpl(client: Get.find()),
      permanent: true,
    );

    Get.put<OnBoardRepository>(
      OnBoardRepositoryImpl(
        onBoardLocalDataSource: Get.find(),
      ),
      permanent: true,
    );

    Get.put<SettingsRepository>(
      SettingsRepositoryImpl(
        settingsLocalDataSource: Get.find(),
      ),
      permanent: true,
    );

    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        authLocalDataSource: Get.find(),
        authRemoteDataSource: Get.find(),
      ),
      permanent: true,
    );

    Get.put<BetticosRepository>(
      BetticosRepositoryImpl(
        authLocalDataSource: Get.find(),
        betticoslineRemoteDataSource: Get.find(),
      ),
      permanent: true,
    );

    Get.put<P2pRepository>(
      P2pRepositoryImpl(
        p2pRemoteDataSource: Get.find(),
      ),
      permanent: true,
    );

    Get.put<OkxRepository>(
      OkxRepositoryImpl(
        okxRemoteDataSources: Get.find(),
      ),
      permanent: true,
    );

    TimelineBindings();
  }
}
