import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';

import '/core/core.dart';

class SettingsRepositoryImpl extends Repository implements SettingsRepository {
  SettingsRepositoryImpl({
    required this.settingsLocalDataSource,
  });

  final SettingsLocalDataSource settingsLocalDataSource;

  @override
  Future<Either<Failure, void>> updateIntroPrefs(bool value) async {
    final Either<Failure, void> result = await makeLocalRequest(() => settingsLocalDataSource.updateIntroPrefs(value));
    return result;
  }

  @override
  Future<Either<Failure, void>> updatePostIntroPrefs(bool value) async {
    final Either<Failure, void> result =
        await makeLocalRequest(() => settingsLocalDataSource.updatePostIntroPrefs(value));
    return result;
  }

  @override
  Future<Either<Failure, bool?>> getIntroPrefs() async {
    final Either<Failure, bool?> response = await makeLocalRequest(settingsLocalDataSource.getIntroPrefs);
    return response;
  }

  @override
  Future<Either<Failure, bool?>> getPostIntroPrefs() async {
    final Either<Failure, bool?> response = await makeLocalRequest(settingsLocalDataSource.getPostIntroPrefs);
    return response;
  }

  @override
  Future<Either<Failure, void>> updateLanguagePrefs(String value) async {
    final Either<Failure, void> result =
        await makeLocalRequest(() => settingsLocalDataSource.updateLanguagePrefs(value));
    return result;
  }

  @override
  Future<Either<Failure, String?>> getLanguagePrefs() async {
    final Either<Failure, String?> response = await makeLocalRequest(settingsLocalDataSource.getLanguagePrefs);
    return response;
  }
}
