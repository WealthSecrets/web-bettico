import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MainBindings {
  static void dependencies() {
    Get.put<Dio>(
      Dio(
        BaseOptions(
          baseUrl: environment.url,
          connectTimeout: const Duration(milliseconds: 40000),
          receiveTimeout: const Duration(milliseconds: 40000),
          headers: <String, dynamic>{'Content-Type': 'application/json'},
        ),
      ),
      permanent: true,
    );

    Get.put<SharedPreferencesWrapper>(SharedPreferencesWrapper(), permanent: true);

    Get.put<SettingsLocalDataSource>(SettingsLocalDataSourceImpl(Get.find()), permanent: true);

    Get.put<AuthLocalDataSource>(AuthLocalDataSourceImpl(Get.find()), permanent: true);

    Get.put<OnBoardLocalDataSource>(OnBoardLocalDataSourceImpl(Get.find()), permanent: true);

    Get.put<AppHTTPClient>(DioHTTPClient(authLocalDataSource: Get.find(), client: Get.find()), permanent: true);

    Get.put<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(client: Get.find()), permanent: true);

    Get.put<BetticosRemoteDataSource>(BetticosRemoteDataSourceImpl(client: Get.find()), permanent: true);

    Get.put<P2pRemoteDataSource>(P2pRemoteDataSourceImpl(client: Get.find()), permanent: true);

    Get.put<OkxRemoteDataSources>(OkxRemoteDataSourcesImpl(client: Get.find()), permanent: true);

    Get.put<AdvertRemoteDataSource>(AdvertRemoteDataSourceImpl(client: Get.find()), permanent: true);

    Get.put<OnBoardRepository>(OnBoardRepositoryImpl(onBoardLocalDataSource: Get.find()), permanent: true);

    Get.put<SettingsRepository>(SettingsRepositoryImpl(settingsLocalDataSource: Get.find()), permanent: true);

    Get.put<AuthRepository>(
      AuthRepositoryImpl(authLocalDataSource: Get.find(), authRemoteDataSource: Get.find()),
      permanent: true,
    );

    Get.put<BetticosRepository>(
      BetticosRepositoryImpl(authLocalDataSource: Get.find(), betticoslineRemoteDataSource: Get.find()),
      permanent: true,
    );

    Get.put<P2pRepository>(
      P2pRepositoryImpl(p2pRemoteDataSource: Get.find(), authLocalDataSource: Get.find()),
      permanent: true,
    );

    Get.put<OkxRepository>(
      OkxRepositoryImpl(okxRemoteDataSources: Get.find(), authLocalDataSource: Get.find()),
      permanent: true,
    );

    Get.put<AdvertRepository>(
      AdvertRepositoryImpl(advertRemoteDataSource: Get.find(), authLocalDataSource: Get.find()),
      permanent: true,
    );
  }
}
